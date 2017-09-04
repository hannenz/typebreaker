using Gtk;
using Wingpanel;

namespace TypeBreaker {
	
	public class Indicator : Wingpanel.Indicator {

		public static TypeBreaker.Settings settings;

		private Wingpanel.Widgets.Switch active_switch;
		private Wingpanel.Widgets.Button break_button;
		private Wingpanel.Widgets.Button settings_button;
		private ProgressBar progress_bar;

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
					DBusProxyFlags.DO_NOT_CONNECT_SIGNALS |
					DBusProxyFlags.DO_NOT_AUTO_START,
					null,
					"com.github.hannenz.TypeBreakerService",
					"/com/github/hannenz/typebreaker",
					"com.github.hannenz.TypeBreakerService",
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
				display_widget = new Image.from_resource ("/com/github/hannenz/typebreaker/data/typebreaker-symbolic.png");
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

			info_label = new Label ("");
			info_label.margin_top = 6;
			info_label.margin_bottom = 6;
			/* info_label.margin_start = 12; */
			/* info_label.margin_end = 12; */
			update_time_until_break ();

			progress_bar = new ProgressBar ();
			progress_bar.set_show_text (true);

			active_switch = new Wingpanel.Widgets.Switch (_("Watch for breaks"));
			active_switch.set_active (settings.active);
			active_switch.switched.connect ( () => {
				settings.active = active_switch.get_active ();
				break_button.set_sensitive (settings.active); 
				if (!settings.active) {
					info_label.set_text("");
				}
				else {
					update_time_until_break ();
				}
			});
			
			break_button = new Wingpanel.Widgets.Button ("Take break");
			break_button.clicked.connect (take_break);

			settings_button = new Wingpanel.Widgets.Button ("Settings");
			settings_button.clicked.connect (show_settings);

			var separator = new Wingpanel.Widgets.Separator ();

			/* main_grid.add (info_label); */
			main_grid.add (progress_bar);
			main_grid.add (active_switch);
			main_grid.add (separator);
			main_grid.add (break_button);
			main_grid.add (settings_button);

			main_grid.show_all ();

			update_time_until_break ();
			Timeout.add (15000, () => {
				update_time_until_break ();
				return true;
			});
		}



		private void update_time_until_break () {
			int time_until_break;
			string text;

			var proxy = get_dbus_proxy ();
			if (proxy == null) {
				return;
			}
			var variant = proxy.call_sync ("GetSecondsUntilBreak", null, DBusCallFlags.NONE, -1, null);
			var inner = variant.get_child_value (0);
			time_until_break = inner.get_int32 ();

			if (time_until_break >= 60) {
				var t = new TypeBreaker.TimeString ();
				t.show_seconds = false;
				string s = t.nice (time_until_break);
				text = s + " until break";
			}
			else {
				text = "Less than 1 minute until break";
			}
			info_label.set_text (text);

			double frac = 1 - ((double) time_until_break / (double) settings.active_time);
			progress_bar.set_fraction (frac);
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
    /* A small warning for debugging reasons */
    warning ("Activating TypeBreaker Indicator");

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
