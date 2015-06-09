fs = require('fs')
html = fs.readFileSync('index.html', 'utf8')

handler = (req, res) ->
  res.setHeader('Content-Type', 'text/html')
  res.setHeader('Content-Length', Buffer.byteLength(html, 'utf8'))
  res.end(html)
app = require('http').createServer(handler)


tick = () ->
  now = new Date().toUTCString()
  io.sockets.send(now)

setInterval(tick, 1000)

app.listen(3001)
io = require('socket.io').listen(app)
