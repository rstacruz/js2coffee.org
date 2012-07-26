desc "Updates Js2coffee libraries."
task :update do
  unless ENV['JS2C_PATH']
    $stderr.write "Please set the JS2C_PATH environment variable.\n"
    exit 1
  end

  path = ENV['JS2C_PATH']

  Dir.chdir path do
    run "cake build" # Builds js2coffee.min.js
    run "cake doc"   # Builds source files
  end

  run "cp #{File.join(path, 'dist/js2coffee.min.js')} ./site/scripts/"
  run "cp #{File.join(path, 'docs/js2coffee.html')} ./site/source/index.html"
end

desc "Starts a preview server."
task :start do
  port = ENV['port'] || 4833
  run "bundle exec proton start -p #{port}"
end

desc "Deploys to Heroku."
task :deploy do
  # Simply because I keep on forgetting :|
  run "git push heroku master"
end

def run(what)
  puts "$ #{what}"
  system what
end

task :default do
  system 'rake -T'
end
