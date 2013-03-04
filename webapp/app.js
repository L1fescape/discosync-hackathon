/**
 * Variables
 */
var port = 1337;


/**
 * Module dependencies.
 */

var express = require('express')
	, routes = require('./routes')
  , http = require('http')
  , path = require('path')
	, fs = require('fs')
	, ogg = require('ogg')
	, Firebase = require('./firebase-node')


/**
 * Create and configure express.
 */

var app = express();
app.configure(function(){
  app.set('port', process.env.PORT || port);
  app.set('views', __dirname + '/views');
	app.use(express['static'](__dirname + '/views'));
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
});


/**
 * Set development mode for debugging.
 */
app.configure('development', function(){
  app.use(express.errorHandler());
});


/**
 * Define our routes.
 */

// Index
app.get('/', routes.index);
// Sample song with chunked responses

/**
 * Setup ogg decoder
 */
var decoder = new ogg.Decoder();
var encoder = new ogg.Encoder();
var file = __dirname + '/AmorFati.ogg'
var disco = new Firebase('https://disco-sync.firebaseio.com/');
var out = path.resolve(path.dirname(file), 'copy of ' + path.basename(file));
var getKeys = function(obj){
   var keys = [];
   for(var key in obj){
      keys.push(key);
   }
   return keys;
}
decoder.on('stream', function (stream) {

  // we match the serial numbers, though we could also get random ones instead
  var outStream = encoder.stream(stream.serialno);

  // for each "page" event, force the output stream to flush a page of its own.
  // the first time this is emitted there won't have been any "packets" queued
  // yet, but it's nothing to worry about...
  stream.on('page', function (page, done) {
    outStream.flush(done);
  });

  // for each "packet" event, send the packet to the output stream untouched
  stream.on('packet', function (packet, done) {
    outStream.packetin(packet, done);
  });
	
  // at the end of each stream, force one last page flush, for any remaining
  // packets in the stream. this ensures the "end" event gets fired properly.
  stream.on('eos', function () {
    outStream.flush(function (err) {
      if (err) throw err;
    });
  });
});
fs.createReadStream(file).pipe(decoder);
// the OGG file output from the Encoder instance gets piped to the output file
encoder.pipe(fs.createWriteStream(out));
encoder.on('_page', function() {
	console.log("asdfasdf");
});
encoder.on('end', function () {
  console.error('created copy of %j as %j', file, out);
});


/*var readStream = fs.createReadStream(file);
readStream.on('data', function(packet) {
	console.log("sending packet");
	disco.child('stream').push(packet, function(resp) { console.log(resp); });
});*/

/** 
 * Initialize listener
 */
http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
