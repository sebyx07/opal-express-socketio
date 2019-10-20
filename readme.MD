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


### Example server usage

```ruby
Server.new(8000) do |s, io|
  s.use(Logger)
  s.start!

  s.get("/") do |_, res|
    res.sendFile(s.view("index.html"))
  end

  s.get("/:name") do |req, res|
    res.send(req.params.name)
  end

  io.on 'connection' do |socket|
    socket = Native(socket) # if you have problems with apply for a object, just Native() it

    socket.on('chat message') do |msg|
      io.emit('chat message', msg)
    end

    socket.on('disconnect') do
      p "disconnect"
    end
  end
end
```
