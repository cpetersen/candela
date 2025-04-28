# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "fileutils"

RSpec::Core::RakeTask.new(:spec)

require "standard/rake"

desc "Build Rust extension"
task :build_ext do
  Dir.chdir("ext/candela") do
    # Determine platform-specific extension
    ext = case RbConfig::CONFIG['host_os']
          when /darwin/
            'bundle'
          when /linux/
            'so'
          when /mingw|mswin/
            'dll'
          else
            raise "Unsupported platform: #{RbConfig::CONFIG['host_os']}"
          end
    
    # Determine source path for built extension
    ext_source = case RbConfig::CONFIG['host_os']
                 when /darwin/
                   "target/release/libcandela.dylib"
                 when /linux/
                   "target/release/libcandela.so"
                 when /mingw|mswin/
                   "target/release/candela.dll"
                 else
                   raise "Unsupported platform: #{RbConfig::CONFIG['host_os']}"
                 end
    
    # Use Ruby's standard extension building process
    puts "Building Rust extension..."
    # First, clean up any previous builds to avoid confusion
    FileUtils.rm_f("../../lib/candela_ext.#{ext}") if File.exist?("../../lib/candela_ext.#{ext}")
    
    # Build the Rust library
    system("cargo build --release") || raise("cargo build failed")
    
    # Create lib directory if it doesn't exist
    FileUtils.mkdir_p("../../lib")
    
    # Copy with the correct name that Ruby expects
    FileUtils.cp(ext_source, "../../lib/candela_ext.#{ext}")
    
    puts "Rust extension built successfully"
  end
end

task build: :build_ext
task spec: :build_ext

task default: %i[spec standard]
