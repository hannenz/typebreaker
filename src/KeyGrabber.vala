using GLib;
using Gtk;

extern int get_idle_time();

namespace TypeBreaker {

	public class KeyGrabber : GLib.Object {

		public signal void activity ();
		/* public signal void idle(); */
		public signal void activity_begin();
		public signal void idle_begin();
		public signal void break_completed ();

		public uint break_time;

		public State state { get; set; default = State.ACTIVE; }
		public bool break_has_completed = false;

		private uint idle_time;

		public KeyGrabber() {

			Timeout.add (500, () => {
				idle_time = get_idle_time();

				if (idle_time < 1) {
					activity ();
					break_has_completed = false;
					if (state == State.IDLE) {
						state = State.ACTIVE;
						activity_begin();
					}
				}
				else {
					if (state == State.ACTIVE) {
						state = State.IDLE;
						idle_begin();
					}
				}
				if (idle_time > this.break_time && !break_has_completed){
					break_has_completed = true;
					break_completed();
				}
				return true;
			}, Priority.DEFAULT_IDLE);
		}
	}
}
