/* SMS */

// Twilio Credentials 
var accountSid = 'AC5e9029c9829afec2e18de5cda722088c'; 
var authToken = '61feffbfb19e9e6dfc82141581510ffa'; 
var twilioPhoneNumber = '+16465863267';
var serverUrl = global.myUrl;

//require the Twilio module and create a REST client 
var client = require('twilio')(accountSid, authToken); 
 
function SendSMS (data, callback) {
	client.messages.create({ 
		to: (data.to != null)? data.to : "+12012948083", 
		from: twilioPhoneNumber, 
		body: data != null? data : 'this is a message',   
	}, function(err, message) { 
		console.log('sms : ' + message.sid); 
		if (callback != null) callback(err);
	});
}

function SendVoiceCall (data, callback) {
	var messageId = 'testid';

	client.calls.create({ 
		to: "+12012948083", 
		from: "+16465863267", 
		url: (serverUrl + "/voicemessagexml/" + messageId),
		method: "GET",  
		fallbackMethod: "GET",  
		statusCallbackMethod: "GET",    
		record: "false" 
	}, function(err, call) { 
		console.log('call : ' + call.sid); 
	});
}

function CreateMessageXML (messageString) {
	// Create a twilio xml for voice messages
	var xml = '<?xml version="1.0" encoding="UTF-8"?><Response><Say voice="alice" language="en" loop="2">' + messageString + '</Say></Response>';
	return xml;
}

module.exports = {
	sms : SendSMS,
	voicecall : SendVoiceCall,
	createXML : CreateMessageXML
};