var BinaryServer = require('binaryjs').BinaryServer;
var fs = require('fs');
var Mp3Reader = require('./mp3.js');

// Start Binary.js server
var server = BinaryServer({port: 9000});
// Wait for new user connections
server.on('connection', function(socket){
	var file = fs.createReadStream(__dirname + '/polynation.mp3', { bufferSize: 3056 * 44100 / 1152 });
	file = new Mp3Reader(file, 3).read;
	socket.send(file); 
});


// Start static file server
var	app = require('http').createServer(handler),
     io = require('socket.io').listen(app),
     fs = require('fs')
		 url = require('url');

app.listen(1337);
console.log("Listening on port 1337")

function handler (req, res) {
	var pathname = url.parse(req.url).pathname;
	if (pathname == "/") {
		fs.readFile(__dirname + '/static/index.html',
		function (err, data) {
			if (err) {
				res.writeHead(500);
				return res.end('Error loading index.html');
			}
			res.writeHead(200);
			res.end(data);
		});
	}
	else if (pathname == "/js/jquery.js") {
		fs.readFile(__dirname + '/static/js/jquery.js',
		function (err, data) {
			if (err) {
				res.writeHead(500);
				return res.end('Error loading jquery.js');
			}
			res.writeHead(200);
			res.end(data);
		});
	}
	else if (pathname == "/css/style.css") {
		fs.readFile(__dirname + '/static/css/style.css',
		function (err, data) {
			if (err) {
				res.writeHead(500);
				return res.end('Error loading style.css');
			}
			res.writeHead(200);
			res.end(data);
		});
	}
	else {
		fs.readFile(__dirname + '/static/404.html',
		function (err, data) {
			if (err) {
				res.writeHead(500);
				return res.end('Error loading 404.html');
			}
			res.writeHead(200);
			res.end(data);
		});
	}
}
