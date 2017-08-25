// modules: gtk+-3.0

using Gtk;

namespace TypeBreaker {



	/**
	 * @class TypeBreaker
	 *
	 * The main application
	 */
	public class TypeBreaker : Gtk.Application { // Shouldn't this rather be Gdk.Application??

		/**
		  * Constructor
		  */
		public TypeBreaker () {
			Object (
				application_id: "com.github.hannenz.typebreaker",
				/* flags: ApplicationFlags.IS_SERVICE */
				flags: ApplicationFlags.FLAGS_NONE
			);
		}



		/**
		  * On application activation, e.g. startup / init
		  */
		protected override void activate () {
			var breaker = new Breaker ( this );

			breaker.quit.connect ( () => {
				quit ();
			});
			this.add_window (breaker.break_window);

			breaker.run ();
		}
	}



	// Main: Launch app
	int main (string[] args){
		var app = new TypeBreaker ();
		return app.run ();
	}
}

