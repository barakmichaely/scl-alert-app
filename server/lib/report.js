// only going to deal with requests & map data to other files
// mailing script
var postmark = require("postmark")('f8536579-7284-4950-9e3d-977cc96332d0');
module.exports = {

	testMapUrl: "",

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


// receive a report through the request (POST request)
// create an object from its data
// -maybe- save the report to a file (if we choose to save reports) 
// take the object and turn it into a string (and then later format it to make it pretty)
// send it to email! (textbody)

function  getGoogleMapLink(location) {
	return "https://www.google.com/maps/place/" +"/@" +location[0].toString() +","+location[1].toString()+ ",18z/data=!4m2!3m1!1s0x0:0x0";


}

var coordinates = [40.711365, -74.005132]
module.exports.testMapUrl = getGoogleMapLink(coordinates);



	alert:function(data){
    console.log(data);
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

