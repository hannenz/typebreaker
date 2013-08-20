using Gtk;
using Notify;

namespace TypeBreaker {

	public class Breaker : GLib.Object {

		public signal void have_a_break();
		public signal void warn_break();

		public uint break_time;
		public uint work_time;
		public uint warn_time;

		public DBusProxy screensaver_proxy;

		private Timer timer;
		private uint timeout_id;
		private bool has_been_warned;

		private KeyGrabber key_grabber;
		private BreakWindow break_window;

		public Breaker(){
			this.timer = new Timer();
			timer.start();
			this.timeout_id = Timeout.add(1000, main_poll);
			this.break_time = 3; //5 * 60;
			this.work_time = 90 * 60;
			this.warn_time = 1 * 60;
			this.break_window = null;

			this.key_grabber = new KeyGrabber();
			this.key_grabber.break_time = this.break_time;
			this.key_grabber.activity.connect(on_activity);
			this.key_grabber.break_completed.connect(on_break_completed);

			this.have_a_break.connect(take_break);
			this.warn_break.connect(on_warn_break);

			this.screensaver_proxy = null;
			this.has_been_warned = false;
		}

		private void take_break(){
			if (this.break_window == null){
				this.break_window = new BreakWindow();
				this.break_window.lock_screen_requested.connect(on_lock_screen_requested);
				this.break_window.run(this.break_time);
			}
		}

		private void on_break_completed(){
			print ("BREAK HAS BEEN COMPLETED\n");
			if (this.break_window != null){
				this.break_window.destroy();
				this.break_window = null;
				timer.start();
				this.has_been_warned = false;
			}
		}

		private void on_warn_break(){
			try {
				string mssg = "Attention, attention! KeyBreaker will shut down your keyboard in %u seconds!".printf(this.warn_time);
				var notification = new Notification(mssg, null, null);
				notification.show();
			}
			catch (Error e){
				stderr.printf("Failed to show notification: %s\n", e.message);
			}
		}

		private DBusProxy get_screensaver_proxy(){
			DBusConnection connection = null;

			if (this.screensaver_proxy != null){
				return this.screensaver_proxy;
			}

			try {
				connection = Bus.get_sync(BusType.SESSION, null);
				screensaver_proxy = new DBusProxy.sync(connection,
					DBusProxyFlags.DO_NOT_LOAD_PROPERTIES |
					DBusProxyFlags.DO_NOT_CONNECT_SIGNALS |
					DBusProxyFlags.DO_NOT_AUTO_START,
					null,
					"screensaver",
					"object-path",
					"interface-name",
					null
				);
			}
			catch (Error e){
				stderr.printf("Error: %s", e.message);
				return (DBusProxy)null;
			}

			return this.screensaver_proxy;
		}

		private void on_lock_screen_requested(){
			DBusProxy proxy = get_screensaver_proxy();
			if (proxy == null){
				return;
			}
			proxy.call("Lock", new Variant("()"), DBusCallFlags.NONE, -1, null);
		}

		public bool main_poll(){

			uint seconds_elapsed = (uint)this.timer.elapsed();

//			print("%.f seconds elsapsed...\n", seconds_elapsed);

			if (seconds_elapsed >= this.work_time - this.warn_time && !has_been_warned){
				print("Uh oh! Time to warn the user...\n");
				this.warn_break();
				has_been_warned = true;
			}

			if (seconds_elapsed >= this.work_time){
				print ("Time for a break!");
				this.have_a_break();
			}
			return true;
		}

		public void on_activity(){
			//print("Hah!\n");
		}

	}
}