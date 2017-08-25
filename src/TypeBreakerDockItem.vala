using Plank;
using Cairo;

namespace TypeBreaker {
	
	public class TypeBreakerDockItem : DockletItem {
		
  
		// Constructor
		public TypeBreakerDockItem.with_dockitem_file(GLib.File file) {
			GLib.Object(
				/* Prefs: new TypeBreakerPreferences.with_file(file) */
			);
		}

		public Gdk.Pixbuf icon_pixbuf;


		construct {

			Logger.initialize("typebreaker");
			Logger.DisplayLevel = LogLevel.NOTIFY;

			/* prefs = (TypeBreakerPreferences) Prefs; */
			Icon = "resource://" + G_RESOURCE_PATH + "/icons/typebreaker.png";

			try {
				icon_pixbuf = new Gdk.Pixbuf.from_resource(G_RESOURCE_PATH + "/icons/typebreaker.png");
			}
			catch (Error e) {
				warning("Error: " + e.message);
			}
			
			updated();
		}



		// Draw the docklet
		protected override void draw_icon(Plank.Surface surface) {

		}


		void updated() {

			/* needs_redraw(); */
			reset_icon_buffer();
		}



		void take_break () {
		}


		



		protected override AnimationType on_clicked(PopupButton button, Gdk.ModifierType mod, uint32 event_time) {

			if (button == PopupButton.LEFT) {


				return AnimationType.BOUNCE;
			}
			return AnimationType.NONE;
		}

	}
}	
