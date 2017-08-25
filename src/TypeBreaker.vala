// modules: gtk+-3.0

using Gtk;

namespace TypeBreaker {



	/**
	 * @class Breaker
	 *
	 * The main application
	 */
	public class Breaker : Gtk.Application { // Shouldn't this rather be Gdk.Application??


		// Public properties
		public uint work_time;
		public uint warn_time;
		public uint break_time;
		public uint postpones;
		public uint postpone_time;




		// Private properties
		private GLib.Settings settings;

		private Timer timer;
		private uint timeout_id = 0;
		private bool has_been_warned;

		private KeyGrabber key_grabber;
		private BreakWindow break_window;
		private ScreenLocker screen_locker;

		private FileIcon icon_play;
		private FileIcon icon_pause;
		private FileIcon icon_warning;
		private FileIcon icon_time;



		private bool flag = false;

		/**
		  * Constructor
		  */
		public Breaker () {
			Object (
				application_id: "com.github.hannenz.typebreaker",
				/* flags: ApplicationFlags.IS_SERVICE */
				flags: ApplicationFlags.FLAGS_NONE
			);

			icon_play = new FileIcon (File.new_for_path("/usr/share/icons/hicolor/48x48/apps/typebreaker-play.png"));
			icon_pause = new FileIcon (File.new_for_path("/usr/share/icons/hicolor/48x48/apps/typebreaker-pause.png"));
			icon_warning = new FileIcon (File.new_for_path("/usr/share/icons/hicolor/48x48/apps/typebreaker-warning.png"));
			icon_time = new FileIcon (File.new_for_path("/usr/share/icons/hicolor/48x48/apps/typebreaker-time.png"));

		}



		/**
		  * On application activation, e.g. startup / init
		  * Set-up everything
		  */
		protected override void activate () {

			timer = new Timer ();
			/* this.timer.start (); */
			/* this.timeout_id = Timeout.add (1000, main_poll); */

			settings = new GLib.Settings ("com.github.hannenz.typebreaker");
			screen_locker = new ScreenLocker ();

			work_time = settings.get_int ("type-time");
			warn_time = settings.get_int ("warn-time");
			break_time = settings.get_int ("break-time");
			postpones = settings.get_int ("postpones");
			postpone_time = settings.get_int ("postpone-time");

			// Allow hot changing settings
			settings.changed.connect( (key) => {
				debug ("Change in settings key <%s> detected", key);
				switch (key) {
					case "type-time":
						work_time = settings.get_int (key);
						debug ("work_time has been updated to %u", work_time);
						break;
					case "warn-time":
						warn_time = settings.get_int (key);
						debug ("warn_time has been updated to %u", warn_time);
						break;
					case "break-time":
						break_time = settings.get_int (key);
						debug ("break_time has been updated to %u", break_time);
						break;
					case "postpones":
						postpones = settings.get_int (key);
						debug ("postpones has been updated to %u", postpones);
						break;
					case "postpone-time":
						postpone_time = settings.get_int (key);
						debug ("postpone_time has been updated to %u", postpone_time);
						break;
				}
			});

			debug ("type time:    %u\n", work_time);
			debug ("warn time:    %u\n", warn_time);
			debug ("break time:    %u\n", break_time);
			debug ("postpones:    %u\n", postpones);
			debug ("postpone time:    %u\n", postpone_time);

			break_window = null;


			// Setup keygrabber and connect to its signals
			key_grabber = new KeyGrabber (break_time);
			key_grabber.break_completed.connect (on_break_completed);
			key_grabber.activity_begin.connect (on_activity_begin);
			/* key_grabber.idle_begin.connect ( () => { */
			/* 	debug ("Going IDLE"); */
			/* }); */


			this.has_been_warned = false;

			break_window = new BreakWindow (this.break_time, this.postpones, this.postpone_time);
			break_window.lock_screen_requested.connect (screen_locker.lock);
			break_window.postpone_requested.connect (on_postpone_requested);
			break_window.countdown_finished.connect (on_break_completed);

			// Only in debugging mode: Quit app if qxit button has been clicked
			break_window.exit_application.connect (quit);

			add_window (this.break_window);
			

			// only for debugging
			string[] envp = Environ.get ();
			if (Environ.get_variable (envp, "G_MESSAGES_DEBUG") != null) {
				/* take_break(); */
			}

			/* on_break_completed(); */
		}



		private void take_break () {
			// block main polling
			flag = true;
			break_window.show_all ();
			stop_polling ();
		}


		private void on_activity_begin () {
			debug ("Going ACTIVE");

			if (!flag) {
				if (this.timeout_id == 0) {
					this.timeout_id = GLib.Timeout.add (1000, main_poll);
					timer.start ();
				}
			}
		}

		private void on_break_completed (){

			debug ("Break has been completed");

			// Reset postpones 
			this.postpones = settings.get_int ("postpones");

			/* this.timer.start (); // Will reset the timer! */
			this.has_been_warned = false;
			this.break_window.hide ();

			stop_polling ();

			// Send notification
			var t = new TimeString ();
			var notification = new Notification ("Type Breaker");
			notification.set_body (_("Happy hacking for the next %s").printf (t.nice (work_time / 60)));
			notification.set_icon (icon_play);
			send_notification ("typebreaker.notification.work", notification);

			flag = true;

		}



		private void warn_break (){

			if (this.warn_time > 0){
 
				var t = new TimeString ();
				var notification = new Notification ("Type Breaker");
				notification.set_icon (icon_warning);
				notification.set_body (_("Attention, attention! KeyBreaker will shut down your keyboard in %s").printf (t.nice (warn_time)));
				this.send_notification("typebreaker.notification.warn", notification);
				has_been_warned = true;

			}
		}



		private void on_postpone_requested(){

			// On postpone we assume, that -- no matter what --
			// The next break will happen after <postpone-time> seconds
			// (even if in the meantime a <break-time> length idle time happens)
			// So we stop polling and start an own countdown

			flag = true;
			this.break_window.hide ();
			stop_polling ();

			// show notification
			var t = new TimeString ();
			string mssg = _("Typing break postponed by %s").printf (t.nice (this.postpone_time));
			var notification = new Notification  ("Type Breaker");
			notification.set_icon (icon_time);
			notification.set_body (mssg);
			this.send_notification ("typebreaker.notification.postpone", notification);

			var postpone_countdown = new Countdown (postpone_time);
			postpone_countdown.tick.connect ( (sec, prgr) => {
				debug ("Postpone - tick: %u seconds, %.2f", sec, prgr);
			});
			postpone_countdown.finished.connect ( () => {
				take_break ();
			});
			postpone_countdown.start ();
		}


		/**
		  * Main polling loop
		  *
		  * Will watch for elapsed time if it is time for a break or to warn
		  * the user
		  *
		  * @return boolean			Always true (keep GLib.Source/Timeout running)
		  * @access protected
		  */
		protected bool main_poll () {

			uint seconds_elapsed = (uint)this.timer.elapsed ();

			var t = new TimeString ();
			debug ("Time until break: %s".printf ( t.nice (work_time - seconds_elapsed)));

			if ((seconds_elapsed >= this.work_time - this.warn_time) && !has_been_warned){
				debug ("Uh oh! Time to warn the user...\n");
				warn_break ();
			}

			if (seconds_elapsed >= this.work_time){
				debug ("Time for a break!");
				take_break ();
			}

			return true;
		}



		/**
		  * Stop the main polling loop
		  *
		  * @return void
		  * @access private
		  */
		private void stop_polling () {
			if (this.timeout_id > 0) {
				GLib.Source.remove (this.timeout_id);
				this.timeout_id = 0;
			}
		}
	}



	// Main: Launch app
	int main (string[] args){

		var app = new Breaker ();
		return app.run ();
	}
}
