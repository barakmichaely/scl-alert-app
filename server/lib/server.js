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

// (Verification Step 1) (SIGN UP) This Request is asking for a @pace.edu email to be entered 
app.post('/verification/:email',function(req, res){
	try{
		var receivedEmail = req.params.email;
		report.checkEmail(receivedEmail);
		res.send(200);}
	catch(e){
		console.log("Invalid Error");
		res.send(400);
	}
});


// (Verification Step 5) (VERIFY USER) This Request is asking for the code sent to the email to be entered
app.post('/verification/:email/:code',function(req, res){
		var receivedCode = req.params.code;
		var receivedEmail = req.params.email;

		if (report.checkCode(receivedEmail,receivedCode)==true){
			res.send(200);
		}
		else{
			res.send(418);
		}
});

// Respond to a POST Request at address '/report/:data' 
app.post('/report/:data', function(req, res) {
    // Example : {"name":"evan","date":"Jun 11th 2013","time":"3:12 PM","report":"text"}
    try {
        var parsedData = JSON.parse(req.params.data);

        report.report(parsedData);
        res.send(200);
    } catch (e) {
        console.log("Invalid Error");
        res.send(400);
    }

});

// Respond to a POST Request at address '/alert/:data'
app.post('/alert/:data', function(req, res) {

// Testing Purposes, /alert/test
	if (req.params.data == "test") {
    	report.alert(report.testalert);
	}
// the else is for actual data passed in. Make sure encoding of the URL is correct.
// Example: {"name":"eiman","location":[40.7134519,-74.003797],"date":"04.09.2015","time":"3:34PM","contacts":["Phone Number 1","Phone Number 2","Phone Number 3","Phone Number 4","Phone Number 5"]}
	else {
   		report.alert(JSON.parse(req.params.data));
   	}

    res.send(200);
});

// Respond to a POST Request at address '/changeRecievingEmailTo/:data'
app.post('/changeRecievingEmailTo/:data', function(req,res){
	if (req.params.data.indexOf("@")!=-1){
	var email = req.params.data;
	report.changeRecipient(email);
	res.send(200);
	}
	else {
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