// Web Report
var postmark = require("postmark")('f8536579-7284-4950-9e3d-977cc96332d0');
var openReports = {};
var serverUrl = 'localhost:8080';//'sclapp.herokuapp.com';
var fs = require('fs');
var fileLocation = 'open-reports.cache'; // __dirname + '/caches/open-reports.cache';

start();

function start () {
	// Interval in minutes
	var interval = 60;
	// Load open reports from cache file, just in case of crash or error
	loadOpenReports();
	// Chacks for unsent, but verified reports every *interval* amount of time
	setInterval( resendOpenReports, (interval*1000*60) );
}

function loadOpenReports () {
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
				console.log(error);
			}
			finally {
				openReports = json;
				resendOpenReports();
			}
		}
	})
	// dump to openReports
};
function saveOpenReports () {
	// save to file
	var dataString = JSON.stringify(openReports);
	fs.writeFile(fileLocation, dataString, function (err) {
		if (err) console.log('Saving Error' + err);
		if (!err) console.log('Saved Successfully');
	});

};
function resendOpenReports() {
	console.log('These are the Loaded Reports');
	console.log(openReports);
	for (var key in openReports) {
		var report = openReports[key];
		if (!report.verified) {
			// Resend Verification Code
			emailVerificationLink(key);
		} else if (!report.sent) {
			// Resend Actual Report
			emailReport(report, function() {
				saveOpenReports();
				console.log('I Have Sent All Unsent reports! Huzzah.')
			});
		}
	}
};

function processNewReport (report) {
	// Gets Object
	console.log('processing new report')
	// report.email = 'dg83196n@pace.edu';
	var newCode = createVerificationCode();
	openReports[newCode] = report;
	// save to cache
	saveOpenReports();

	emailVerificationLink(newCode);
}

function createVerificationCode (codeLength) {
	var chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
	var code = '';

	if (codeLength == null) codeLength = 6;

	for (var i = 0; i < codeLength; i ++) {
		var randomPosition = Math.floor( Math.random() * (chars.length-1) )
		code += chars.charAt(randomPosition);
	}

	// Regenerate if code already exists..
	if (openReports[code] != null) {
		return createVerificationCode(codeLength);
	}

	return code;
}

function processVerificationCode (code, callback) {	
	if (openReports[code] != null) {
		openReports[code].verified = true;
		// save
		saveOpenReports();

		emailReport(openReports[code], function() {
			// success function
			openReports[code].verified = true;
			openReports[code].sent = true;
			
			removeSentReports();
			
			//save
			saveOpenReports();
			
			if (callback) callback('Verified Successfully!Your report has been submitted.');
		});
	} else {
		callback('Umm...Thie Verification Code is Invalid.<br>Perhaps the link has expired')
	}
}

function removeSentReports() {
	for (var key in openReports) {
		if (openReports[key].sent == true) {
			delete openReports[key];
		}
	}
}


function emailVerificationLink (code) {
	var report = openReports[code];
	var emailData = {};
	var link = 'http://' + serverUrl + '/webreportverification/' + code;

	emailData.from = 'bm09148n@pace.edu';
	emailData.to = report.email!=null? report.email : 'bm09148n@pace.edu';
	emailData.subject = 'Report Verification Link';
	emailData.body = 'Click this link to verify your identity \n' + link;
	emailData.tag = 'Important';

	sendEmail(emailData, function (error,success) {
		console.log('--Open Reports');
		console.log(openReports)
	})
}

function emailReport (report, callback) {
	console.log('emailing the report')

	var emailData = {};
	emailData.from = 'bm09148n@pace.edu';
	emailData.to = report.adminemail!=null? report.adminemail : 'bm09148n@pace.edu';
	emailData.subject = 'New Web Report';
	emailData.body = reportToText(report);
	emailData.tag = 'Important'

	sendEmail(emailData, function (error,success) {
		if (error) {
			console.log('error sending email')
			return;	
		}
		if (success && callback) callback();
	})
}

function sendEmail (data, callback) {
	postmark.send({
        "From": data.from,
        "To": data.to,
        "Subject": data.subject,
        "TextBody": data.body,
        "Tag": data.tag
    }, callback);
    // callback (error, success)
}	

function reportToText (report) {
	console.log('convertin report to text')
	var reportText = '--Web Report-- \n';

	// Remove unnecessary properties
	delete report.verified;
	delete report.adminemail;
	delete report.sent;

    for (var item in report) {
    	if (report[item] != null && report[item] != 'null' && report[item] != undefined) {
        	reportText += formatKeys(item) + ': ' + report[item].toString();
        	reportText += '  \n';
    	}
    }
    return reportText;
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
}

module.exports = { 
	processNewReport: processNewReport, 
	processVerificationCode : processVerificationCode,
	createVerificationCode: createVerificationCode
}


