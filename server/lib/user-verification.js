// user verification
var openUsers = {},
	email = require('./email');

// Start Automatic Cleanup of Verified Emails
StartCleanup();
//

function StartCleanup () {
	var interval = 1; // in minutes
	setInterval( Cleanup , (interval*1000*60) );
}

function Cleanup () {
	// Remove verified users from openUsers.
	for (var key in openUsers) {
		if (openUsers[key].verified) {
			delete openUsers[key];
		}
	}
}

function processNewUser (userEmail, callback) {
	var exists = false;
	
	//convert email to lowercase, just in case
	userEmail = userEmail.toLowerCase();

	// Check Valid Pace Email
	if (!CheckValidEmailFormat(userEmail)) {
		console.log("badd emiall");
		console.log(userEmail);
		if (callback != null) callback(false);
		return;
	}

	for (var key in openUsers) {
		if (openUsers[key].userEmail == userEmail) {
			exists = true;
			break;
		}
	}

	if (exists) {
		console.log('email already exists in cache');
	} else {
		var id = CreateVerificationCode();

		openUsers[id] = {
			'userEmail' : userEmail
		};
		SendVerificationCode(id);
	}

	if (callback != null) callback(true);
}

function processVerificationCode (code,callback) {
	// convert characters to uppercase, to match stored codes, since this code is NOT case sensitive
	code = code.toUpperCase();

	if (openUsers[code] != null) {
		openUsers[code].verified = true;
		callback(true,'Sucessfully Verified.');
	} else {
		callback(false,'Invalid Code!');
	}
}

function SendVerificationCode (code) {
	var userEmail = openUsers[code].userEmail;
	console.log('saved email: ' + userEmail);
	console.log('the code: ' + code);
	var	emailData = {
			'to'	 : userEmail? userEmail : 'bm09148n@pace.edu',
			'subject': 'User Verification Code',
			'body'	 : 'Copy this code into the app :  ' + code + ''
		};

	email(emailData, function (error,success) {
		if (error) console.log('error sending user verification link');
	});
}

function CreateVerificationCode (codeLength) {
	var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
	var code = '';

	if (codeLength == null) codeLength = 5;

	for (var i = 0; i < codeLength; i ++) {
		var randomPosition = Math.floor( Math.random() * (chars.length-1) );
		code += chars.charAt(randomPosition);
	}

	// Regenerate if code already exists..
	if (openUsers[code] != null) {
		return CreateVerificationCode(codeLength);
	}

	return code;
}

function CheckValidEmailFormat (userEmail) {
	// specifically check if ends with '@pace.edu'
	var re = /^([\w-]+(?:\.[\w-]+)*)@pace.edu$/i;
    return re.test(userEmail);
}

module.exports = {
	newUser : processNewUser,
	verifyUser : processVerificationCode
};