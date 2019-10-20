# Opal implementation of a simple server with Express and Socket.io


### Run

`$ bundle install && yarn install` # install deps

`$ rake` it's the default rake task 

go to http://localhost:8000


```ruby
Server.new(8000) do |s, io|
  s # you can access express methods: with get, post, use, etc. Most is supported
    # callbacks, you replace them with do; end blocks

  io # you can use socket-io methods: on, emit etc. Most is supported
     #  socket must be wrapped using Native()
end
```

