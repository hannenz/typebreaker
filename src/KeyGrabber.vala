using GLib;
using Gtk;

extern int get_idle_time();

namespace TypeBreaker {



	public enum State {
		IDLE,
		ACTIVE
	}



	/**
	 * @class KeyGrabber
	 *
	 * Gets idle time from underlying system (using the C function `get_idle_time`)
	 * and emits variuos signals based on the user's activity
	 */
	public class KeyGrabber : GLib.Object {



		// Signals

		/**
		 * Emitted when going from idle state to active state
		 */
		public signal void activity_begin();

		/**
		 * Emitted when going from active state to idle state
		 */
		public signal void idle_begin();

		/**
		 * Emitted when idle time has reached break time,
		 * e.g. the user has done an appropriate break
		 */
		public signal void break_completed ();



		// Public properties

		public uint break_time;

		/**
		 * The current activity state
		 */
		public State state { get; set; default = State.ACTIVE; }

		/**
		 * Interval to check for idle_time.
		 * By default we use a rather long interval to 
		 * be more insensitive for "false activities", e.g.
		 * bumping the table moves the mouse etc.
		 */
		public uint interval { get; set; default = 500; }



		// Non-public properties

		/**
		 * @var uint
		 * Seconds that the user is idle
		 */
		private  uint idle_time;

		/**
		 * @var bool
		 * Flag if break has been completed
		 */
		private bool break_has_completed = false;



		public KeyGrabber(uint break_time) {

			this.break_time = break_time;

			Timeout.add (interval, () => {

				idle_time = get_idle_time();
				/* debug ("Idle time: %u".printf (idle_time)); */

				if (idle_time < 1) {
					// User is active
					break_has_completed = false;

					if (state == State.IDLE) {
						state = State.ACTIVE;
						activity_begin();
					}
				}
				else {
					// User is idle
					if (state == State.ACTIVE) {
						state = State.IDLE;
						idle_begin();
					}
				}

				// Check if user has completed an appropriate break yet
				if (idle_time > this.break_time && !break_has_completed){

					break_has_completed = true;
					break_completed();
				}

				// runs forever...
				return true;

			}, Priority.DEFAULT_IDLE);
		}
	}
}
