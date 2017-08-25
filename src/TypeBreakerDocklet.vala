/**
 * TypeBreaker Docklet
 *
 * @author Johannes Braun <johannes.braun@hannenz.de>
 * @package typebreaker
 */

public static void docklet_init(Plank.DockletManager manager) {
	manager.register_docklet(typeof(TypeBreaker.TypeBreakerDocklet));
}

namespace TypeBreaker {

	/**
	 * Resource path for the icon
	 */
	public const string G_RESOURCE_PATH = "/com/github/hannenz/typebreaker";


	public class TypeBreakerDocklet : Object, Plank.Docklet {

		public unowned string get_id() {
			return "typebreaker";
		}

		public unowned string get_name() {
			return "Type Breaker";
		}

		public unowned string get_description() {
			return "A docklet that forces you to make regular breaks";
		}

		public unowned string get_icon() {
			/* return "resource://" + G_RESOURCE_PATH + "/data/typebreaker.png"; */
			return "resource:///com/github/hannenz/typebreaker/data/typebreaker.png";
		}

		public bool is_supported() {
			return false;
		}

		public Plank.DockElement make_element(string launcher, GLib.File file) {
			return new TypeBreakerDockItem.with_dockitem_file(file);
		}
	}
}


