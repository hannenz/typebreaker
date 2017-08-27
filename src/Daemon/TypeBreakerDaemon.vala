namespace TypeBreaker.Daemon {
	
	public class TypeBreakerDaemon : GLib.Application {

		public Settings settings;
		public BreakManager manager;
		


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
			manager = new BreakManager ();

			hold ();

			Timeout.add (1000, manager.check_break);
		}



		public override void activate () {
			message ("TypeBreakerDaemon activated");
		}



		public override bool dbus_register (DBusConnection connection, string object_path) throws Error {
			return true;
		}
	}



	public static int main (string[] args) {
		var app = new TypeBreakerDaemon ();

		try {
			app.register ();
		}
		catch (Error e) {
			error ("Couldn't register application");
		}

		return app.run (args);
	}
}
