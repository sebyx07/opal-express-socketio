# Opal implementation of a simple server with Express and Socket.io


### Run

Installation
```bash
git clone https://github.com/sebyx07/opal-express-socketio.git opal-server
cd opal-server
bundle install && yarn install # install deps
```

Update index.html
```js
var socket = io.connect('https://opal-realtime-socket-express.herokuapp.com', {transports:['websocket']});
// with
var socket = io.connect('http://localhost:8000', {transports:['websocket']});
```


### Usage

Replace

`rake` it's the default rake task that starts the server

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

