var express = require('express');
var app = express();
var qs = require('querystring');

app.get('/login', function(request, response){
	console.log("Login request");
	if (request.method == 'POST') {
        var body = '';
        request.on('data', function (data) {
            body += data;
        });
        request.on('end', function () {

            var POST = qs.parse(body);
            // use POST

        });
	}
});
console.log("Now listening on port 8000");
app.listen(8000);
