fs = require('fs')
url = require('url')
http = require('http')
path = require('path')
express = require('express')
app = express()
server = http.createServer(app)
io = require('socket.io').listen(server)
root = __dirname

app.use (req, res, next) ->
  req.on 'static', () ->
    file = url.parse(req.url).pathname
    mode = 'stylesheet'
    if file[file.length - 1] is '/'
      file += 'index.htm'
      mode = 'reload'

    createWatcher(file, mode)

  next()


app.use(express.static(root))


watchers = {}

createWatcher = (file, event) ->
  absolute = path.join(root, file)
  if watchers[absolute]
    return

  fs.watchFile absolute, (curr, prev) ->
    if curr.mtime isnt prev.mtime
      io.sockets.emit(event, file)

  watchers[absolute] = true

app.listen 3001