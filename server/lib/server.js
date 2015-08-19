/*
	Initializes variables and runs the server
*/
var express = require('express'),
    app = express(),
    report = require('./reports'),
    alert = require('./alerts'),
    verification = require('./verification');
   // cheerio = require('cheerio'); // For whitepages

app.set('port', (process.env.PORT || 8080));
app.listen(app.get('port'), function() {
    console.log("scl-alert-app is running at localhost:" + app.get('port'));
});

/*
	HTTP Requests to Alerts, Reports, and Email Verification
*/

app.get('/', function(req, res) {
    res.send('GET request to homepage');
});

app.post('/report/:data', function(req, res) {
    // Example : {"name":"name","date":"Jun 11th 2013","time":"3:12 PM","report":"this is where information within the report will go"}
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
   	// Example : {"name":"name","location":"12345,678910","date":"01-01-2001","time":"2:35"}
   	try {
   		var parsedData = JSON.parse(req.params.data);
   		alert.alert(parsedData);
		res.send(200);
   	}
   	catch (e) {
   		console.log("Invalid Error");
   		res.send(400);
   	}
});

// Asks for a @pace.edu email to be entered and checks validity
app.post('/verification/:email',function(req, res){
	try{
		var receivedEmail = req.params.email;
		verification.checkEmail(receivedEmail);
		res.send(200);}
	catch(e){
		console.log("Invalid Error");
		res.send(400);
	}
});

// Asks for verification code to be entered and checks validity
app.post('/verification/:email/:code',function(req, res){
		var receivedCode = req.params.code;
		var receivedEmail = req.params.email;

		if (verification.checkCode(receivedEmail,receivedCode)==true){
			res.send(200);
		}
		else{
			res.send(418);
		}
});

/* //[[UNDER CONSTRUCTION]]
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
	
	});
});
*/