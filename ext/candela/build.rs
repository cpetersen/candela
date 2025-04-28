fn main() {
    magnus_export::generate();
    magnus::embed::link_ruby();
}