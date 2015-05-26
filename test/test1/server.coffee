http = require('http')
io = require('socket.io')
fs = require('fs')

sockFile = fs.readFileSync('index.html')

server = http.createServer()

server.on 'request', (req, res) ->
  res.writeHead(200, {'content-type': 'text/html'});
  res.end(sockFile)


server.listen 8080

socket = io.listen(server)

socket.on 'connection', (client) ->
  console.log 'client connected'
  client.send('Welcome client ' + client.id)

