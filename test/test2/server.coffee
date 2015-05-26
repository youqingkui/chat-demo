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


socket.of('/upandrunning')
.on 'connection', (client) ->
  console.log('Client connected to Up and Running namespace.')
  client.send("Welcome to 'Up and Running'")


socket.of('/weather')
.on 'connection', (client) ->
  console.log('Client connected to Weather namespace.')
  client.send("Welcome to 'Weather Updates'")

