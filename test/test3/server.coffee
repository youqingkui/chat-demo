app = require('express')()
http = require('http').Server(app)
io = require('socket.io')(http)




app.get '/', (req, res) ->
  res.sendFile(__dirname + '/index.html')


io.on 'connection', (socket) ->
  socket.emit 'news', {
    title:'Welcome to World News'
    contents:'This news flash was sent from Node.js!'
    allowResponse:true
  }

  socket.on 'scoop', (data) ->
    socket.emit 'news', {
      title: 'Circular Emissions Worked'
      contents: 'Received this content: ' + data.contents
    }


http.listen 8080, () ->
  console.log 'listening on *:8080'
