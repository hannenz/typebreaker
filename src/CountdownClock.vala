using Gtk;

namespace TypeBreaker {

	public class CountdownClock : DrawingArea {

		public int microseconds { get; set; }
		public int ticked;

		public signal void tick(int seconds, double progress);
		public signal void zero();

		protected int timer;
		protected double progress;

		private int interval = 50;

		public CountdownClock (int seconds) {

			microseconds = seconds * 1000;
		}

		public void start() {

			timer = microseconds;
			ticked = timer / 1000;

			if (timer == 0) {
				zero();
				return;
			}

			Timeout.add(interval, () => {
				
				timer -= interval;
				progress = (double)(microseconds - timer) / (double)microseconds; 

				if (timer / 1000 < ticked) {
					ticked--;
					tick((timer / 1000) + 1, progress);
				}

				if (timer <= 0 ) {
					redraw_canvas();
					zero();
					return false;
				}

				redraw_canvas();
				return true;

			}, Priority.DEFAULT_IDLE);
		}

		public override bool draw (Cairo.Context cr) {

			int radius = 50;
			string digits;
			int seconds_left = (timer / 1000) + 1;

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
			/* cr.set_font_face("serif"); */
			cr.set_font_size(28);
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
