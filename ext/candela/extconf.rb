require 'mkmf'
require 'fileutils'

# Check for Rust/Cargo
unless system('cargo --version > /dev/null 2>&1')
  raise "Rust and Cargo are required to build this gem. Please install Rust: https://www.rust-lang.org/tools/install"
end

# Get Ruby include paths
ruby_include = `#{RbConfig.ruby} -e "puts RbConfig::CONFIG['rubyhdrdir']"`.chomp
ruby_include_arch = `#{RbConfig.ruby} -e "puts RbConfig::CONFIG['rubyarchhdrdir']"`.chomp
ruby_lib = `#{RbConfig.ruby} -e "puts RbConfig::CONFIG['libdir']"`.chomp

# Create a .cargo/config.toml file to specify rustc linker flags
FileUtils.mkdir_p('.cargo')
File.open('.cargo/config.toml', 'w') do |f|
  f.puts <<~CONFIG
    [target.aarch64-apple-darwin]
    rustflags = [
      "-L", "#{ruby_lib}",
      "-l", "ruby",
      "-undefined", "dynamic_lookup"
    ]

    [target.x86_64-apple-darwin]
    rustflags = [
      "-L", "#{ruby_lib}",
      "-l", "ruby",
      "-undefined", "dynamic_lookup"
    ]
  CONFIG
end

# Create Makefile to build the rust extension
File.open('Makefile', 'w') do |f|
  f.puts <<~MAKEFILE
    SHELL = /bin/sh
    
    # Ruby extension target
    .PHONY: all clean
    
    all: ../../lib/candela_ext.bundle
    
    ../../lib/candela_ext.bundle:
    \tcargo build --release
    \tmkdir -p ../../lib
    \tcp target/release/libcandela.dylib ../../lib/candela_ext.bundle
    
    clean:
    \tcargo clean
    \trm -f ../../lib/candela_ext.bundle
  MAKEFILE
end

# Just a placeholder to make mkmf happy
create_makefile('dummy')