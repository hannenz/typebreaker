using TypeBreaker.Window;


namespace TypeBreaker.Daemon {

	
	public class BreakManager  {

		public Settings settings;

		private DBusProxy screensaver_proxy;

		protected Countdown time_until_break;

		private bool countdown_is_running = false;

		public BreakManager () {
			settings = new Settings ();

			time_until_break = new Countdown (settings.active_time);
			time_until_break.interval = 1000;
			time_until_break.finished.connect (take_break);
			time_until_break.start ();
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
			var break_window = new BreakWindow ();
			break_window.show ();
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
