using TypeBreaker;
using Notify;

int main(string[] args){
	Gtk.init(ref args);
	Notify.init("TypeBreaker");

	new Breaker();

	Gtk.main();
	return 0;
}