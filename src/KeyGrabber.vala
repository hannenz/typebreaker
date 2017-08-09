using GLib;
using Gtk;

extern int get_idle_time();

namespace TypeBreaker {

	public class KeyGrabber : GLib.Object {

		public signal void activity ();
		public signal void break_completed ();

		public uint break_time;

		private uint idle_time;

		public KeyGrabber() {

			Timeout.add (1000, () => {
				idle_time = get_idle_time();

				if (idle_time < 1){
					this.activity ();
				}
				if (idle_time > this.break_time){
					debug ("About to emit <break-completed> signal");
					this.break_completed();
				}
				return true;
			});
		}
	}
}
