namespace TypeBreaker {

	public class TimeString {

		protected uint secs;
		protected uint mins;
		protected uint hrs;

		public bool show_seconds { get; set; default = true; }

		public TimeString() {
		}



		public string nice (uint seconds) {

			hrs = seconds / 3600;
			mins = (seconds % 3600) / 60;
			secs = seconds % 60;

			var str = new StringBuilder ();
			var parts = new List <string> ();

			if (hrs > 0) {
				parts.append (ngettext ("%u hour", "%u hours", hrs).printf(hrs));
			}
			if (mins > 0) {
				parts.append (ngettext ("%u minute", "%u minutes", mins).printf (mins));
			}
			if (show_seconds) {
				if (secs > 0) {
					parts.append (ngettext ("%u second", "%u seconds", secs).printf (secs));
				}
			}
			for (uint i = 0; i < parts.length (); i++) {
				if (i > 1 && i == parts.length () - 1) {
					str.append (_(" and "));
				}
				else if (i > 0) {
					str.append(", ");
				}
				str.append (parts.nth_data (i));
			}

			return str.str;
		}



		public string nice_short (uint seconds) {

			hrs = seconds / 3600;
			mins = (seconds % 3600) / 60;
			secs = mins % 60;

			var  str = new StringBuilder ();

			if (hrs > 0) {
				str.append ("%uh".printf (hrs));
			}
			if (mins > 0) {
				str.append ("%um ".printf (mins));
			}
			str.append ("%us ".printf (secs));

			return str.str;
		}



		/**
		 * Converts a number of seconds in a formatted string hh:mm:ss
		 * 
		 * @param uint seconds
		 * @return string		e.g. "03:20:11"
		 */
		public string formatted (uint seconds, bool output_null = true) {

			hrs = seconds / 3600;
			mins = (seconds % 3600) / 60 ;
			secs = (seconds % 60);

			var  str = new StringBuilder ();

			if (hrs > 0 || output_null) {
				str.append ("%02u:".printf (hrs));
			}
			if (show_seconds) {
				if (mins > 0 || output_null) {
					str.append ("%02u:".printf (mins));
				}
			}
			str.append ("%02u".printf (secs));

			return str.str;
		}
	}
}
