using Gtk;

namespace TypeBreaker {

	/* public class Breaker : GLib.Object { */
	public class Breaker : Gtk.Application {

		private GLib.Settings settings;

		public signal void have_a_break();
		public signal void warn_break();

		public uint work_time;
		public uint warn_time;
		public uint break_time;
		public uint postpones;
		public uint postpone_time;

		public DBusProxy screensaver_proxy;

		private Timer timer;
		private uint timeout_id;
		private bool has_been_warned;
		private bool is_idle;

		private KeyGrabber key_grabber;
		private BreakWindow break_window;

		public Breaker(){
			Object (
				application_id: "com.github.hannenz.typebreaker",
				flags: ApplicationFlags.FLAGS_NONE
			);
		}

		protected override void activate () {

			debug ("Application activate");

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
				switch (key) {
					case "type-time":
						this.work_time = settings.get_int(key);
						break;
					case "warn-time":
						this.warn_time = settings.get_int(key);
						break;
					case "break-time":
						this.break_time = settings.get_int(key);
						break;
					case "postpones":
						this.postpones = settings.get_int(key);
						break;
					case "postpone-time":
						this.postpone_time = settings.get_int(key);
						break;
				}
			});

			print ("type time:    %u\n", this.work_time);
			print ("warn time:    %u\n", this.warn_time);
			print ("break time:    %u\n", this.break_time);
			print ("postpones:    %u\n", this.postpones);
			print ("postpone time:    %u\n", this.postpone_time);

			this.break_window = null;

			this.key_grabber = new KeyGrabber();
			this.key_grabber.break_time = this.break_time;
			this.key_grabber.activity.connect(on_activity);
			this.key_grabber.break_completed.connect(on_break_completed);

			this.have_a_break.connect(take_break);
			this.warn_break.connect(on_warn_break);

			this.screensaver_proxy = null;
			this.has_been_warned = false;

			take_break();
		}

		private void take_break(){
			if (this.break_window == null){
				this.break_window = new BreakWindow(this.break_time, this.postpones);
				this.break_window.lock_screen_requested.connect(on_lock_screen_requested);
				this.break_window.postpone_requested.connect(on_postpone_requested);
				this.break_window.countdown_finished.connect(on_break_completed);
				this.break_window.run();
			}
		}

		private void on_break_completed(){
			debug ("BREAK HAS BEEN COMPLETED\n");
			this.timer.start();
			this.has_been_warned = false;
			if (this.break_window != null){
				this.break_window.destroy();
				this.break_window = null;
			}
		}

		private void on_warn_break(){
			if (this.warn_time > 0){
				try {
					string mssg = "Attention, attention! KeyBreaker will shut down your keyboard in %u seconds!".printf(this.warn_time);
					var notification = new Notification("Type Breaker");
					notification.set_body(mssg);
					this.send_notification("typebreaker.notification.warn", notification);
				}
				catch (Error e){
					stderr.printf("Failed to show notification: %s\n", e.message);
				}
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
			try {
				string mssg = "Postponed typing break by %u seconds!".printf(this.postpone_time);
				var notification = new Notification("Type Breaker");
				notification.set_body(mssg);
				this.send_notification("typebreaker.notification.postpone", notification);
			}
			catch (Error e){
				stderr.printf("Failed to show notification: %s\n", e.message);
			}

		}

		public bool main_poll(){

			uint seconds_elapsed = (uint)this.timer.elapsed();

			debug ("main_poll: %.f seconds elsapsed...\n", seconds_elapsed);

			if ((seconds_elapsed >= this.work_time - this.warn_time) && !has_been_warned){
				debug ("Uh oh! Time to warn the user...\n");
				this.warn_break();
				has_been_warned = true;
			}

			if (this.break_window != null){
				if (seconds_elapsed >= this.postpone_time){
					this.break_window.show();
				}
			}
			else {
				if (seconds_elapsed >= this.work_time){
					debug ("Time for a break!");
					this.have_a_break();
				}
			}
			return true;
		}

		public void on_activity(){
			this.is_idle = false;
		}
	}
}
