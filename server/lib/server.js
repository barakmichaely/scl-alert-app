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

// Respond to a GET request at address 'localhost:8080/' with a message
app.get('/', function(req, res) {
    res.send('GET request to homepage');
});

// (UNDER CONSTRUCTION) Attempted scraping to extract data from provided user email
app.get('/whitepages', function(req, res) {
    var request = require('request');
    request('https://whitepages.pace.edu/', function(error, response, body) {

        if (!error && response.statusCode == 200) {
            $ = cheerio.load(body);

            // below is a loop
            _.each($('#search_scope option'), function(el) {
                el = $(el);
                console.log(el.text());
            });

            res.send(body) // Show the HTML for the pace whitepages. 
        }

    })
});

// Respond to POST request at address 'localhost:8080/verification/:email' with a name@domain.com format
app.post('/verification/:email', function(req, res) {

    try {
        var receivedEmail = req.params.email;

        report.checkEmail(receivedEmail);

        res.send(200);
    } catch (e) {
        console.log("Invalid Error");
        res.send(400);
    }
});

// Respond to POST request at address 'localhost:8080/verification/:email/:code' with a name@domain.com format email and the received 4-digit verification code
app.post('/verification/:email/:code', function(req, res) {

    var receivedEmail = req.params.email;
    var receivedCode = req.params.code;
    
    //try to have check code just to "Check" the code and another function to verify whether everything is correct or not
    if (report.checkCode(receivedEmail, receivedCode) == true) {
        res.send(200);
    } else {
        res.send(418);
    }
});

// Respond to POST request at address 'localhost:8080/sucessfullyRegistered/:email/:code' with provided email and verification code. Server acknowledges that the app registered the email.
app.post('/sucessfullyRegistered/:email/:code', function(req,res){
	
	var receivedEmail = req.params.email;
	var receivedCode = req.params.code;

	if (report.removeFromList(receivedEmail,receivedCode) == true){
		res.send("Your email has been verified!");
	}
	else{
		res.send("Something went wrong.");
	}

});

// Respond to POST request at address 'localhost:8080/report/:data' with a message in this format
// {"name":"evan","date":"Jun 11th 2013","time":"3:12 PM","report":"blahblahblahblah"}
app.post('/report/:data', function(req, res) {

    try {
        var parsedData = JSON.parse(req.params.data);

        report.report(parsedData);
        res.send(200);
    } catch (e) {
        console.log("Invalid Error");
        res.send(400);
    }

});

// Respond to POST request at address 'localhost:8080/alert/test'. For some reason the actual JSON (the else block) does not work.
app.post('/alert/:data', function(req, res) {

    try {
        // use this for testing purposes
        if (req.params.data == "test") {
            report.alert(report.testalert);
        }
        // the else is for actual data passed in. Assume it is already in a JSON format
        else {
            var parsedData = JSON.parse(req.params.data);

            report.alert(parsedData);
        }

        res.send(200);
    } catch (e) {
        console.log("Invalid Error");
        res.send(400);
    }
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