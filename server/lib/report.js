// only going to deal with requests & map data to other files
// mailing script
var postmark = require("postmark")('f8536579-7284-4950-9e3d-977cc96332d0');
module.exports = {
	report:function(data){
		var array = [];

		for (var key in data){
			array.push(key + ":" + data[key].toString());
		}
		console.log(array);

		return "This is the Report page";
	},
	email:function(){
		postmark.send({
			"From": "bm09148n@pace.edu",
			"To": "hanastanojkovic@gmail.com",
			"Subject": ":)",
			"TextBody": "A different string",
			"Tag": "important"
		}, function(error, success){
			if(error){
				console.error("Unable to send via postmark: " + error.message);
				return;
			}
			console.info("Sent to postmark for delivery")
		});
	}
};

// receive a report through the request (POST request)
// create an object from its data
// -maybe- save the report to a file (if we choose to save reports) 
// take the object and turn it into a string (and then later format it to make it pretty)
// send it to email! (textbody)