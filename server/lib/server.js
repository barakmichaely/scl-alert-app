////////
// SETUP
////////

// Import the 'express' module
var express = require('express'),
	app = express(),
	report = require('./report');

// Set the Port Number for This Server to Listen To (8080)
app.set('port', (process.env.PORT || 8080));

///////////
// MAIN CODE
///////////

// Respond to a GET Request at address 'localhost:8080/' with a message

app.get('/', function (req, res) {
	res.send('GET request to homepage');
});

// Respond to a GET Request at address 'localhost:8080/report/:data' with a message
app.post('/report/:data', function (req,res) {

// type stuff like below
//{"time":"12am","where":"on campus","name":"joe"}
	try {
	//turns "data" into a JSON file 
	
		var parsedData = JSON.parse(req.params.data);
	
		report.report(parsedData);
	
	} catch (e){
		console.log("Invalid Error");
	}
	res.send("Report sent to email");
});

app.post('/alert', function (req, res) {
	report.alert(report.testalert);
  	res.send('Alert went through!');

});

// Respond to a GET request at address 'localhost:8080/info' with a file
app.get('/info', function (req,res) {
	res.sendfile(__dirname + '/info.json');
});

////////////
// RUN SERVER
////////////

// Start Listening at set Port (Starts Server)
app.listen(app.get('port'), function() {
	// Outputs a Message in the Command Line When the Server Has Started Listening
	console.log("scl-alert-app is running at localhost:" + app.get('port'));
});