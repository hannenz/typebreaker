using Gtk;

namespace TypeBreaker {

	public class Countdown : DrawingArea {

		public int microseconds { get; set; }
		public string text { get; set; }
		public int ticked;

		public signal void tick(int seconds, double progress);
		public signal void zero();

		protected int timer;
		protected double progress;

		private int interval = 50;
		private Gdk.Rectangle rect;


		public Countdown(int seconds) {
			/* set_size_request(100, 100); */
			this.microseconds = seconds * 1000;

			Gdk.Display default_display = Gdk.Display.get_default();
			Gdk.Screen screen = default_display.get_default_screen(); // ?
			screen.get_monitor_geometry(screen.get_primary_monitor(), out rect);
			set_size_request(screen.get_width(), screen.get_height() - 50);

			text = "Time for a break, dude...";
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

				if (timer <=0 ) {
					redraw_canvas();
					zero();
					return false;
				}

				redraw_canvas();
				return true;
			}, Priority.DEFAULT);
		}

		public override bool draw (Cairo.Context cr) {
			/* var x = (get_allocated_width() - 100 )/ 2 + 50; */
			/* var y = 50; */
			Gdk.Rectangle box = new Gdk.Rectangle();

			Cairo.TextExtents extents;
			cr.select_font_face("Sans", Cairo.FontSlant.NORMAL, Cairo.FontWeight.NORMAL);
			cr.set_font_size(36);
			cr.set_source_rgb(1, 1, 1);
			cr.text_extents(text, out extents);

			box.width = (int)extents.width;
			box.height = (int)extents.height + 120;
			box.x = (rect.width - box.width) / 2;
			box.y = (rect.height - box.height) / 2;

			/* cr.set_source_rgba(1, 0, 0, 0.2); */
			/* cr.rectangle(box.x, box.y, box.width, box.height); */
			/* cr.fill(); */
			/* return false; */

			var h = 100 + 20 + extents.height;
			cr.move_to(
				rect.x + box.x,
				rect.y + box.y + extents.height
			);
			cr.set_source_rgba(1, 1, 1, 1);
			cr.show_text(text);
			cr.close_path();

			var x = rect.x + ((rect.width - 100) / 2) + 50;
			var y = rect.y + ((rect.height - 100) / 2) + 50 + extents.height + 20;
			var r = 45;

			/* cr.move_to(x,y); */
			cr.new_path();
			cr.arc(x, y, r, 0 * Math.PI, 2 * Math.PI * (1.0 - progress));
			cr.set_source_rgba(1, 1, 1, 1);
			cr.set_line_width(10);
			cr.stroke();

			string digits;
			int seconds_left = (timer / 1000) + 1;
			if (seconds_left >= 60) {
				digits = "%u:%02u".printf(seconds_left / 60, seconds_left % 60);
			}
			else {
				digits = "%u".printf(seconds_left);
			}

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
