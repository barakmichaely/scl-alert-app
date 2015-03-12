////////
// SETUP
////////

// Import the 'express' module
var express = require('express'),
 	app = express(),
	postmark = require("postmark")(process.env.POSTMARK_API_TOKEN);
// Set the Port Number for This Server to Listen To (5000)
app.set('port', (process.env.PORT || 5000));

///////////
// MAIN CODE
///////////

// Respond to a GET Request at address 'localhost:5000/' with a message
app.get('/:data', function (req,res) {
	postmark.send({
	    "From": "bm09148n@pace.edu",
	    "To": "hanastanojkovic@gmail.com",
	    "Subject": ":)",
	    "TextBody": "STATIC TEXT",
	    "Tag": "important"
	}, function(error, success) {
	    if(error) {
	        console.error("Unable to send via postmark: " + error.message);
	       return;
	    }
	    console.info("Sent to postmark for delivery")
	});

	res.send(req.params.data);
	//res.send(req.params.data);
	//res.send(JSON.parse(req.params.data));
});

////////////
// RUN SERVER
////////////

// Start Listening at set Port (Starts Server)
app.listen(app.get('port'), function() {
	// Outputs a Message in the Command Line When the Server Has Started Listening
	console.log("scl-alert-app is running at localhost:" + app.get('port'));
});