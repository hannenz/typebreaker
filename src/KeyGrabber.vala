using GLib;
using Gtk;

//extern int get_idle_time();

namespace TypeBreaker {

	public class KeyGrabber : GLib.Object {

		public signal void activity ();
		public signal void break_completed ();

		private uint default_screen;

		public uint break_time;

		private uint idle_time;

		public KeyGrabber() {

			default_screen = Gdk.X11.get_default_screen();

			Timeout.add (1000, () => {
				this.idle_time = get_idle_time();
				if (idle_time < 1){
					this.activity();
				}
				if (idle_time > this.break_time){
					this.break_completed();
				}
				return true;
			});
		}

		/**
		  * Returns the number of seconds since the last input (mouse, keyboard...)
		  * on the user's system
		  *
		  * @return uint 
		  */
		private uint get_idle_time() {

			return 1;
		}
	}
}
