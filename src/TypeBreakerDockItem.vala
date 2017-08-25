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



		construct {

			Logger.initialize("typebreaker");
			Logger.DisplayLevel = LogLevel.NOTIFY;

			prefs = (TypeBreakerPreferences) Prefs;
			Icon = "resource:///com/github/hannenz/typebreaker/data/typebreaker.png";

			try {
				icon_pixbuf = new Gdk.Pixbuf.from_resource(G_RESOURCE_PATH + "/data/typebreaker.png");
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
