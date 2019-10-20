desc "Start server"
task :default do
  sh "mkdir -p .build"
  sh 'bundle exec opal --compile app.rb > .build/.out.js'
  sh 'node .build/.out.js'
end