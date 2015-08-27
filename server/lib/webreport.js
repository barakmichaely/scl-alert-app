// Web Report
var postmark = require("postmark")('f8536579-7284-4950-9e3d-977cc96332d0');
var openReports = {};
var serverUrl = 'sclapp.herokuapp.com';

function processNewReport (report) {
	// Gets Object
	console.log('processing new report')
	// report.email = 'dg83196n@pace.edu';
	var newCode = createVerificationCode();
	openReports[newCode] = report;
	emailVerificationLink(newCode);

}

function createVerificationCode () {
	console.log('creating code')
	var chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
	var codeLength = 6;
	var code = ''
	for (var i = 0; i < codeLength; i ++) {
		var randomPosition = Math.floor( Math.random() * (chars.length-1) )
		code += chars.charAt(randomPosition);
	}

	return code;
}

function processVerificationCode (code, callback) {	
	if (openReports[code] != null) {
		emailReport(openReports[code], function() {
			// success function
			delete openReports[code];
			console.log('--Open Reports NOW--');
			console.log(openReports)
			if (callback) callback('Verified Successfully!Your report has been submitted.');
		});
	} else {
		callback('Umm...Thie Verification Code is Invalid.<br>Perhaps the link has expired')
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

