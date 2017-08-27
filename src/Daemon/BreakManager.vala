using TypeBreaker.Window;


namespace TypeBreaker.Daemon {

	
	public class BreakManager  {

		public Settings settings;

		protected Countdown time_until_break;

		private TypeBreakerDaemon app;
		private DBusProxy screensaver_proxy;
		private bool countdown_is_running = false;
		private int postpones_left;



		public BreakManager (TypeBreakerDaemon app) {
			this.app = app;
			settings = new Settings ();

			setup ();
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


		/**
		 * Called periodically (poll) from TypeBreakerDaemon
		 */
		public bool check_break () {

			/* message ("Idle time: %u", get_idle_time ()); */
			message ("Time until break: %u", time_until_break.seconds_left);

			uint idle_time = get_idle_time ();
			if (idle_time > settings.break_time) {
				time_until_break.stop ();
				countdown_is_running = false;
			}

			if (idle_time < 2 && !countdown_is_running) {
				time_until_break.start ();
				countdown_is_running = true;
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
			return (uint)session_idle_time;
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
				return (DBusProxy)null;
			}

			return this.screensaver_proxy;
		}
	}
}
