class Server
  include Utils
  def initialize(port)
    express = `require('express')()`
    http = `require('http').Server(express)`
    io = `require('socket.io')(http, {
        path: '/socket.io'
    })`
    @express = express
    @http = http
    @io = Native(io)
    @port = port

    yield self, @io
  end

  def start!
    http = @http
    Native(`http`).listen(@port) do
      print "\nListening on port #{@port}\n\n"
    end
  end

  def view(name)
    __path.resolve `__dirname` + "/../app/views/#{name}"
  end

  def __path
    @path ||= Native(`require('path')`)
  end

  def io
    @socket_io ||= SocketIo.new(@io)
  end

  def method_missing(name, *args, **options, &block)
    express = @express
    if `express[name]`
      if block_given?
        cb = wrap_cb(&block)
        `express[name](...args, (...cbObjs) => { cb(cbObjs) })`
      else
        `express[name](...args)`
      end
    else
      super
    end
  end

  class SocketIo
    include Utils

    def initialize(socket_io)
      @socket_io = socket_io
    end

    def method_missing(name, *args, **options, &block)
      socket_io = @socket_io
      if `socket_io[name]`
        if block_given?
          cb = wrap_cb(&block)
          `socket_io[name](...args, (...cbObjs) => { cb(cbObjs) })`
        else
          `socket_io[name](...args)`
        end
      else
        super
      end
    end
  end
end