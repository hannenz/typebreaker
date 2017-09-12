using Plank;

namespace TypeBreaker {

	public class TypeBreakerPreferences : DockItemPreferences {

		[Description(nick = "foo-bar-count", blurb="Number of foo-bars")]
		public int FooBarCount { get; set; default = 10; }

		public TypeBreakerPreferences.with_file(GLib.File file) {
			base.with_file(file);
		}

		protected override void reset_properties() {
			FooBarCount = 10;
		}
	}
}

