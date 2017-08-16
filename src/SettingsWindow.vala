using Granite.Widgets;

namespace TypeBreaker {

	public class SettingsWindow : Gtk.Window {

		public SettingsWindow() {

			var timepicker = new Granite.Widgets.TimePicker();
			this.add(timepicker);
			this.show_all();
		}
	}
}
