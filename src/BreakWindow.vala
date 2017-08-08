using Gtk;
using Gdk;
using Cairo;

namespace TypeBreaker {

	public class BreakWindow : Gtk.Window {

		public signal void postpone_requested();
		public signal void lock_screen_requested();
		public signal void countdown_finished();

		/* private Gtk.Label clock_label; */
		/* private Gtk.ProgressBar pbar; */
		private CountdownClock countdown_clock;

		/* Duration of a typing break in seconds */
		private uint break_time;

		private uint break_time2;

		/* Number of allowed postpones */
		private uint postpones;

		public BreakWindow (uint break_time, uint postpones){
			GLib.Object(
				type: Gtk.WindowType.POPUP,
				skip_taskbar_hint: true,
				skip_pager_hint:true,
				focus_on_map:false
			);

			debug ("BreakWindow::Constructing BreakWindow");

			this.break_time = break_time;
			this.postpones = postpones;

			this.set_focus_on_map(false);
			this.set_focus(null);

			this.set_keep_above(true);
			this.fullscreen();
			this.set_modal(true);
			this.set_default_size(this.screen.get_width(), this.screen.get_height());
			this.set_decorated(false);
			this.set_app_paintable(true);

			setup_background();

			this.break_time2 = this.break_time;

			populate();
		}

		~BreakWindow() {
			debug ("BreakWindow::Deconstructing BreakWindow");
		}

		public void setup_background(){
			debug ("BreakWindow::setup_background");

			var visual = this.screen.get_rgba_visual();
			bool is_composited;

			if (visual == null){
				visual = this.screen.get_system_visual();
			}
			if (visual != null && this.screen.is_composited()){
				this.set_visual(visual);
				is_composited = true;
			}
			else {
				is_composited = false;
			} if (is_composited){
				this.draw.connect(on_draw);
			}
			else {
				stderr.printf("Heck, no composited screen available...\n");
			}
		}

		public bool on_draw(Cairo.Context context){

			Context cr;
			Surface surface;
			int width;
			int height;

			debug ("BreakWindow::on_draw");

			context.set_operator(Cairo.Operator.SOURCE);

			this.get_size(out width, out height);
			surface = new Surface.similar(context.get_target(), Content.COLOR_ALPHA, width, height);
			if (surface.status() != Cairo.Status.SUCCESS){
				stderr.printf("Failed to create cairo surface!\n");
			}
			
			cr = new Context(surface);
			if (cr.status() != Cairo.Status.SUCCESS){
				stderr.printf("Failed to create cairo context\n");
			}
			cr.set_source_rgba(1.0, 1.0, 1.0, 0.0);	
			cr.set_operator(Operator.OVER);
			cr.paint();
			
			cr.rectangle(0, 0, width, height);
			cr.set_source_rgba(0.2, 0.2, 0.2, 0.85);
			cr.fill();

			context.set_source_surface(surface, 0, 0);
			context.paint();
			return false;
		}

		private bool populate(){
			debug ("BreakWindow::populate");

			Gdk.Rectangle monitor;
			this.screen.get_monitor_geometry(0, out monitor);

			var outer_vbox = new Box(Orientation.VERTICAL, 0);
			var align = new Alignment(0.5f, 0.5f, 1.0f, 1.0f);
			int right_padding = this.screen.get_width() - monitor.width - monitor.x;
			int bottom_padding = this.screen.get_height() - monitor.height - monitor.y;

			var monitor_box = new Alignment(0.5f, 0.5f, 1.0f, 1.0f);
			monitor_box.set_padding(monitor.y, bottom_padding, monitor.x, right_padding);

			this.add(monitor_box);
			monitor_box.add(outer_vbox);

			outer_vbox.pack_start(align, true, true, 0);

			var button_box = new ButtonBox(Orientation.HORIZONTAL);
			button_box.set_layout(ButtonBoxStyle.END);
			button_box.set_border_width(12);
			button_box.set_spacing(12);
			outer_vbox.pack_start(button_box, false, false, 0);;

			if (postpones > 0){
				var postpone_button = new Button();
				postpone_button.set_label("Postpone Break (%u)".printf(postpones));
				//postpone_button.set_focus_on_click(false);
				postpone_button.clicked.connect(on_postpone_button_clicked);
				button_box.pack_end(postpone_button, false, true, 0);
			}

			// For debugging only
			if (true) {
				var exit_button = new Button();
				exit_button.set_label("Exit");
				exit_button.clicked.connect(Gtk.main_quit);
				button_box.pack_start(exit_button, false, true, 0);
			}
			
			var lock_button = new Button.with_mnemonic("Lock screen");
			lock_button.clicked.connect(on_lock_button_clicked);
			button_box.pack_start(lock_button, false, false, 0);

			var vbox = new Box(Orientation.VERTICAL, 0);
			align.add(vbox);

			var dummyLabel = new Label("...");
			vbox.pack_start(dummyLabel, true, true, 0);

			var image = new Image.from_stock(Gtk.Stock.STOP, Gtk.IconSize.DIALOG);
			/* image.set_alignment(0.5f, 0.5f); */
			image.set_halign(Align.CENTER);
			image.set_valign(Align.CENTER);

			vbox.pack_start(image, false, false, 0);

			var label = new Label(null);
			label.set_markup("<span size=\"xx-large\" foreground=\"white\"><b>Time for a break...!</b></span>");
			label.set_xalign(0.5f);
			label.set_yalign(0.5f);
			vbox.pack_start(label, false, false, 0);

			/* countdown_clock = new CountdownClock((int)this.break_time); */
			/* vbox.pack_start(countdown_clock, true, true, 8); */
			/* countdown_clock.zero.connect( () => { */
			/* 	debug ("COUNTDOWN HAS FINISHED"); */
			/* 	// Emit signal */
			/* 	countdown_finished(); */
			/* }); */
			/* countdown_clock.start(); */

			this.stick();

			// What is this..???!
			this.show.connect((w) => {
				while (Gdk.keyboard_grab(w.get_window(), false, Gtk.get_current_event_time()) != Gdk.GrabStatus.SUCCESS){
					Posix.sleep(1);
				}
			});

			debug ("BreakWindow::populate - end");

			return false;
		}

		private void on_postpone_button_clicked(Gtk.Button button){
			debug ("BreakWindow::on_postpone_button_clicked");
			this.postpone_requested();
			if (--postpones == 0){
				button.set_sensitive(false);
			}
			button.set_label("Postpone (%u)".printf(postpones));
		}

		private void on_lock_button_clicked(){
			debug ("BreakWindow::on_lock_button_clicked");
			this.lock_screen_requested();
		}

		/* private void set_clock_label(uint n){ */
		/* 	clock_label.set_markup("<span size=\"xx-large\" foreground=\"white\"><b>%u</b></span>".printf(n)); */
		/* } */

		public void run(){
			debug ("BreakWindow::run");
			/* set_clock_label(this.break_time); */
			this.show_all();
			/* Timeout.add(1000, countdown); */
			//this.draw.connect_after(populate);
			//this.queue_draw();
		}
	}
}
