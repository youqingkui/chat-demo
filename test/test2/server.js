// Generated by CoffeeScript 1.8.0
(function() {
  var fs, http, io, server, sockFile, socket;

  http = require('http');

  io = require('socket.io');

  fs = require('fs');

  sockFile = fs.readFileSync('index.html');

  server = http.createServer();

  server.on('request', function(req, res) {
    res.writeHead(200, {
      'content-type': 'text/html'
    });
    return res.end(sockFile);
  });

  server.listen(8080);

  socket = io.listen(server);

  socket.on('connection', function(client) {
    console.log('client connected');
    return client.send('Welcome client ' + client.id);
  });

  socket.of('/upandrunning').on('connection', function(client) {
    console.log('Client connected to Up and Running namespace.');
    return client.send("Welcome to 'Up and Running'");
  });

  socket.of('/weather').on('connection', function(client) {
    console.log('Client connected to Weather namespace.');
    return client.send("Welcome to 'Weather Updates'");
  });

}).call(this);

//# sourceMappingURL=server.js.map
