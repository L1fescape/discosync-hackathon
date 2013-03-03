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
 * Initialize listener
 */
http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
