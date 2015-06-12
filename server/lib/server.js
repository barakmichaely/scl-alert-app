////////
// SETUP
////////
// Import the 'express' module
var express = require('express'),
    app = express(),
    report = require('./report'),
    cheerio = require('cheerio'),
    _ = require('lodash');

// Set the Port Number for This Server to Listen To (8080)
app.set('port', (process.env.PORT || 8080));

///////////
// MAIN CODE
///////////

// Respond to a GET Request at address 'localhost:8080/' with a message
app.get('/', function(req, res) {
    res.send('GET request to homepage');
});

app.get('/whitepages', function(req, res) {
	var request = require('request');
	request('https://whitepages.pace.edu/', function (error, response, body) {
	
	if (!error && response.statusCode == 200) {
		$ = cheerio.load(body);

		// below is a loop
		_.each($('#search_scope option'), function(el){
			el = $(el);
			console.log(el.text());
		});

		res.send(body) // Show the HTML for the pace whitepages. 
	}
	
	})
});


// Respond to a GET Request at address 'localhost:8080/report/:data' with a message
app.post('/report/:data', function(req, res) {

    // type stuff like below
    //{"name":"barak","date":"Jun 11th 2013","time":"3:12 PM","report":"blahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblah"}
    try {
        var parsedData = JSON.parse(req.params.data);

        report.report(parsedData);
        res.send(200);
    } catch (e) {
        console.log("Invalid Error");
        res.send(400);
    }

});

app.post('/alert/:data', function(req, res) {

// use this for testing purposes
	if (req.params.data == "test") {

    	report.alert(report.testalert);
	}
// the else is for actual data passed in 
	else {
   
   		report.alert(JSON.parse(req.params.data));
   	}

    res.send(200);

    // missing is an alternate response code if this does not work

});

// Respond to a GET request at address 'localhost:8080/info' with a file
app.get('/info', function(req, res) {
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