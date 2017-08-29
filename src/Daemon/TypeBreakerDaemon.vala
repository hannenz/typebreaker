using TypeBreaker.Window;

namespace TypeBreaker.Daemon {
	
	public class TypeBreakerDaemon : Gtk.Application {

		public TypeBreaker.Settings settings;
		public BreakManager manager;

		public BreakWindow break_window;

		private int postpones_left;
		


		// Constructor
		public TypeBreakerDaemon () {
			Object (
				application_id: "cmo.github.hannenz.typebreaker",
				flags: ApplicationFlags.NON_UNIQUE
			);

			/* set_inactivity_timeout (1000); */

		}



		~TypeBreakerDaemon () {
			release ();
		}





		public override void startup () {
			message ("TypeBreakerDaemon started");
			base.startup ();

			settings = new Settings ();
			manager = new BreakManager (this);

			hold ();

			Timeout.add (1000, manager.check_break);
		}



		public override void activate () {
			message ("TypeBreakerDaemon activated");

			break_window = new BreakWindow ();
			// TODO: What if the window just hides itself?
			// Why so complicated??
			break_window.countdown_finished.connect ( manager.handle_break_completed);
			break_window.postpone_requested.connect ( manager.handle_postpone);
			break_window.lock_screen_requested.connect (manager.handle_lock_screen);
			this.add_window (break_window);
		}



		public override bool dbus_register (DBusConnection connection, string object_path) throws Error {
			return true;
		}
	}

	/* private void on_bus_aquired (DBusConnection conn) { */
	/* 	try { */
    /*  */
	/* 		conn.register_object ("/com/github/hannenz/typebreaker", new TypeBreakerDaemon ()); */
	/* 	} */
	/* 	catch (IOError e) { */
	/* 		stderr.printf ("Could not register service\n"); */
	/* 	} */
	/* } */
    /*  */


	public static int main (string[] args) {
		var app = new TypeBreakerDaemon ();

		try {
			app.register ();
		}
		catch (Error e) {
			error ("Couldn't register application");
		}

		// DBus
		/* Bus.own_name (BusType.SESSION, "com.github.hannenz.typebreaker", BusNameOwnerFlags.NONE, on_bus_aquired, () => {}, () => stderr.printf ("Could not aquire name\n")); */

		return app.run (args);
	}
}