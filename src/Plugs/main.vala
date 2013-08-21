using Gtk;
using Pantheon;

public class TypeBreakerSettings : Pantheon.Switchboard.Plug {

	GLib.Settings settings;

	public int type_time;
	public int warn_time;
	public int break_time;
	public int postpones;
	public int postpone_time;

	public TypeBreakerSettings(){

		settings = new GLib.Settings("org.pantheon.typebreaker");

		type_time = settings.get_int("type-time");
		warn_time = settings.get_int("warn-time");
		break_time = settings.get_int("break-time");
		postpones = settings.get_int("postpones");
		postpone_time = settings.get_int("postpone-time");


		var grid = new Gtk.Grid();
		grid.margin = 12;
		grid.row_spacing = 12;
		grid.column_spacing = 12;
		grid.column_homogeneous = false;

		var label = new Label("Type time (seconds)");
		label.set_alignment(1.0f, 0.5f);
		grid.attach(label, 0, 0, 1, 1);
		var type_time_entry = new Gtk.SpinButton.with_range(1, 180*60, 1);
		grid.attach(type_time_entry, 1, 0, 1, 1);
		type_time_entry.set_value(this.type_time);
		type_time_entry.value_changed.connect( (entry) => {
			settings.set_int("type-time", entry.get_value_as_int());
		});

		label = new Label("Warn time (seconds)");
		label.set_alignment(1.0f, 0.5f);
		grid.attach(label, 0, 1, 1, 1);
		var warn_time_entry = new Gtk.SpinButton.with_range(1, 180*60, 1);
		grid.attach(warn_time_entry, 1, 1, 1, 1);
		warn_time_entry.set_value(this.warn_time);
		warn_time_entry.value_changed.connect( (entry) => {
			settings.set_int("warn-time", entry.get_value_as_int());
		});

		label = new Label("Break time (seconds)");
		label.set_alignment(1.0f, 0.5f);
		grid.attach(label, 0, 2, 1, 1);
		var break_time_entry = new Gtk.SpinButton.with_range(1, 180*60, 1);
		grid.attach(break_time_entry, 1, 2, 1, 1);
		break_time_entry.set_value(this.break_time);
		break_time_entry.value_changed.connect( (entry) => {
			settings.set_int("break-time", entry.get_value_as_int());
		});

		label = new Label("Number of allowed postpones");
		label.set_alignment(1.0f, 0.5f);
		grid.attach(label, 0, 3, 1, 1);
		var postpones_entry = new Gtk.SpinButton.with_range(0, 10, 1);
		grid.attach(postpones_entry, 1, 3, 1, 1);
		postpones_entry.set_value(this.postpones);
		postpones_entry.value_changed.connect( (entry) => {
			settings.set_int("postpones", entry.get_value_as_int());
		});

		label = new Label("Postpone time (seconds)");
		label.set_alignment(1.0f, 0.5f);
		grid.attach(label, 0, 4, 1, 1);
		var postpone_time_entry = new Gtk.SpinButton.with_range(1, 180*60, 1);
		grid.attach(postpone_time_entry, 1, 4, 1, 1);
		postpone_time_entry.set_value(this.postpone_time);
		postpone_time_entry.value_changed.connect( (entry) => {
			settings.set_int("postpone-time", entry.get_value_as_int());
		});

		grid.show_all();
		this.add(grid);
	}

	public static int main(string[] args){
		Gtk.init(ref args);
		var SwitchBoard_Plug = new TypeBreakerSettings();
		SwitchBoard_Plug.register("Typing Break");
		SwitchBoard_Plug.show_all();
		Gtk.main();
		return 0;
	}
}