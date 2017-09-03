using Gtk;

namespace TypeBreaker {

	/**
	 * @class TimePeriodWidget
	 *
	 * A widget to select a time period in seconds by selecting
	 * hours, minutes and seconds from spin buttons laid out
	 * horizontally
	 */
	public class TimePeriodWidget : Gtk.Bin {

		public signal void value_changed (uint time_value);

		public bool show_seconds;

		protected uint time_value;

		protected Box box;
		protected SpinButton hours_spin_button;
		protected SpinButton minutes_spin_button;
		protected SpinButton seconds_spin_button;


		public TimePeriodWidget (uint time_value, bool show_seconds = false) {

			this.time_value = time_value;
			this.show_seconds = show_seconds;

			create_widgets ();
			connect_signals ();
		}


		private void create_widgets () {

			var h_adj = new Adjustment (0, 0, 100, 1, 10, 1);
			var m_adj = new Adjustment (0, 0, 60, 1, 10, 1);
			var s_adj = new Adjustment (0, 0, 60, 1, 10, 1);

			hours_spin_button   = new SpinButton (h_adj, 1, 0);
			minutes_spin_button = new SpinButton (m_adj, 1, 0);
			seconds_spin_button = new SpinButton (s_adj, 1, 0);

			hours_spin_button.set_value (time_value / 3600);
			minutes_spin_button.set_value ((time_value % 3600) / 60);
			seconds_spin_button.set_value (time_value % 60);

			box = new Box (Orientation.HORIZONTAL, 0);

			box.pack_start (hours_spin_button, false, false, 0);
			box.pack_start (minutes_spin_button, false, false, 0);
			if (this.show_seconds) {
				box.pack_start (seconds_spin_button, false, false, 0);
			}

			this.add (box);
		}


		private void connect_signals () {

			hours_spin_button.output.connect (leading_zeros);
			minutes_spin_button.output.connect (leading_zeros);
			seconds_spin_button.output.connect (leading_zeros);

			hours_spin_button.value_changed.connect ( () => {
				update_time_value ();
				value_changed (this.time_value);
			});
			minutes_spin_button.value_changed.connect ( () => {
				update_time_value ();
				value_changed (this.time_value);
			});
			seconds_spin_button.value_changed.connect ( () => {
				update_time_value ();
				value_changed (this.time_value);
			});

		}


		/**
		 * Callback for the SpinButton::output signal 
		 * to achieve numbers with two digits and leading zeros
		 */
		private bool leading_zeros (SpinButton spin_button) {
			uint value = (int) spin_button.get_adjustment ().get_value ();
			string text = "%02u".printf (value);
			spin_button.set_text (text);
			return true;
		}

			

		public uint get_time_value () {
			return this.time_value;
		}



		protected void update_time_value () {
			time_value = 
				(uint) hours_spin_button.get_value_as_int () * 3600 +
				(uint) minutes_spin_button.get_value_as_int () * 60 +
				(uint) seconds_spin_button.get_value_as_int ()
			;
		}
	}
}
