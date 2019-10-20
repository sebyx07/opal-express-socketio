Logger = ->(req, res, _next) do
  req = Native(req)
  start = `process.hrtime()`
  _next.call
  total = Native(`process.hrtime(start)`).join(".").to_f
  total = (total * 10).round(2)

  print "#{req.method}: #{req.path} in #{total} ms\n"
end