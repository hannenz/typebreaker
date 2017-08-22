using Gtk;
using Gdk;
using Cairo;



namespace TypeBreaker {

	public class BreakWindow : Gtk.Window {



		/* private Gtk.Label clock_label; */
		/* private Gtk.ProgressBar pbar; */
		private CountdownClock countdown_clock;

		/* Duration of a typing break in seconds */
		private uint break_time;

		private uint break_time2;

		/* Number of allowed postpones */
		private uint postpones;

		private uint postpone_time;



		// Signalse
		public signal void postpone_requested();
		public signal void lock_screen_requested();
		public signal void countdown_finished();
		public signal void exit_application();



		public BreakWindow (uint break_time, uint postpones, uint postpone_time){
			GLib.Object(
				type: Gtk.WindowType.POPUP,
				skip_taskbar_hint: true,
				skip_pager_hint:true,
				focus_on_map:false
			);

			this.break_time = break_time;
			this.postpones = postpones;
			this.postpone_time = postpone_time;

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
			} 
			if (is_composited){
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

			Gdk.Rectangle monitor;
			this.screen.get_monitor_geometry(0, out monitor);

			countdown_clock = new CountdownClock(this.break_time);
			countdown_clock.finished.connect( () => {
				countdown_finished();
			});

			// Does this respect that the UI should always appear on the
			// primary monitor? Check!!

			// TODO: Gtk.Alignment is deprecated since 3.14.
			// Use widget xalign,yalign and margin properties!
			int right_padding = this.screen.get_width() - monitor.width - monitor.x;
			int bottom_padding = this.screen.get_height() - monitor.height - monitor.y;

			var monitor_box = new Alignment(0.5f, 0.5f, 1.0f, 1.0f);
			monitor_box.set_padding(monitor.y, bottom_padding, monitor.x, right_padding);

			var outer_vbox = new Box(Orientation.VERTICAL, 0);
			outer_vbox.hexpand = true;
			outer_vbox.vexpand = true;

			var vbox = new Box(Orientation.VERTICAL, 32);
			vbox.halign = Align.CENTER;
			vbox.valign = Align.CENTER;
			vbox.hexpand = false;
			vbox.vexpand = true;

			var label = new Label(null);
			label.set_markup("<span size=\"xx-large\" foreground=\"white\"><b>%s</b></span>".printf(_("Time for a break")));
			label.halign = Gtk.Align.CENTER;
			label.valign = Gtk.Align.END;
			label.hexpand = false;
			label.vexpand = false;

			/* countdown_clock.halign = Gtk.Align.CENTER; */
			/* countdown_clock.valign = Gtk.Align.CENTER; */
			countdown_clock.set_size_request (100, 100);
			countdown_clock.hexpand = true;
			countdown_clock.vexpand = true;

			vbox.pack_start(label, false, false, 0);
			vbox.pack_start(countdown_clock, true, true, 0);

			outer_vbox.pack_start(vbox, true, false, 0);
			outer_vbox.pack_start(this.create_button_box (), false, false, 0);;

			monitor_box.add(outer_vbox);

			this.add(monitor_box);

			this.stick();

			// What is this..???!
			this.show.connect( (widget) => {
				start_countdown();
				while (Gdk.keyboard_grab (widget.get_window (), false, Gtk.get_current_event_time ()) != Gdk.GrabStatus.SUCCESS){
					Posix.sleep (1);
				}
			});

			this.hide.connect( (widget) => {
				stop_countdown ();
			});

			return false;
		}


		
		private Widget create_button_box () {
			var button_box = new ButtonBox(Orientation.HORIZONTAL);
			button_box.set_layout(ButtonBoxStyle.END);
			button_box.set_border_width(12);
			button_box.set_spacing(12);

			var bgcolor = Gdk.RGBA();
			bgcolor.red = bgcolor.green = bgcolor.blue = 0.75;
			bgcolor.alpha = 1;

			if (postpones > 0){
				var postpone_button = new Button.with_label(_("Postpone"));
				postpone_button.override_background_color(Gtk.StateFlags.NORMAL, bgcolor);
				postpone_button.clicked.connect(on_postpone_button_clicked);
				button_box.pack_end(postpone_button, false, true, 0);
			}


			// For testing only
			
			string[] envp = Environ.get ();
			if (Environ.get_variable (envp, "G_MESSAGES_DEBUG") != null) {
				var exit_button = new Button.with_label (_("Exit"));
				exit_button.clicked.connect( () => {
					exit_application();
				});
				exit_button.override_background_color (Gtk.StateFlags.NORMAL, bgcolor);
				button_box.pack_start (exit_button, false, true, 0);
			}
			
			var lock_button = new Button.with_mnemonic (_("Lock screen"));
			lock_button.clicked.connect (on_lock_button_clicked);
			lock_button.override_background_color (Gtk.StateFlags.NORMAL, bgcolor);
			button_box.pack_start (lock_button, false, false, 0);
			
			return button_box;
		}



		private void on_postpone_button_clicked(Gtk.Button button){

			this.postpone_requested();
			if (--postpones == 0){
				button.set_sensitive(false);
			}
			button.set_label("Postpone (%u)".printf(postpones));
		}



		private void on_lock_button_clicked(){
			this.lock_screen_requested();
		}




		public void start_countdown() {
			countdown_clock.start();
		}



		public void stop_countdown() {
			//
		}
	}
}
