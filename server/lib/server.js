////////
// SETUP
////////

// Import the 'express' module
var express = require('express'),
	app = express();
// Set the Port Number for This Server to Listen To (8080)
app.set('port', (process.env.PORT || 8080));


///////////
// MAIN CODE
///////////

// Respond to a GET Request at address 'localhost:8080/' with a message


app.get('/', function (req, res) {
  res.send('GET request to homepage');
});

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