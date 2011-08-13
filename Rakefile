desc "Updates Js2coffee libraries."
task :update do
  unless ENV['JS2C_PATH']
    $stderr.write "Please set the JS2C_PATH environment variable.\n"
    exit 1
  end

  path = ENV['JS2C_PATH']

  run "cp #{File.join(path, 'dist/js2coffee.min.js')} ./site/scripts/"
  run "cp #{File.join(path, 'docs/js2coffee.html')} ./site/source/index.html"
end

def run(what)
  puts "$ #{what}"
  system what
end

task :default do
  system 'rake -T'
end
