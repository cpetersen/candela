require 'mkmf'
require 'fileutils'

# Check for Rust/Cargo
unless system('cargo --version > /dev/null 2>&1')
  raise "Rust and Cargo are required to build this gem. Please install Rust: https://www.rust-lang.org/tools/install"
end

# Create Makefile
create_makefile('candela_ext')

# Create a custom Makefile that builds the Rust extension
FileUtils.rm_f('Makefile')
File.open('Makefile', 'w') do |f|
  f.puts <<~MAKEFILE
    SHELL = /bin/sh

    # Rust build targets
    .PHONY: all clean

    all: candela_ext.so

    candela_ext.so:
    \tcargo build --release
    \tcp target/release/libcandela.dylib candela_ext.so

    clean:
    \tcargo clean
    \trm -f candela_ext.so
  MAKEFILE
end