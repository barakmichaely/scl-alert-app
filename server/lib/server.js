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

// var coordinates = [40.711365, -74.005132];
// var formattedCoordinates = [];
// var url = "https://www.google.com/maps/place/" +formattedCoordinates +"/@" +coordinates[0].toString() +","+coordinates[1].toString()+ ",18z/data=!4m2!3m1!1s0x0:0x0";

console.log(url);
//https://www.google.com/maps/place/49°28'04.8%22N+17°06'54.5%22E/@49.4680001,17.1151401,18z/data=!4m2!3m1!1s0x0:0x0






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
	//	console.log(req.params.data);
		var parsedData = JSON.parse(req.params.data);
	//	console.log(parsedData.name);
		//file.function(parameter)
		report.report(parsedData);

		report.email(parsedData);



	} catch (e){
		console.log("Invalid Error");
	}
 
//data is getting sent to test function in report.js file

	res.send("hello");


	res.send("Report sent to email");
});

app.post('/alert', function (req, res) {
	report.alert(report.testalert);
  	res.send('Alert went through!');

});

// Respond to a GET request at address 'localhost:8080/info' with a file
app.get('/info', function (req,res) {
	res.sendfile('info.json');
});

////////////
// RUN SERVER
////////////

// Start Listening at set Port (Starts Server)
app.listen(app.get('port'), function() {
	// Outputs a Message in the Command Line When the Server Has Started Listening
	console.log("scl-alert-app is running at localhost:" + app.get('port'));
});