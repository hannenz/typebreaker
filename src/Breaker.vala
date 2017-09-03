using Gtk;

namespace TypeBreaker {

	/**
	  * @class Breaker
	  *
	  * The main class managing the break handling
	  */
	public class Breaker : Object {

		/**
		  * Emitted to signal the calling application
		  * that it should  quit
		  */
		public signal void quit ();



		// Public properties
		public uint work_time;
		public uint warn_time;
		public uint break_time;
		public uint postpones;
		public uint postpone_time;

		public uint seconds_elapsed;



		// Private properties
		private Gtk.Application app;
		private GLib.Settings settings;

		private Timer timer;
		private uint timeout_id = 0;
		private bool has_been_warned = false;

		public KeyGrabber key_grabber;
		public BreakWindow break_window;
		private ScreenLocker screen_locker;

		private FileIcon icon_play;
		private FileIcon icon_pause;
		private FileIcon icon_warning;
		private FileIcon icon_time;

		private MainLoop main_loop;


		// This flags if polling is allowed at the moment 
		// (polling needs to be blocked e.g. while break window 
		// is shown or while postponing
		// Couldn't come up with a better name, sorry..
		private bool flag = false;


		public Breaker (Gtk.Application? app) {

			this.app = app;

			timer = new Timer ();
			screen_locker = new ScreenLocker ();
			main_loop = new MainLoop ();

			// Get settings and 
			settings = new GLib.Settings ("com.github.hannenz.typebreaker");

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

			debug ("type time:     %u", work_time);
			debug ("warn time:     %u", warn_time);
			debug ("break time:    %u", break_time);
			debug ("postpones:     %u", postpones);
			debug ("postpone time: %u", postpone_time);

			break_window = new BreakWindow (this.break_time, this.postpones, this.postpone_time);
			break_window.lock_screen_requested.connect (screen_locker.lock);
			break_window.postpone_requested.connect (on_postpone_requested);
			break_window.countdown_finished.connect (on_break_completed);
			// Only in debugging mode: Quit app if qxit button has been clicked
			break_window.exit_application.connect ( () => {
				main_loop.quit ();
				quit ();
			});


			// Some icons
			icon_play = new FileIcon (File.new_for_path("/usr/share/icons/hicolor/48x48/apps/typebreaker-play.png"));
			icon_pause = new FileIcon (File.new_for_path("/usr/share/icons/hicolor/48x48/apps/typebreaker-pause.png"));
			icon_warning = new FileIcon (File.new_for_path("/usr/share/icons/hicolor/48x48/apps/typebreaker-warning.png"));
			icon_time = new FileIcon (File.new_for_path("/usr/share/icons/hicolor/48x48/apps/typebreaker-time.png"));
		}


		public void run () {
			// Setup keygrabber and connect to its signals
			key_grabber = new KeyGrabber (break_time);
			/* key_grabber.break_completed.connect (on_break_completed); */
			key_grabber.activity_begin.connect ( () => {
				on_activity_begin ();
			});

			//main_loop.run ();
		}



		public void take_break () {
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

			this.has_been_warned = false;
			this.break_window.hide ();

			stop_polling ();

			// Send notification
			var t = new TimeString ();
			do_notify (_("Happy hacking for the next %s").printf (t.nice (work_time / 60)),  icon_play, "work");
			flag = true;
		}






		private void warn_break (){

			if (this.warn_time > 0){
 
				var t = new TimeString ();
				do_notify (_("Attention, attention! KeyBreaker will shut down your keyboard in %s").printf (t.nice (warn_time)), icon_warning, "warn");
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
			do_notify (mssg, icon_time, "postpone");

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

			seconds_elapsed = (uint)this.timer.elapsed ();

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


		/**
		  * Send a notification
		  * 
		  * @param string		The message
		  * @param FileIcon		Icon
		  * @param string		id, something to distinguish notifications
		  *
		  * @return void
		  *
		  * @access public
		  */
		public void do_notify (string message, FileIcon icon, string id) {
			if (this.app != null) {
				var notification = new Notification ("Type Breaker");
				notification.set_body (message);
				notification.set_icon (icon);
				this.app.send_notification ("typebreaker.notification." + id, notification);
			}
			else {
				Plank.Logger.notification(message);
			}
		}
	}
}
