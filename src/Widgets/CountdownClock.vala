using Gtk;

namespace TypeBreaker.Widgets {

	public class CountdownClock : DrawingArea {



		public uint radius { get; set; default = 50; }



		protected Countdown countdown;
		/* protected uint microseconds; */
		protected uint seconds_left;
		protected double progress;



		// Signals
		public signal void finished();



		public CountdownClock (uint seconds) {
			seconds_left = seconds;

			countdown = new Countdown(seconds);
			countdown.microtick.connect( (microseconds_left, progress) => {
				this.seconds_left = microseconds_left / 1000 + 1;
				this.progress = progress;
				redraw_canvas();
			});
			countdown.finished.connect( () => {
				this.seconds_left = 0;
				redraw_canvas();
				finished();
			});
		}



		public void start() {
			countdown.start();
		}



		/**
		  * Draw the "clock"
		  */
		public override bool draw (Cairo.Context cr) {

			/* int radius = 50; */
			string digits;

			var x = ((get_allocated_width()  - radius) / 2) + radius/2;
			var y = ((get_allocated_height() - radius) / 2) + radius/2;
			var r = radius - 5;

			cr.new_path();
			cr.arc(x, y, r, 0, 2 * Math.PI * (1.0 - progress));
			cr.set_source_rgba(1, 1, 1, 1);
			cr.set_line_width(6);
			cr.stroke();

			digits = (seconds_left >= 60) 
				? "%u:%02u".printf(seconds_left / 60, seconds_left % 60)
				: "%u".printf(seconds_left)
			;

			Cairo.TextExtents extents;
			cr.set_font_size(18);
			cr.text_extents(digits, out extents);
			cr.move_to(x - (extents.width / 2 + extents.x_bearing), y - (extents.height / 2 + extents.y_bearing));
			cr.show_text(digits);

			return false;
		}



		private void redraw_canvas() {

			var window = get_window();
			if (window == null) {
				return;
			}
			var region = window.get_clip_region();
			window.invalidate_region(region, true);
			window.process_updates(true);
		}
	}
}
