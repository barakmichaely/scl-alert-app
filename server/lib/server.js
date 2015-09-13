/* SERVER */


// global.myUrl = 'https://localhost:8080'; // local
// global.myUrl = 'sclapp.herokuapp.com'; // heroku server
global.myUrl = 'https://a0b95e6.ngrok.com'; // ngrok


// Import the 'express' module
var express = require('express'),
    app = express(),
    bodyParser = require('body-parser'),
    report = require('./report'),
    cheerio = require('cheerio'),
    _ = require('lodash');

var processNewReport = require('./webreport').processNewReport;
var processVerificationCode = require('./webreport').processVerificationCode;
var createVerificationCode = require('./webreport').createVerificationCode;

var userVerification = require('./user-verification');

var dispatcher = require('./dispatcher');

var sms = require('./sms');

// Set the Port Number for This Server to Listen To (8080)
app.set('port', (process.env.PORT || 8080));

// app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded



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






























//// Partially Completed

/* --  User Verification  --  */

// Verify New User
app.get('/newuser/:email', function(req, res) {
    userVerification.newUser(req.params.email, function (valid) {
        if (valid) {
            res.send('Valid Email. Emailed User a Verification Code.');
        } else {
            res.send('invalid email. Or something...');
        }
    })
});
// Verify New User Code
app.get('/verifyusercode/:code', function(req, res) {
    userVerification.verifyUser(req.params.code, function (valid, message) {
        if (valid) {
            res.send(message);
        } else {
            res.send(message);
        }
    })
});

/* --  Web Reports  --  */

// New Web Report. Report Message is in POST Body.
app.post('/webreport', function(req, res) {
    console.log('--Web Report--');
    console.log(req.body);
    console.log('--------------')

    dispatcher.newWebreport(req.body);
    //processNewReport(req.body);
    
    res.send('Sent!');
});
// Verify Web Report
app.get('/webreportverification/:code', function(req, res) {

    dispatcher.webreportVerification(req.params.code, function (message) {
        res.send('<html><head><title>Verification</title></head><body><h4 style="color:black;font-weight:300">' + message + '</h2></body></html>');
    });

    // processVerificationCode(req.params.code, function (message) {
    //     res.send('<html><head><title>Verification</title></head><body><h4 style="color:black;font-weight:300">' + message + '</h2></body></html>');    
    // })
});


// NOT YET COMPLETED

/* --  App Alerts  --  */

// New Alert from App. Alert Message is in POST Body.
app.post('/appalert', function (req, res) {
    // TODO: Make sure alert was properly sent or saved before sending response

    /* alert structure is recieved as a json object. No parsing necessary */
    dispatcher.newAlert(req.body);
    res.send('Sent Alert!');
});

/* --  App Reports  --  */
// New Report from App. Report Message is in POST Body.
app.post('/appreport', function (req, res) {
    // TODO: Make sure report was properly sent or saved before sending response

    /* report structure is recieved as a json object. No parsing necessary */
    dispatcher.newReport(req.body);
    res.send('Sent Report!');
});

app.get('/sms/:msg', function (req,res) {
    sms.sms(req.params.msg);
    res.send('texted')
});
app.get('/call/:msg', function (req,res) {
    sms.voicecall(req.params.msg);
    res.send('called')
});

// This Returns a Voice Message XML, based on the code of the report
app.get('/voicemessagexml/:code', function (req,res) {    
    // Create a Voice Message XML from stored alert message
    var xml = sms.createXML( dispatcher.getVoiceMessage(req.params.code) );
    // Send the newly generated xml in response
    res.setHeader('content-type', 'text/xml');
    res.end(xml);
});



////////////
// RUN SERVER
////////////

// Start Listening at set Port (Starts Server)
app.listen(app.get('port'), function() {
    // Outputs a Message in the Command Line When the Server Has Started Listening
    console.log("scl-alert-app is running at localhost:" + app.get('port'));
});