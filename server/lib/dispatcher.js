/* DISPATCHER */
/* TODOs
	-Format Alert in: AlertToText()
	-Format Both Types of Reports in : ReportToText()
	-Send ERROR Codes in Responses
	-Set Actual Admin Email Addresses (from a json file)
	-Add Support for Twilio
		*SMS
		*Automated Voice Call
*/

var fs = require('fs'),
	email = require('./email');

var openRequests = {},
	openVoiceMessages = {'testid': 'I just called to say I love you'},
	requestCounter = 0,
	serverUrl = global.myUrl,//'localhost:8080', //'sclapp.herokuapp.com',
	fileLocation = 'open-requests.cache'; // __dirname + '/caches/open-reports.cache';


StartCheckOpenRequests();

function StartCheckOpenRequests () {
	// Interval in minutes
	var interval = 60;
	// Load open reports from cache file, just in case of crash or error
	LoadOpenRequests();
	// Chacks for unsent, but verified reports every *interval* amount of time
	setInterval( CheckOpenRequests, (interval*1000*60) );
}

function CheckOpenRequests () {
	for (var id in openRequests) {
		var data = openRequests[id];

		if (data.sent) {
			return;
		}

		switch (data.type) {
			case 'report':
				DispatchReport(data);	
				break;
			case 'alert':
				DispatchAlert(data);
				break;
			case 'webreport':
				if (data.verified) {
					DispatchWebreport(data);
				} else {
					SendVerificationLink(id);
				}
				break;
		}
	}
}

function CleanupRequests() {
	for (var key in openRequests) {
		console.log("cleanup?  " + openRequests[key].sent);
		if (openRequests[key].sent == true) {
			delete openRequests[key];
			console.log("shoulda deleted");
		}
	}
	SaveOpenRequests();
}

function LoadOpenRequests () {
	// load from file
	fs.readFile(fileLocation, function(err,data) {
		if (err) {
			console.log('loading error')
			return;
		}
		if (data != null) {
			var json = {};
			try {
				json = JSON.parse(data);
			}
			catch (error) {
				console.log('parse error: ' + error);
			}
			finally {
				openRequests = json;
				
				console.log('OPEN REQUESTS');
				console.log(openRequests);

				CleanupRequests();
				CheckOpenRequests();
			}
		}
	})
}
function SaveOpenRequests () {
	console.log('about to save: ')
	console.log(openRequests);
	// save to file
	try {
		var dataString = JSON.stringify(openRequests);
		fs.writeFileSync(fileLocation, dataString);	
		console.log('saved Successfully?')
	}
	catch (e) {
		console.log('error saving file')
	}
}
function AddOpenRequest (key,value) {
	openRequests[key] = value;
	SaveOpenRequests();
	console.log(openRequests);
}
function UpdateOpenRequest (id,key,value) {
	openRequests[id][key] = value;
	SaveOpenRequests();
}

function processAlert (alert) {
	var id = CreateRequestId();

	AddOpenRequest(id,alert);
	DispatchAlert(alert, function () {
		UpdateOpenRequest(id,'sent',true);
			
		CleanupRequests();
	});
}
function processReport (report) {
	var id = CreateRequestId();

	AddOpenRequest(id,report);
	DispatchReport(report, function () {
		UpdateOpenRequest(id,'sent',true);
			
		CleanupRequests();
	});
}
function processWebreport (webreport) {
	var code = CreateVerificationCode();

	webreport.type = 'webreport';
	AddOpenRequest(code,webreport);
	SendVerificationLink(code);
}
function processWebreportVerificationCode (code,callback) {
	if (openRequests[code] != null) {

		UpdateOpenRequest(code,'verified',true);

		DispatchWebreport(openRequests[code], function() {
			UpdateOpenRequest(code,'verified',true);
			UpdateOpenRequest(code,'sent',true);
			
			CleanupRequests();

			if (callback) callback('Verified Successfully!Your report has been submitted.');
		});
	} else {
		if (callback) callback('Umm...Thie Verification Code is Invalid.<br>Perhaps the link has expired');
	}
}
function getVoiceMessage (code) {
	var msg = openVoiceMessages[code]; 
	
	// remove openVoiceMessage?
		// or wait till after call has finished?

	return msg;
}

function DispatchAlert(alert,callback) {
	var emailData = {
			'to'	 : alert.adminemail,
			'subject': 'Emergency Alert!',
			'body'	 : AlertToText(alert)
		};

	/////// Dispatching Options
	// Email
	email(emailData, function (error,success) {
		if (error) console.log('error sending report');
		if (success && callback) callback();
	});
	// SMS
	// Automated Voice Call
}


function DispatchReport(report,callback) {
	var emailData = {
			'to'	 : report.adminemail,
			'subject': 'New Report from App',
			'body'	 : ReportToText(report)
		};
		
	email(emailData, function (error,success) {
		if (error) console.log('error sending report');
		if (success && callback) callback();
	});
}


function DispatchWebreport(webreport,callback) {
	var emailData = {
			'to'	 : webreport.adminemail,
			'subject': 'New Web Report',
			'body'	 : ReportToText(webreport)
		};

	email(emailData, function (error,success) {
		if (error) console.log('error sending web report');
		if (success && callback) callback();
	});
}

function SendVerificationLink (code) {
	var report = openRequests[code];
	var link = '';

	// **for testing. Check if url already includes http
	if (serverUrl.match('http') == null) { 
		link = 'http://';
	}
	link += serverUrl + '/webreportverification/' + code;

	var emailData = {
			'to'	 : report.email!=null? report.email : 'bm09148n@pace.edu',
			'subject': 'Report Verification Link',
			'body'	 : 'Click this link to verify your identity \n' + link
		};

	email(emailData, function (error,success) {
		if (error) console.log('error sending verification link');
		CleanupRequests();
	});
}

function CreateVerificationCode (codeLength) {
	var chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
	var code = '';

	if (codeLength == null) codeLength = 6;

	for (var i = 0; i < codeLength; i ++) {
		var randomPosition = Math.floor( Math.random() * (chars.length-1) );
		code += chars.charAt(randomPosition);
	}

	// Regenerate if code already exists..
	if (openRequests[code] != null) {
		return CreateVerificationCode(codeLength);
	}

	return code;
}

function CreateRequestId () {
	var id = 'request' + requestCounter.toString();
	
	requestCounter ++;
	// Check id doesn't already exist. This could happen from loading saved reports.
	if (openRequests[id] != null) return CreateRequestId();

	return id;
}

function ReportToText (report) {
	var	type = (report.type)? report.type : 'report',
		reportText = (report.type == report)? '--App Report-- \n' : '--Web Report-- \n';

	// Remove unnecessary properties
	delete report.verified;
	delete report.adminemail;
	delete report.sent;
	delete report.type;

	// Convert Keys and Values to a long string
    for (var key in report) {
    	var value = report[key];
    	if (value != null && value != 'null' && value != undefined) {
        	reportText += formatKeys(key) + ': ' + value.toString();
        	reportText += '  \n';
    	}
    }

    return reportText;
}

function AlertToText (alert) {
	return 'incomplete alert body';
}

function formatKeys (key) {
	var newKey = '';
	for (var i = 0; i < key.length; i++) {
		if (key.charAt(i) == '_') {
			newKey += ' ';
		} else {
			newKey += key.charAt(i);	
		}
	}
	return newKey.capitalizeFirstLetter();
}

String.prototype.capitalizeFirstLetter = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
};

module.exports = {
	newAlert : processAlert,
	newReport : processReport,
	newWebreport : processWebreport,
	webreportVerification : processWebreportVerificationCode,
	getVoiceMessage : getVoiceMessage
};


