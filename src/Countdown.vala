namespace TypeBreaker {

	public class Countdown {

		public double progress { get; set; }
		public uint microseconds { get; set; }

		public signal void tick(uint seconds_left, double progress);
		public signal void microtick(uint microseconds_left, double progress);
		public signal void zero();

		protected uint timer;
		protected uint ticked;
		private uint seconds_left;

		private uint interval = 50;





		public Countdown (uint seconds) {
			
			seconds_left = seconds;
			microseconds = seconds * 1000;
			timer = microseconds;
			ticked = timer / 1000;

			if (timer == 0) {
				zero();
			}
		}




		public void start() {
			Timeout.add(interval, on_interval, Priority.DEFAULT_IDLE);
		}



		
		public bool on_interval() {

			timer -= interval;
			progress = (double)(microseconds - timer) / (double)microseconds; 

			microtick(timer, progress);

			if (timer / 1000 < ticked) {
				ticked--;
				/* tick((timer / 1000) + 1, progress); */
				tick (ticked, progress);
			}

			if (timer <= 0 ) {
				/* redraw_canvas(); */

				zero();
				return false;
			}

			return true;
		}
	}
}
