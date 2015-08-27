// only going to deal with requests & map data to other files
// mailing script
var postmark = require("postmark")('f8536579-7284-4950-9e3d-977cc96332d0');
module.exports = {
    
  // below is temporary alert
    testalert: {
        "name": "hs20139n",
        "location": [40.7134519,-74.003797],
        "date": "04/09/2015",
        "time": "3:34PM",
        "contacts": ["1234567890", "1234567890", "1234567890", "1234567890", "1234567890"]
    },

    report: function(data) {
        //{"name":"barak","date":"Jun 11th 2013","time":"3:12 PM","report":"blahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblah"}  
        var subjectLine = "Sexual Harrassment Report!"
        var emailTextBody = "Name: " + data["name"] + "\n" + "Date of Incident: " + data["date"] + "\n" + "Time of Incident: " + data["time"] + "\n\n" + data["report"];

        email(subjectLine, emailTextBody);

        return "This is the Report page";
    },
    alert: function(data) {
        var subjectLine = "Sexual Harrassment Alert!"
        var alertData = data["name"] + " is in trouble!" + "\n\n" + "Alert sent from this location: " + getGoogleMapLink(data["location"]) + "\n" + "at " + data["time"] + " on " + data["date"] + "\n\n" + "If you can, try to reach out to " + data["name"] + " or alert the authorities.";

        email(subjectLine, alertData);

        // because SMS is not set up, this formatted data currently has no where to go. 
        return alertData;
    }
};
function  getGoogleMapLink(location) {
      
        return "https://www.google.com/maps/place/" +"/@" + location.toString() + ",18z/data=!4m2!3m1!1s0x0:0x0";

}

function email(emailTextSubject, emailTextBody) {
    postmark.send({
        "From": "bm09148n@pace.edu",
        "To": "barbarianmike15@gmail.com",
        "Subject": ''+emailTextSubject+'',
        "TextBody": '' + emailTextBody + '',
        "Tag": "Important"
    }, function(error, success) {
        if (error) {
            console.error("Unable to send via postmark: " + error.message);
            return;
        }
        console.info("Sent to postmark for delivery")
    });
}