using TypeBreaker.Window;

namespace TypeBreaker {
	public enum State {
		IDLE,
		ACTIVE
	}
}

namespace TypeBreaker.Daemon {

	const int ACTIVE_THRESHOLD = 2;

	[DBus (name = "com.github.hannenz.TypeBreakerService")]
	public class BreakManager  {

		public TypeBreaker.Settings settings;
		public uint idle_time;

		protected Countdown time_until_break;

		private TypeBreakerDaemon app;
		private DBusProxy screensaver_proxy;
		private bool countdown_is_running = false;
		private int postpones_left;
		private bool has_been_warned = false;

		private State state;



		public BreakManager (TypeBreakerDaemon app) {
			this.app = app;
			settings = new Settings ();

			state = get_idle_time() < ACTIVE_THRESHOLD ? State.IDLE : State.ACTIVE;

			setup ();


			app.do_notify ("This is the startip message", "xyz");
			/* debug ("Test Break"); */
			/* take_break (); */

			Timeout.add (1000, check_break);
		}



		public void setup () {

			time_until_break = new Countdown (settings.active_time);
			time_until_break.interval = 1000;
			time_until_break.finished.connect (take_break);
			time_until_break.start ();
			postpones_left = settings.postpones_count;
			app.break_window.enable_postponing ();
			countdown_is_running = true;
		}

		

		public int get_seconds_until_break () {
			return (int) time_until_break.seconds_left;
		}
			


		/**
		 * Called periodically (poll) from TypeBreakerDaemon
		 */
		private bool check_break () {
			message ("Time until break: %u", time_until_break.seconds_left);

			idle_time = get_idle_time ();
			/* message ("Idle time: %u", get_idle_time ()); */

			if (idle_time < ACTIVE_THRESHOLD && state == State.IDLE) {
				message ("Idle => Active");
				state = State.ACTIVE;
				if (!countdown_is_running) {
					time_until_break.start ();
				}
			}
			if (idle_time >= ACTIVE_THRESHOLD && state == State.ACTIVE) {
				message ("Active => Idle");
				state = State.IDLE;
			}

			if (idle_time >= settings.break_time) {
				if (countdown_is_running) {
					message ("Break has been completed, waiting for next activity to start the next countdown");
					time_until_break.stop ();
					countdown_is_running = false;
				}
			}

			if (!has_been_warned && time_until_break.seconds_left <= settings.warn_time) {
				app.do_notify ("This is the message", "xyz");
				has_been_warned = true;
			}

			return true;
		}



		// Show the break window, forcing a break.
		public void take_break () {
			app.break_window.show_all ();
			/* var break_window = new BreakWindow (); */
			/* break_window.show (); */
		}



		public void handle_break_completed () {
			app.break_window.hide ();
			setup ();
		}

		

		/**
		 * Handle postpone process
		 */
		public void handle_postpone () {
			var postpone_countdown = new Countdown (settings.postpone_time);
			postpone_countdown.finished.connect (take_break);
			postpone_countdown.start ();
			app.break_window.hide ();
			postpones_left--;
			if (postpones_left == 0) {
				app.break_window.disable_postponing ();
			}
		}


		public void handle_lock_screen () {
			try {
				var proxy = get_screensaver_proxy ();
				if (proxy == null) {
					return;
				}
				proxy.call_sync ("Lock", null, DBusCallFlags.NONE, -1, null);
			}
			catch (Error e) {
				warning (e.message);
			}
		}


		/**
		  * Get the session's idle time in seconds
		  * from DBus (org.freedesktop.ScreenSaver)
		  *
		  * @return uint
		  * @access public
		  */
		public uint get_idle_time () {
			uint64 session_idle_time = 0;

			try {
				var proxy = get_screensaver_proxy ();
				if (proxy == null) {
					return 0;
				}
				var variant = proxy.call_sync ("GetSessionIdleTime", null, DBusCallFlags.NONE, -1, null);
				var inner = variant.get_child_value (0);
				session_idle_time = inner.get_uint32 ();
			}
			catch (Error e) {
				warning (e.message);
			}
			return (uint) session_idle_time;
		}



		/**
		  * Get the screensacver DBusProxy
		  *
		  * @return DBusProxy
		  * @access private
		  */
		private DBusProxy get_screensaver_proxy () {

			DBusConnection connection = null;

			if (this.screensaver_proxy != null) {
				return this.screensaver_proxy;
			}
			try {
				connection = Bus.get_sync (BusType.SESSION, null);
				screensaver_proxy = new DBusProxy.sync (connection,
					DBusProxyFlags.DO_NOT_LOAD_PROPERTIES |
					DBusProxyFlags.DO_NOT_CONNECT_SIGNALS |
					DBusProxyFlags.DO_NOT_AUTO_START,
					null,
					"org.freedesktop.ScreenSaver",
					"/org/freedesktop/ScreenSaver",
					"org.freedesktop.ScreenSaver",
					null
				);
			}
			catch (Error e) {
				stderr.printf ("Error: %s", e.message);
				return (DBusProxy) null;
			}

			return this.screensaver_proxy;
		}
	}
}
