require "mkmf"
require "fileutils"

# Build the Rust extension with cargo
cargo_dir = File.expand_path(__dir__) # Current directory
target_dir = File.join(cargo_dir, "target", "release")
ext_so = "libcandela.#{RbConfig::CONFIG["DLEXT"]}"

# Compile Rust extension
puts "Building Rust extension..."
system("cargo build --release --manifest-path #{File.join(cargo_dir, "Cargo.toml")}") || raise("cargo build failed")

# Create Makefile to install built library
create_makefile("candela/candela")

# Monkey patch Makefile so `make install` just copies the compiled .so/.bundle file
open("Makefile", "a") do |f|
  f.puts <<~MAKE
    install:
\tmkdir -p $(DESTDIR)$(sitearchdir)
\tcp #{File.join(target_dir, ext_so)} $(DESTDIR)$(sitearchdir)/
  MAKE
end