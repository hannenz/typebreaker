using Gtk;
using Granite.Widgets;
using Plank;

namespace TypeBreaker {


	public class SettingsDialog : Gtk.Dialog {

		protected GLib.Settings		settings;
		protected Gtk.SpinButton	work_time_hours_spin_button;
		protected Gtk.SpinButton	work_time_minutes_spin_button;
		protected Gtk.SpinButton	work_time_seconds_spin_button;
		protected Gtk.SpinButton	break_time_hours_spin_button;
		protected Gtk.SpinButton	break_time_minutes_spin_button;
		protected Gtk.SpinButton	break_time_seconds_spin_button;
		protected Gtk.SpinButton	postpone_time_hours_spin_button;
		protected Gtk.SpinButton	postpone_time_minutes_spin_button;
		protected Gtk.SpinButton	postpone_time_seconds_spin_button;
		protected Gtk.SpinButton	warn_time_hours_spin_button;
		protected Gtk.SpinButton	warn_time_minutes_spin_button;
		protected Gtk.SpinButton	warn_time_seconds_spin_button;
		protected Gtk.SpinButton	postpones_count_spin_button;
		

		public SettingsDialog() {
		
			settings = new GLib.Settings("com.github.hannenz.typebreaker");

			title = _("Settings");
			border_width = 10;

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
			work_time_hours_spin_button = new SpinButton.with_range (0, 10, 1);
			work_time_minutes_spin_button.orientation = Orientation.VERTICAL;
			work_time_minutes_spin_button.wrap = true;
			work_time_minutes_spin_button = new SpinButton.with_range (0, 60, 1);
			work_time_seconds_spin_button = new SpinButton.with_range (0, 60, 1);
			uint work_time = settings.get_int ("type-time");
			work_time_hours_spin_button.set_value (work_time / 3600);
			work_time_minutes_spin_button.set_value ((work_time % 3600) / 60);
			work_time_seconds_spin_button.set_value (work_time % 60);
			grid.attach(work_time_hours_spin_button, 1, row, 1, 1);
			grid.attach(work_time_minutes_spin_button, 2, row, 1, 1);
			grid.attach(work_time_seconds_spin_button, 3, row, 1, 1);
			row++;

			grid.attach (new Label (_("Break Time")), 0, row, 1, 1);
			break_time_hours_spin_button = new SpinButton.with_range (0, 10, 1);
			break_time_minutes_spin_button = new SpinButton.with_range (0, 60, 1);
			break_time_seconds_spin_button = new SpinButton.with_range (0, 60, 1);
			uint break_time = settings.get_int ("type-time");
			break_time_hours_spin_button.set_value (break_time / 3600);
			break_time_minutes_spin_button.set_value ((break_time % 3600) / 60);
			break_time_seconds_spin_button.set_value (break_time % 60);
			grid.attach(break_time_hours_spin_button, 1, row, 1, 1);
			grid.attach(break_time_minutes_spin_button, 2, row, 1, 1);
			grid.attach(break_time_seconds_spin_button, 3, row, 1, 1);
			row++;

			show_all();
		}

		private void connect_signals() {

			work_time_hours_spin_button.changed.connect ( () => {
				settings.set_int ("type-time", 
					(int) work_time_hours_spin_button.get_value () * 3600 +
					(int) work_time_minutes_spin_button.get_value () * 60 +
					(int) work_time_seconds_spin_button.get_value ()
				);
			});
			break_time_hours_spin_button.changed.connect ( () => {
				settings.set_int ("type-time", 
					(int) break_time_hours_spin_button.get_value () * 3600 +
					(int) break_time_minutes_spin_button.get_value () * 60 +
					(int) break_time_seconds_spin_button.get_value ()
				);
			});
		}
	}
}
