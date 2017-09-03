namespace TypeBreaker {

	/**
	  * @class ScreenLocker
	  * 
	  * Provide possibility to lock the screen
	  */
	public class ScreenLocker {

		public DBusProxy screensaver_proxy;



		/**
		  * Constructor
		  */
		public ScreenLocker () {
			this.screensaver_proxy = null;
		}



		/**
		  * Lock the screen
		  *
		  * @return void
		  * @access public
		  */
		public void lock () {
			DBusProxy proxy = get_screensaver_proxy ();
			if (proxy == null) {
				return;
			}
			Gdk.keyboard_ungrab (0);
			proxy.call ("Lock", new Variant("()"), DBusCallFlags.NONE, -1, null);
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
