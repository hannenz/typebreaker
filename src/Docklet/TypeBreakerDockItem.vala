using Plank;
using Cairo;

namespace TypeBreaker {

	public class TypeBreakerDockItem : DockletItem {

		/**
		  * @var Gdk.Pixbuf
		  * @access public
		  */
		public Gdk.Pixbuf icon_pixbuf;

		/**
		  * @var TypeBreakerPreferences
		  * @access public
		  */
		public TypeBreakerPreferences prefs;



		// Constructor
		public TypeBreakerDockItem.with_dockitem_file(GLib.File file) {
			GLib.Object( Prefs: new TypeBreakerPreferences.with_file(file));
		}


		private Breaker breaker;


		construct {

			Logger.initialize ("typebreaker");
			Logger.DisplayLevel = LogLevel.NOTIFY;

			prefs = (TypeBreakerPreferences) Prefs;
			Icon = "resource://" + G_RESOURCE_PATH + "/data/typebreaker.png";

			try {
				icon_pixbuf = new Gdk.Pixbuf.from_resource("/com/github/hannenz/typebreaker/data/typebreaker.png");
			}
			catch (Error e) {
				warning("Error: " + e.message);
			}

			breaker = new Breaker (null);
			breaker.run ();

			Timeout.add ( 200, () => {
				updated();
				return true;
			}, Priority.DEFAULT_IDLE);

			var dlg = new SettingsDialog ();
			dlg.run ();
			dlg.destroy ();

			updated();
		}



		// Draw the docklet
		protected override void draw_icon(Plank.Surface surface) {

			uint idle_time = breaker.key_grabber.get_idle_time ();


			Cairo.Context ctx = surface.Context;
			Gdk.Pixbuf pb = icon_pixbuf.scale_simple(surface.Width, surface.Height, Gdk.InterpType.BILINEAR);
			Gdk.cairo_set_source_pixbuf(ctx, pb, 0, 0);
			ctx.paint();
			int x,y,r;
			x = surface.Width / 2;
			y = surface.Height /2;
			r = (x > y) ? y : x;
			r -= 10;

			double progress = (double) idle_time / (double) breaker.break_time;
			/* Plank.Logger.notification ("Redrawing: %.2f".printf (progress)); */
			ctx.new_path( );
			ctx.arc (x, y, r, 0, 2 * Math.PI * progress);
			ctx.set_source_rgba (0, 1, 0, 1);
			ctx.set_line_width (6);
			ctx.stroke ();


			progress = (double) breaker.seconds_elapsed / (double) breaker.work_time;

			r += 7;
			ctx.new_path ();
			ctx.arc (x, y, r, 0, 2 * Math.PI * (1.0 - progress));
			ctx.set_source_rgba (1, 0,  0, 1);
			ctx.stroke ();

		}



		public override Gee.ArrayList<Gtk.MenuItem> get_menu_items() {
			var items = new Gee.ArrayList<Gtk.MenuItem>();

			var item = create_menu_item ( _("Settings"), null, true);
			item.activate.connect ( () => {
				var dlg = new SettingsDialog();
				dlg.run();
				dlg.destroy();
			});
			items.add (item);
			item = create_menu_item ( _("Take break now"), null, true);
			item.activate.connect ( breaker.take_break);
			items.add (item);

			/*
			for (var i = colors.size; i > 0; i--) {
				Color color = colors.get(i - 1);

				var label = color.get_string(type);
				if (type != ColorSpecType.X11NAME) {
					label += " - %s".printf(color.to_x11name());
				}

				var item = create_menu_item_with_pixbuf(label, color.get_pixbuf(16), true);
				var pos = i;
				item.activate.connect( () => {
					copy_entry_at(pos);
				});
				items.add(item);
			}

			if (colors.size > 0) {
				var item = create_menu_item("_Clear", "edit-clear-all", true);
				item.activate.connect(clear);
				items.add(item);
			}
			*/

			return items;
		}


		void updated() {
			/* needs_redraw(); */
			reset_icon_buffer();
		}



		protected override AnimationType on_clicked(PopupButton button, Gdk.ModifierType mod, uint32 event_time) {

			if (button == PopupButton.LEFT) {


				return AnimationType.BOUNCE;
			}
			return AnimationType.NONE;
		}

	}
}
