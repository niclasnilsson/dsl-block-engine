require 'rubygems'

#$hoe = Hoe.spec 'dsl-block-engine' do
#  self.developer 'Niclas Nilsson', 'niclas@niclasnilsson.se'
#  self.rubyforge_name       = self.name # TODO this is default value
  # self.extra_deps         = [['activesupport','>= 2.0.2']]

#end

#require 'newgem/tasks'
#Dir['tasks/**/*.rake'].each { |t| load t }

# TODO - want other tests/tasks run by default? Add them to the list
# remove_task :default
# task :default => [:spec, :features]

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "dsl-block-engine"
    gemspec.summary = "A DSL named block engine"
    gemspec.description = "A gem to ease definition and execution of named blocks, often used in DSLs"
    gemspec.email = "niclas.nilsson@factor10.com"
    gemspec.homepage = "http://github.com/niclasnilsson/dsl-block-engine"
    gemspec.description = "..."
    gemspec.authors = ["Niclas Nilsson"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

task :default => :spec

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "foogem #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
