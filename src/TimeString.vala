namespace TypeBreaker {

	public class TimeString {

		protected uint secs;
		protected uint mins;
		protected uint hrs;

		public TimeString() {
		}



		public string nice(uint seconds) {

			hrs = seconds / 3600;
			mins = (seconds % 3600) / 60;
			secs = mins % 60;

			var  str = new StringBuilder();

			if (hrs > 0) {
				str.append("%u hours".printf(hrs));
			}
			if (mins > 0) {
				str.append("%u minutes and ".printf(mins));
			}
			str.append("%u seconds".printf(secs));

			return str.str;
		}



		public string nice_short(uint seconds) {

			hrs = seconds / 3600;
			mins = (seconds % 3600) / 60;
			secs = mins % 60;

			var  str = new StringBuilder();

			if (hrs > 0) {
				str.append("%uh".printf(hrs));
			}
			if (mins > 0) {
				str.append("%um ".printf(mins));
			}
			str.append("%us ".printf(secs));

			return str.str;
		}



		/**
		 * Converts a number of seconds in a formatted string hh:mm:ss
		 * 
		 * @param uint seconds
		 * @return string		e.g. "03:20:11"
		 */
		public string formatted(uint seconds, bool output_null = true) {

			hrs = seconds / 3600;
			mins = (seconds % 3600) / 60 ;
			secs = (seconds % 60);

			var  str = new StringBuilder();

			if (hrs > 0 || output_null) {
				str.append("%02u:".printf(hrs));
			}
			if (mins > 0 || output_null) {
				str.append("%02u:".printf(mins));
			}
			str.append("%02u".printf(secs));

			return str.str;

		}
	}
}
