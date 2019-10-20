require './lib/load.rb'

port = `process.env.PORT` || 8000

Server.new(port.to_i) do |s, io|
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
