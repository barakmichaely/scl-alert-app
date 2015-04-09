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
app.get('/report/:data', function (req,res) {

// type stuff like below
//{"time":"12am","where":"on campus","name":"joe"}

	try {
	//turns "data" into a JSON file 
	//	console.log(req.params.data);
		var parsedData = JSON.parse(req.params.data);
	//	console.log(parsedData.name);
		//file.function(parameter)
		report.report(parsedData);
<<<<<<< HEAD
		report.email();
	
=======
		report.email(parsedData);
>>>>>>> ac839adb2cc2197dd5e1bb0c82fd7e34b91a9ca0
	} catch (e){
		console.log("Invalid Error");
	}
 
//data is getting sent to test function in report.js file
<<<<<<< HEAD
	res.send("Report sent to email");
});

app.get('/alert', function(req,res){
	report.alert(report.testalert);
	res.send("Your Alert went through!")
=======
	res.send("hello");
>>>>>>> ac839adb2cc2197dd5e1bb0c82fd7e34b91a9ca0
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