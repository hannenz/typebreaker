using TypeBreaker;
using Notify;

int main(string[] args){
	Gtk.init(ref args);
	Notify.init("TypeBreaker");

	var tb = new Breaker();
	tb.work_time = 10;
	tb.break_time = 3;
	tb.warn_time = 3;

	Gtk.main();

	return 0;
}