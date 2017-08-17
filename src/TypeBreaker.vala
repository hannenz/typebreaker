using Gtk;

namespace TypeBreaker {



	public enum State {
		IDLE,
		ACTIVE
	}
	


	/**
	 * @class Breaker
	 *
	 * The main application
	 */
	public class Breaker : Gtk.Application { // Shouldn't this rather be Gdk.Application??


		public signal void have_a_break();
		public signal void warn_break();

		public uint work_time;
		public uint warn_time;
		public uint break_time;
		public uint postpones;
		public uint postpone_time;

		public DBusProxy screensaver_proxy;

		private GLib.Settings settings;

		private Timer timer;
		private uint timeout_id;
		private bool has_been_warned;
		// Do we still need this at all?
		private bool is_idle;

		private KeyGrabber key_grabber;
		private BreakWindow break_window;

		private FileIcon icon_play;
		private FileIcon icon_pause;
		private FileIcon icon_warning;
		private FileIcon icon_time;

		private State state = State.ACTIVE;




		public Breaker () {
			Object (
				application_id: "com.github.hannenz.typebreaker",
				/* flags: ApplicationFlags.IS_SERVICE */
				flags: ApplicationFlags.FLAGS_NONE
			);

			icon_play = new FileIcon(File.new_for_path("/usr/share/icons/hicolor/48x48/apps/typebreaker-play.png"));
			icon_pause = new FileIcon(File.new_for_path("/usr/share/icons/hicolor/48x48/apps/typebreaker-pause.png"));
			icon_warning = new FileIcon(File.new_for_path("/usr/share/icons/hicolor/48x48/apps/typebreaker-warning.png"));
			icon_time = new FileIcon(File.new_for_path("/usr/share/icons/hicolor/48x48/apps/typebreaker-time.png"));


			/* icon = new Gtk.Image.from_file("/usr/share/icons/hicolor/48x48/apps/typebreaker.png"); */
		}



		protected override void activate () {

			// Send notification
			var notification = new Notification("Type Breaker");
			notification.set_body("Hoola Hoop, man!");
			notification.set_icon(icon_play);
			send_notification("typebreaker.notification.work", notification);


			this.timer = new Timer();
			this.timer.start();
			this.timeout_id = Timeout.add(1000, main_poll);

			this.settings = new GLib.Settings("com.github.hannenz.typebreaker");

			this.work_time = settings.get_int("type-time");
			this.warn_time = settings.get_int("warn-time");
			this.break_time = settings.get_int("break-time");
			this.postpones = settings.get_int("postpones");
			this.postpone_time = settings.get_int("postpone-time");

			// Allow hot changing settings
			settings.changed.connect( (key) => {
				debug ("Change in settings key <%s> detected", key);
				switch (key) {
					case "type-time":
						this.work_time = settings.get_int(key);
						debug ("work_time has been updated to %u", this.work_time);
						break;
					case "warn-time":
						this.warn_time = settings.get_int(key);
						debug ("warn_time has been updated to %u", this.warn_time);
						break;
					case "break-time":
						this.break_time = settings.get_int(key);
						debug ("break_time has been updated to %u", this.break_time);
						break;
					case "postpones":
						this.postpones = settings.get_int(key);
						debug ("postpones has been updated to %u", this.postpones);
						break;
					case "postpone-time":
						this.postpone_time = settings.get_int(key);
						debug ("postpone_time has been updated to %u", this.postpone_time);
						break;
				}
			});

			debug ("type time:    %u\n", this.work_time);
			debug ("warn time:    %u\n", this.warn_time);
			debug ("break time:    %u\n", this.break_time);
			debug ("postpones:    %u\n", this.postpones);
			debug ("postpone time:    %u\n", this.postpone_time);

			this.break_window = null;

			this.key_grabber = new KeyGrabber(break_time);
			this.key_grabber.break_completed.connect(on_break_completed);
			key_grabber.activity_begin.connect( () => {
				state = State.ACTIVE;
				debug ("Going ACTIVE");
			});
			key_grabber.idle_begin.connect( () => {
				state = State.IDLE;
				debug ("Going IDLE");
			});

			this.have_a_break.connect(take_break);
			this.warn_break.connect(on_warn_break);

			this.screensaver_proxy = null;
			this.has_been_warned = false;

			break_window = new BreakWindow(this.break_time, this.postpones, this.postpone_time);
			break_window.lock_screen_requested.connect(on_lock_screen_requested);
			break_window.postpone_requested.connect(on_postpone_requested);
			break_window.countdown_finished.connect(on_break_completed);

			// Only in debugging mode: Quit app if qxit button has been clicked
			break_window.exit_application.connect(quit);

			add_window(this.break_window);
			var swin = new SettingsWindow();
			add_window(swin);
			
			swin.show_all();
			

			// only for debugging
			/* take_break(); */

			/* on_break_completed(); */
		}



		private void take_break(){
			break_window.show_all();
		}



		private void on_break_completed(){

			debug ("Break has been completed");

			// Reset postpones 
			this.postpones = settings.get_int("postpones");

			this.timer.start(); // Will reset the timer!
			this.has_been_warned = false;
			this.break_window.hide();

			// Send notification
			var t = new TimeString();
			var notification = new Notification("Type Breaker");
			notification.set_body("Happy hacking for the next %s".printf(t.nice(work_time / 60)));
			notification.set_icon(icon_play);
			send_notification("typebreaker.notification.work", notification);

		}



		private void on_warn_break(){

			if (this.warn_time > 0){

				var t = new TimeString();
				var notification = new Notification("Type Breaker");
				notification.set_icon(icon_warning);
				notification.set_body("Attention, attention! KeyBreaker will shut down your keyboard in %s".printf(t.nice(warn_time)));
				this.send_notification("typebreaker.notification.warn", notification);
				has_been_warned = true;

			}
		}



		private DBusProxy get_screensaver_proxy(){

			DBusConnection connection = null;

			if (this.screensaver_proxy != null){
				return this.screensaver_proxy;
			}
			try {
				connection = Bus.get_sync(BusType.SESSION, null);
				screensaver_proxy = new DBusProxy.sync(connection,
					DBusProxyFlags.DO_NOT_LOAD_PROPERTIES |
					DBusProxyFlags.DO_NOT_CONNECT_SIGNALS |
					DBusProxyFlags.DO_NOT_AUTO_START,
					null,
					"org.gnome.ScreenSaver",
					"/org/gnome/ScreenSaver",
					"org.gnome.ScreenSaver",
					null
				);
			}
			catch (Error e){
				stderr.printf("Error: %s", e.message);
				return (DBusProxy)null;
			}

			return this.screensaver_proxy;
		}



		private void on_lock_screen_requested(){
			DBusProxy proxy = get_screensaver_proxy();
			if (proxy == null){
				return;
			}
			Gdk.keyboard_ungrab(0);
			proxy.call("Lock", new Variant("()"), DBusCallFlags.NONE, -1, null);
		}



		private void on_postpone_requested(){

			this.break_window.hide();
			timer.start();

			// show notification
			string mssg = "Postponed typing break by %u seconds!".printf(this.postpone_time);
			var notification = new Notification("Type Breaker");
			/* TODO: Better icon: Something with a clock! */
			notification.set_icon(icon_time);
			notification.set_body(mssg);
			this.send_notification("typebreaker.notification.postpone", notification);

			var postpone_countdown = new Countdown(postpone_time);
			postpone_countdown.finished.connect( () => {
				this.have_a_break();
			});
		}



		public bool main_poll () {

			uint seconds_elapsed = (uint)this.timer.elapsed();

			debug ("Seconds elapsed since timer start: %u", seconds_elapsed);

			if ((seconds_elapsed >= this.work_time - this.warn_time) && !has_been_warned){
				debug ("Uh oh! Time to warn the user...\n");
				this.warn_break();
			}

			if (seconds_elapsed >= this.work_time){

				debug ("Time for a break!");
				this.have_a_break();
			}

			return true;
		}



		// Do we still need this at all?
		public void on_activity () {
			debug("Activity detected!");
			this.is_idle = false;
		}
	}
}
