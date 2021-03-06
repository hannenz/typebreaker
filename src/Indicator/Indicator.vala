using Gtk;
using Wingpanel;
using Granite.Services;

namespace TypeBreaker {

	public class Indicator : Wingpanel.Indicator {

		public static TypeBreaker.Settings settings;

		private Wingpanel.Widgets.Switch active_switch;
		private Wingpanel.Widgets.Button break_button;
		private Wingpanel.Widgets.Button settings_button;
		/* private ProgressBar progress_bar; */
		private Revealer revealer;

		private Image? display_widget = null;
		private Gtk.Grid? main_grid = null;

		private DBusProxy proxy = null;
		private Label info_label;

		public Indicator () {
			Object (
				code_name: "typebreaker",
				display_name: "Type Breaker",
				description: "A typing break monitor"
			);

			/* const string app_name = "com.github.hannenz.typebreaker-indicator"; */
			/* Logger.initialize (app_name); */
			/* Logger.DisplayLevel = LogLevel.DEBUG; */
			/* Logger.notification ("Starting up Indicator: %s".printf (app_name)); */
            /*  */
			/* error ("typebreaker-indicator: QjHt"); */

			settings = new TypeBreaker.Settings ();
			this.visible = true;
		}


		private DBusProxy get_dbus_proxy () {
			DBusConnection connection = null;
			if (proxy != null) {
				return proxy;
			}
			try {
				connection = Bus.get_sync (BusType.SESSION, null);	// throws IOError
				proxy = new DBusProxy.sync (						// throws Error
					connection,
					DBusProxyFlags.DO_NOT_LOAD_PROPERTIES |
					DBusProxyFlags.DO_NOT_CONNECT_SIGNALS,
					null,
					"com.github.hannenz.typebreaker",
					"/com/github/hannenz/typebreaker",
					"com.github.hannenz.typebreaker",
					null
				);
			}
			catch (Error e) {
				error ("Error: %s", e.message);
				// proxy is still null, so we can fall thru and return it
			}

			return proxy;
		}

		public override void opened () {
			//
		}

		public override void closed () {
			//
		}

		public override Widget get_display_widget () {
			if (display_widget == null) {
				display_widget = new Image.from_resource ("/com/github/hannenz/typebreaker-indicator/typebreaker-symbolic.png");
			}

			return display_widget;
		}

		public override Widget? get_widget () {
			if (main_grid == null) {
				create_grid ();
			}
			return main_grid;
		}

		private void  create_grid () {
			main_grid = new Grid ();
			main_grid.set_orientation (Orientation.VERTICAL);

			info_label = new Label (_("Type Breaker is not running"));
			info_label.margin_top = 6;
			info_label.margin_bottom = 6;
			update_time_until_break ();

			revealer = new Revealer ();

			/* progress_bar = new ProgressBar (); */
			/* progress_bar.set_show_text (true); */

			active_switch = new Wingpanel.Widgets.Switch (_("Watch for breaks"));
			active_switch.set_active (settings.active);
			active_switch.switched.connect ( () => {
				settings.active = active_switch.get_active ();
				break_button.set_sensitive (settings.active); 
				revealer.set_reveal_child  (settings.active);

				if (!settings.active) {
					info_label.set_text("");
				}
				else {
					update_time_until_break ();
				}
			});
			settings.changed["active"].connect ( () => {
				active_switch.set_active (settings.active);
			});
			/* active_switch.set_sensitive (false); */

			
			break_button = new Wingpanel.Widgets.Button (_("Take break"));
			break_button.clicked.connect (take_break);

			settings_button = new Wingpanel.Widgets.Button (_("Settings"));
			settings_button.clicked.connect (show_settings);

			var separator = new Wingpanel.Widgets.Separator ();

			main_grid.add (active_switch);
			main_grid.add (separator);

			var inner_grid = new Grid ();
			inner_grid.set_orientation (Orientation.VERTICAL);
			inner_grid.add (info_label);
			inner_grid.add (break_button);
			revealer.add (inner_grid);

			main_grid.add (revealer);
			revealer.set_reveal_child (true);
			
			/* main_grid.add (info_label); */
			/* main_grid.add (progress_bar); */
			main_grid.add (inner_grid);
			main_grid.add (settings_button);

			main_grid.show_all ();

			update_time_until_break ();
			Timeout.add (5000, () => {
				update_time_until_break ();
				/* if (!check_daemon_running ()) { */
				/* 	info_label.set_text (_("Type Breaker is not running!")); */
				/* 	break_button.set_sensitive (false); */
				/* 	active_switch.set_sensitive (false); */
				/* } */
				/* else { */
				/* 	break_button.set_sensitive (true); */
				/* 	active_switch.set_sensitive (true); */
				/* } */

				return true;
			});
		}



		/**
		 * Check the list of DBus Services to see if the
		 * typebreaker daemon is running
		 * 
		 * @return bool
		 */
		/* private bool check_daemon_running () { */
		/* 	try { */
        /*  */
		/* 		var connection = GLib.Bus.get_sync (BusType.SESSION, null);	 */
		/* 		var ret = connection.call_sync ( */
		/* 			"org.freedesktop.DBus", */
		/* 			"/org/freedesktop/DBus", */
		/* 			"org.freedesktop.DBus", */
		/* 			"ListNames", */
		/* 			null, */
		/* 			VariantType.TUPLE, */
		/* 			DBusCallFlags.NONE, */
		/* 			-1, */
		/* 			null */
		/* 		); */
		/* 		var names = ret.get_child_value (0); */
		/* 		var iter = names.iterator (); */
        /*  */
		/* 		Variant? v = null; */
		/* 		while ((v = iter.next_value ()) != null) { */
		/* 			var name = v.get_string (); */
		/* 			if (name == "com.github.hannenz.typebreaker") { */
		/* 				return true; */
		/* 			} */
		/* 		} */
		/* 	} */
		/* 	catch (Error e) { */
		/* 		warning (e.message); */
		/* 		return false; */
		/* 	} */
        /*  */
		/* 	return false; */
		/* } */
        /*  */


		/**
		 * Try to launch the daemon
		 *
		 * // TODO: Somehow get it launched by DBus !!
		 *
		 * @return void
		 */
		/* private void launch_daemon () { */
			/* Pid child_pid; */
            /*  */
			/* try { */
			/* 	Process.spawn_async ( */
			/* 		"/", */
			/* 		{ "com.github.hannenz.typebreaker" }, */
			/* 		Environ.get (), */
			/* 		SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD | SpawnFlags.STDOUT_TO_DEV_NULL | SpawnFlags.STDERR_TO_DEV_NULL, */
			/* 		null, */
			/* 		out child_pid */
			/* 	); */
			/* 	ChildWatch.add (child_pid, (pid, status) => { */
			/* 		Process.close_pid (pid); */
			/* 	}); */
			/* } */
			/* catch (Error e) { */
			/* 	warning (e.message); */
			/* } */
		/* } */



		private void update_time_until_break () {
			int time_until_break;
			string text;

			if (!settings.active) {
				return;
			}

			var proxy = get_dbus_proxy ();
			if (proxy == null) {
				return;
			}
			try {
				var variant = proxy.call_sync ("GetSecondsUntilBreak", null, DBusCallFlags.NONE, -1, null);
				var inner = variant.get_child_value (0);
				time_until_break = inner.get_int32 ();

				if (time_until_break >= 60) {
					var t = new TypeBreaker.TimeString ();
					t.show_seconds = false;
					string s = t.nice (time_until_break);
					text = s + _(" until break");
				}
				else {
					text = _("Less than 1 minute until break");
				}
				info_label.set_text (text);

				/* double frac = 1 - ((double) time_until_break / (double) settings.active_time); */
				/* progress_bar.set_fraction (frac); */
			}
			catch (Error e) {
				warning (e.message);
			}
		}



		private void show_settings () {
			var dlg = new SettingsDialog ();
			dlg.run ();
			dlg.destroy ();
		}



		private void take_break () {
			try {
				var proxy = get_dbus_proxy ();
				proxy.call_sync ("TakeBreak", null, DBusCallFlags.NONE, -1, null);
				
			}
			catch (Error e) {
				error ("Error: %s", e.message);
			}
		}
	}
}


/*
* This method is called once after your plugin has been loaded.
* Create and return your indicator here if it should be displayed on the current server.
*/
public Wingpanel.Indicator? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {

	/* Logger.initialize ("com.github.hannenz.typebreaker-indicator"); */
	/* Logger.DisplayLevel = LogLevel.DEBUG; */
	/* Logger.notification ("Starting com.github.hannenz.typebreaker-indicator"); */
    /*  */
	/* GLib.Log.set_writer_func ((LogWriterFunc) GLib.Log.writer_journald); */
	

	debug ("typebreaker-foo");

	/* const string GETTEXT_PACKAGE = "typebreaker"; */

	/* Intl.setlocale (LocaleCategory.MESSAGES, ""); */
	/* Intl.textdomain (GETTEXT_PACKAGE); */
	/* Intl.bind_textdomain_codeset (GETTEXT_PACKAGE, "utf-8"); */
	/* Intl.bindtextdomain (GETTEXT_PACKAGE, "./locale"); */



    /* Check which server has loaded the plugin */
    if (server_type != Wingpanel.IndicatorManager.ServerType.SESSION) {
        /* We want to display our sample indicator only in the "normal" session, not on the login screen, so stop here! */
        return null;
    }

    /* Create the indicator */
    var indicator = new TypeBreaker.Indicator ();

    /* Return the newly created indicator */
    return indicator;
}
