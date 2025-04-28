require "mkmf"
require "fileutils"

cargo_dir = File.expand_path(__dir__)
target_dir = File.join(cargo_dir, "target", "release")
lib_name = "candela"
ext_so = "lib#{lib_name}.#{RbConfig::CONFIG["DLEXT"]}"

# Build the Rust extension
puts "Building Rust extension..."
system("cargo build --release") || raise("cargo build failed")

# Create dummy Makefile
create_makefile("candela/candela")

# Patch Makefile to copy Rust extension
open("Makefile", "a") do |f|
  f.puts <<~MAKE
    install:
\tmkdir -p $(DESTDIR)$(sitearchdir)
\tcp #{File.join(target_dir, ext_so)} $(DESTDIR)$(sitearchdir)/
  MAKE
end