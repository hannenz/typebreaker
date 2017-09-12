using TypeBreaker.Window;

namespace TypeBreaker.Daemon {

	TypeBreakerDaemon app;
	
	public class TypeBreakerDaemon : Gtk.Application {

		public TypeBreaker.Settings settings;
		public BreakManager manager;
		public BreakWindow break_window;



		// Constructor
		public TypeBreakerDaemon () {
			Object (
				application_id: "com.github.hannenz.typebreaker",
				flags: ApplicationFlags.NON_UNIQUE
			);
		}



		~TypeBreakerDaemon () {
			release ();
		}



		public override void startup () {
			message ("startup ()");
			base.startup ();

			break_window = new BreakWindow ();
			settings = new Settings ();
			manager = new BreakManager (this);

			hold ();
			message ("leaving startup()");
		}



		public override void activate () {
			message ("activate ()");

			// Connect the window's signals
			break_window.countdown_finished.connect ( manager.handle_break_completed);
			break_window.postpone_requested.connect ( manager.handle_postpone);
			break_window.lock_screen_requested.connect (manager.handle_lock_screen);
			// Debugging obly...
			break_window.exit_application.connect ( quit );

			this.add_window (break_window);
			message ("leaving activate ()");
		}



		public override bool dbus_register (DBusConnection connection, string object_path) throws Error {
			return true;
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
		public void do_notify (string message, /*FileIcon icon, */string id) {
			var notification = new Notification ("Type Breaker");
			notification.set_body (message);

			// Test
			var icon = new FileIcon (File.new_for_uri("resource:///com/github/hannenz/typebreaker-daemon/typebreaker.png"));
			notification.set_icon (icon);
			this.send_notification ("typebreaker.notification." + id, notification);
		}
	}



	[DBus (name = "com.github.hannenz.typebreaker")]
	public  class TypeBreakerFoo : Object {

		public int idle_time;

		public void take_break () {
			message ("Taking a break now!");
		}

		public int get_idle_time () {
			return idle_time;
		}

		public TypeBreakerFoo () {
			idle_time = 9;
		}

	}

	private void on_bus_aquired (DBusConnection conn) {
		try {
			conn.register_object ("/com/github/hannenz/typebreaker", new BreakManager (app));
		}
		catch (IOError e) {
			stderr.printf ("Could not register service\n");
		}
	}



	public static int main (string[] args) {
		app = new TypeBreakerDaemon ();

		try {
			app.register ();
		}
		catch (Error e) {
			error ("Couldn't register application");
		}

		message ("own_name");
		// DBus
		Bus.own_name (
			BusType.SESSION, 
			"com.github.hannenz.typebreaker", 
			BusNameOwnerFlags.NONE,
			on_bus_aquired,
			() => {},
			() => stderr.printf ("Could not aquire name\n")
		);

		return app.run (args);
	}
}
