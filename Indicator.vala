using Gtk;

namespace TypeBreaker {

	public class Indicator : Wingpanel.Indicator {

		private Gtk.Image? display_widget = null;

		public static TypeBreaker.Daemon.Settings settings;

		public Indicator () {
			Object(
				code_name: "typebreaker",
				display_name: "Type Breaker",
				description: "Forces you to take regular breaks"
			)

			settings = new TypeBreaker.Daemon.Settings ();

			this.visible = true;
		}



		// Get the icon
		public override Widget get_display_widget () {
			if (display_widget == null) {
				display_widget = new Image ();
				display_widget.pixel_size = 24;
				update_icon ();
			}

			return display_widget;
			
		}


		// Get the popover
		public override Widget? get_widget () {
			return null;
		}

	}
}
