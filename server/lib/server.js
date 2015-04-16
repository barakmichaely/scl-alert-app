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

// This request is still under construction, attempted scraping to extract data from provided user email
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

// (Verification Step 1) This Request is asking for a @pace.edu email to be entered 
app.post('/verification/:data',function(req, res){
	
	try{

		var emailAddress = req.params.data;

		report.checkEmail(emailAddress);

		res.send(200);}
	catch(e){
		console.log("Invalid Error");
		res.send(400);
	}
});


// (Verification Step 5) This Request is asking for the code sent to the email to be entered
app.post('/verification/code/:data',function(req, res){
	
		var receivedCode = req.params.data;
		//console.log("This was entered: "+testCode);
		if (report.checkCode(receivedCode)==true){
			res.send(200);
		}
		else{
			res.send(418);
		}
});

// Respond to a GET Request at address 'localhost:8080/report/:data' with a message
app.post('/report/:data', function(req, res) {

    // type stuff like below
    //{"name":"evan","date":"Jun 11th 2013","time":"3:12 PM","report":"blahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblah"}
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