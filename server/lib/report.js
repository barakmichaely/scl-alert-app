// only going to deal with requests & map data to other files
// mailing script
var postmark = require("postmark")('f8536579-7284-4950-9e3d-977cc96332d0');
module.exports = {
  testalert: {
  "name":"barak",
  "location": [1,2],
  "date":"04/09/2015",
  "time":"3:34PM",
  "contacts":["1234567890","1234567890","1234567890","1234567890","1234567890"] 
  },

	report:function(data){
		var reportObjectArray = [];

		for (var key in data){
			reportObjectArray.push(key + ":" + data[key].toString());
		}
		console.log(reportObjectArray);
		
    email(reportObjectArray);
		
    return "This is the Report page";
	},
	email:function(data){
		var array = [];

		for (var key in data){
			array.push(key + ":" + data[key].toString());
		}
		//console.log(array);
		postmark.send({
			"From": "bm09148n@pace.edu",
			"To": "ss26468n@pace.edu",
			"Subject": ":)",
			"TextBody": data[key],
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

function email(reportObjectArray){

    postmark.send({
      "From": "bm09148n@pace.edu",
      "To": "hanastanojkovic@gmail.com",
      "Subject": ":)",
      "TextBody": ''+reportObjectArray+'',
      "Tag": "important"
    },
    
    function(error, success){    
      if(error){
        console.error("Unable to send via postmark: " + error.message);
        return;
      }
     
      console.info("Sent to postmark for delivery")
    
    });
}

