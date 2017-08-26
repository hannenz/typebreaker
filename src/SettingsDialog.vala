using Gtk;
using Granite.Widgets;
using Plank;

namespace TypeBreaker {


	public class SettingsDialog : Gtk.Dialog {

		protected GLib.Settings		settings;

		protected TimePeriodWidget work_time_widget;
		protected TimePeriodWidget break_time_widget;
		protected TimePeriodWidget warn_time_widget;
		protected TimePeriodWidget postpone_time_widget;
		protected Gtk.SpinButton   postpones_count_spin_button;



		public SettingsDialog() {
			title = _("Settings");
			border_width = 10;

			settings = new GLib.Settings("com.github.hannenz.typebreaker");

			create_widgets();
			connect_signals();
		}



		private void create_widgets() {
			var content_area = get_content_area();
			var grid = new Gtk.Grid();

			grid.set_row_spacing(10);
			grid.set_column_spacing(10);

			content_area.pack_start(grid);
			add_button(_("Close"), ResponseType.CLOSE);

			int row = 0;

			grid.attach (new Label (_("Active Time")), 0, row, 1, 1);
			work_time_widget = new TimePeriodWidget (settings.get_int ("type-time"));
			grid.attach (work_time_widget, 1, row, 1, 1);
			row++;

			grid.attach (new Label (_("Break Time")), 0, row, 1, 1);
			break_time_widget = new TimePeriodWidget (settings.get_int ("break-time"));
			grid.attach (break_time_widget, 1, row, 1, 1);
			row++;

			grid.attach (new Label (_("Warn Time")), 0, row, 1, 1);
			warn_time_widget = new TimePeriodWidget (settings.get_int ("warn-time"));
			grid.attach (warn_time_widget, 1, row, 1, 1);
			row++;

			grid.attach (new Label (_("Postpone Time")), 0, row, 1, 1);
			postpone_time_widget = new TimePeriodWidget (settings.get_int ("postpone-time"));
			grid.attach (postpone_time_widget, 1, row, 1, 1);
			row++;

			grid.attach (new Label (_("Nr. of postpones")), 0, row, 1, 1);
			postpones_count_spin_button = new SpinButton (new Adjustment (0, 0, 10, 1, 1, 1), 1, 0);
			postpones_count_spin_button.set_value (settings.get_int ("postpones"));
			grid.attach (postpones_count_spin_button, 1, row, 1, 1);

			show_all();
		}



		private void connect_signals() {
			work_time_widget.value_changed.connect ( (time_value) => {
				settings.set_int ("type-time", (int) time_value);
			});
			break_time_widget.value_changed.connect ( (time_value) => {
				settings.set_int ("break-time", (int) time_value);
			});
			warn_time_widget.value_changed.connect ( (time_value) => {
				settings.set_int ("warn-time", (int) time_value);
			});
			postpone_time_widget.value_changed.connect ( (time_value) => {
				settings.set_int ("postpone-time", (int) time_value);
			});
			postpones_count_spin_button.value_changed.connect ( () => {
				settings.set_int ("postpones", postpones_count_spin_button.get_value_as_int ());
			});
		}
	}
}
