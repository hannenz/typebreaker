namespace TypeBreaker {

	public class Settings : Granite.Services.Settings {

		public bool active { get; set; }
		public int active_time { get; set; }
		public int break_time { get; set; }
		public int warn_time { get; set; }
		public int postpone_time { get; set; }
		public int postpones_count { get; set; }



		public Settings () {
			base ("com.github.hannenz.typebreaker.settings");
		}
	}
}

