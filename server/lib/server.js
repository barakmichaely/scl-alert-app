////////
// SETUP
////////

// Import the 'express' module
var express = require('express'),
	app = express();
// Set the Port Number for This Server to Listen To (99)
app.set('port', (process.env.PORT || 5000));

///////////
// MAIN CODE
///////////

// Respond to a GET Request at address 'localhost:99/' with a message
app.get('/', function (req,res) {
	res.send("I am a Server");
});

////////////
// RUN SERVER
////////////

// Start Listening at set Port (Starts Server)
app.listen(app.get('port'), function() {
	// Outputs a Message in the Command Line When the Server Has Started Listening
	console.log("scl-alert-app is running at localhost:" + app.get('port'));
});