////////
// SETUP
////////

// Import the 'express' module
var express = require('express'),
	app = express(),
	postmark = require("postmark")('f8536579-7284-4950-9e3d-977cc96332d0');
	//report = require('./report');

// Set the Port Number for This Server to Listen To (8080)
app.set('port', (process.env.PORT || 8080));


///////////
// MAIN CODE
///////////

// Respond to a GET Request at address 'localhost:8080/' with a message



app.get('/:sara/:x/:xy', function (req, res) {
  res.send(req.params.sara);
});




// Respond to a GET Request at address 'localhost:8080/report/:data' with a message
app.get('/report/:data', function (req,res) {
	res.send(req.params.data);
});

// Respond to a GET request at address 'localhost:8080/info' with a file
app.get('/info', function (req,res) {
  res.sendfile('info.json');
});

//app.get('/test', function(req,res){
 //res.send(report.test());
//});


////////////
// RUN SERVER
////////////

// Start Listening at set Port (Starts Server)
app.listen(app.get('port'), function() {
	// Outputs a Message in the Command Line When the Server Has Started Listening
	console.log("scl-alert-app is running at localhost:" + app.get('port'));
});