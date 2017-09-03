using GLib;
using Gtk;

namespace TypeBreaker {



	public enum State {
		IDLE,
		ACTIVE
	}



	/**
	 * @class KeyGrabber
	 *
	 * Gets idle time from underlying system (using the C function `get_idle_time`)
	 * and emits variuos signals based on the user's activity
	 */
	public class KeyGrabber : GLib.Object {



		// Signals

		/**
		 * Emitted when going from idle state to active state
		 */
		public signal void activity_begin();

		/**
		 * Emitted when going from active state to idle state
		 */
		public signal void idle_begin();

		/**
		 * Emitted when idle time has reached break time,
		 * e.g. the user has done an appropriate break
		 */
		public signal void break_completed ();



		// Public properties

		public uint break_time;

		/**
		 * The current activity state
		 */
		public State state { get; set; default = State.ACTIVE; }

		/**
		 * Interval to check for idle_time.
		 * By default we use a rather long interval to 
		 * be more insensitive for "false activities", e.g.
		 * bumping the table moves the mouse etc.
		 */
		public uint interval { get; set; default = 500; }


		private  DBusProxy screensaver_proxy;

		// Non-public properties

		/**
		 * @var uint
		 * Seconds that the user is idle
		 */
		private  uint idle_time;

		/**
		 * @var bool
		 * Flag if break has been completed
		 */
		private bool break_has_completed = false;



		public KeyGrabber(uint break_time) {

			this.break_time = break_time;

			Timeout.add (interval, () => {

				/* idle_time = get_idle_time(); */
				idle_time = get_idle_time ();
				/* Plank.Logger.notification ("Idle time: %u".printf (idle_time)); */

				if (idle_time < 1) {
					// User is active
					break_has_completed = false;

					if (state == State.IDLE) {
						state = State.ACTIVE;
						activity_begin();
					}
				}
				else {
					// User is idle
					if (state == State.ACTIVE) {
						state = State.IDLE;
						idle_begin();
					}
				}

				// Check if user has completed an appropriate break yet
				if (idle_time > this.break_time && !break_has_completed){

					break_has_completed = true;
					break_completed();
				}

				// runs forever...
				return true;

			}, Priority.DEFAULT_IDLE);
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
