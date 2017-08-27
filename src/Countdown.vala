namespace TypeBreaker {

	public class Countdown {

		public double progress { get; set; }
		public uint microseconds { get; set; }
		public uint interval { get; set; default = 20;}


		public  uint seconds_left;

		protected uint timer;
		private uint seconds_count;

		private uint timeout_id = 0;



		// Signals
		public signal void tick(uint seconds_count, double progress);
		public signal void microtick(uint microseconds_left, double progress);
		public signal void finished();



		public Countdown (uint seconds) {
			
			seconds_count = seconds;
		}



		public void start() {

			setup();

			if (timer == 0) {
				finished();
			}

			// Remove any possibly attached interval
			if (timeout_id > 0) {
				GLib.Source.remove (timeout_id);
			}

			timeout_id = Timeout.add(interval, on_interval, Priority.DEFAULT_IDLE);
		}

		public void stop() {

			if (timeout_id > 0) {
				GLib.Source.remove(timeout_id);
			}
			setup();
		}



		protected void setup() {
			microseconds = seconds_count * 1000;
			timer = microseconds;
			seconds_left = seconds_count;
		}



		public bool on_interval() {

			timer -= interval;
			progress = (double)(microseconds - timer) / (double)microseconds; 

			microtick(timer, progress);

			if (timer / 1000 < seconds_left) {
				/* tick((timer / 1000) + 1, progress); */
				tick (seconds_left, progress);
				seconds_left--;
			}

			if (timer <= 0 ) {
				finished();
				return false;
			}

			return true;
		}
	}
}
