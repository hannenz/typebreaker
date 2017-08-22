using Gtk;
using Granite.Widgets;

namespace TypeBreaker {

	public class SettingsWindow : Gtk.Window {

		private GLib.Settings settings;

		public SettingsWindow() {

			settings = new GLib.Settings("com.github.hannenz.typebreaker");


			set_default_size(400, 400);

			var grid = new Grid();

			var timepicker = new Granite.Widgets.TimePicker();


			grid.attach(new Label("Break time"), 0, 0, 1, 1);
			grid.attach(timepicker, 1, 0, 1, 1);


			this.add(grid);
			this.show_all();
		}
	}
}
