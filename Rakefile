require 'rake'
require 'rake/testtask'
require 'yard'
require 'bundler'

Bundler::GemHelper.install_tasks

task :default => [ 'build' ]

namespace :test do
  desc 'execute tests in parallel in separate Ruby VM instances using parallel_test'
  task :parallel do
    test_files = FileList['test/**/test_*.rb'].sort.reverse
    executable = 'parallel_test'
    command = "#{executable} --type test -n #{test_files.size} -o '-I\'.:lib:test\'' #{test_files.join(' ')}"
    abort unless system(command) # allow to chain tasks e.g. rake parallel:spec parallel:features
  end

  Rake::TestTask.new :serial do |task|
    task.libs << "test"
    task.test_files = FileList['test/**/test_*.rb'].sort.reverse
    task.verbose = true
  end
end

desc 'execute all tests both in serial and in parallel'
task :test => [ 'test:parallel', 'test:serial' ]

YARD::Rake::YardocTask.new(:doc) do |t|
  t.files   = ['lib/**/*.rb']
end

task 'build' => [ 'coverage:clobber', 'test', 'coverage:report', 'doc' ]

namespace 'coverage' do

  desc 'generate code coverage report from unit tests'
  task :report => [ 'test:serial' ] do

    puts 'Generating code coverage report...'

    require 'cover_me'

    CoverMe.config do |c|
      c.project.root = File.expand_path(File.dirname(__FILE__))

      c.file_pattern = /(#{CoverMe.config.project.root}\/app\/.+\.rb|#{CoverMe.config.project.root}\/lib\/.+\.rb)/ix
    end

    CoverMe.complete!

    puts 'Done generating code coverage report'

  end

  desc 'remove code coverage report'
  task :clobber do
    puts 'Removing coverage report and data...'
    rm_rf 'coverage'
    rm_f 'coverage.data'
    puts 'Done removing coverage report and data'
  end

end
