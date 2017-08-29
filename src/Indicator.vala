using Gtk;
using Wingpanel;

namespace TypeBreaker {
	
	public class Indicator : Wingpanel.Indicator {

		public static TypeBreaker.Settings settings;


		private Image? display_widget = null;
		private Gtk.Grid? main_grid = null;


		public Indicator () {
			Object (
				code_name: "typebreaker",
				display_name: "Type Breaker",
				description: "A typing break monitor"
			);
			message ("TypeBreaker Indicator Constructor");

			settings = new TypeBreaker.Settings ();
			this.visible = true;
		}

		public override void opened () {
			//
		}

		public override void closed () {
			//
		}

		public override Widget get_display_widget () {
			message ("TypeBreaker Indicator get_display_widget");
			if (display_widget == null) {
				display_widget = new Image ();
				display_widget.pixel_size = 24;
				display_widget.icon_name = "media-playback-pause";
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

			var settings_button = new Wingpanel.Widgets.Button ("Break Settings");
			settings_button.clicked.connect (show_settings);

			var break_button = new Wingpanel.Widgets.Button ("Take a break");
			break_button.clicked.connect (take_break);

			main_grid.add (break_button);
			main_grid.add (settings_button);

			main_grid.show_all ();
		}

		private void show_settings () {
			message ("Showing the Settings");
		}

		private void take_break () {
			message ("Taking a break");
		}
	}
}

/*
* This method is called once after your plugin has been loaded.
* Create and return your indicator here if it should be displayed on the current server.
*/
public Wingpanel.Indicator? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
    /* A small message for debugging reasons */
    message ("Activating TypeBreaker Indicator");

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
