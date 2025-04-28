# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "fileutils"

RSpec::Core::RakeTask.new(:spec)

require "standard/rake"

desc "Build Rust extension"
task :build_ext do
  Dir.chdir("ext/candela") do
    puts "Building Rust extension..."
    system("cargo build --release") || raise("Cargo build failed")
    
    # Create lib directory if it doesn't exist
    FileUtils.mkdir_p("../../lib")
    
    # Copy the compiled library to the lib directory with the correct name for the platform
    if RbConfig::CONFIG['host_os'] =~ /darwin/
      FileUtils.cp("target/release/libcandela.dylib", "../../lib/candela_ext.bundle")
    elsif RbConfig::CONFIG['host_os'] =~ /linux/
      FileUtils.cp("target/release/libcandela.so", "../../lib/candela_ext.so")
    elsif RbConfig::CONFIG['host_os'] =~ /mingw|mswin/
      FileUtils.cp("target/release/candela.dll", "../../lib/candela_ext.dll")
    else
      raise "Unsupported platform: #{RbConfig::CONFIG['host_os']}"
    end
    
    puts "Rust extension built successfully"
  end
end

task build: :build_ext
task spec: :build_ext

task default: %i[spec standard]
