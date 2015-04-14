// only going to deal with requests & map data to other files
// mailing script
var postmark = require("postmark")('f8536579-7284-4950-9e3d-977cc96332d0');
module.exports = {
    testalert: {
        "name": "Barak",
        "location": [1, 2],
        "date": "04/09/2015",
        "time": "3:34PM",
        "contacts": ["1234567890", "1234567890", "1234567890", "1234567890", "1234567890"]
    },

    report: function(data) {
        // assume data received will be formatted in this order.
        //{"name":"barak","date":"Jun 11th 2013","time":"3:12 PM","report":"blahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblah"}  

        var reportObjectArray = [];

        for (var key in data) {
            reportObjectArray.push(data[key].toString());
        }

        var emailTextBody = "------" + "\n" + "REPORT" + "\n\n" + "------" + "\n" + "Name: " + reportObjectArray[0] + "\n" + "Date of Incident: " + reportObjectArray[1] + "\n" + "Time of Incident: " + reportObjectArray[2] + "\n\n\n" + "Report: " + reportObjectArray[3];

        email(emailTextBody);

        return "This is the Report page";
    },
    alert: function(data) {
        // assume data received will be formatted in this order.

        var alertObjectArray = [];
        for (var key in data) {
            alertObjectArray.push(data[key].toString());
        }

        var alertData = "------" + "\n" + "ALERT!" + "\n" + "------" + "\n" + alertObjectArray[0] + " is in trouble!" + "\n" + "Alert sent from this location: " + alertObjectArray[1] + "\n" + "at " + alertObjectArray[3] + " on " + alertObjectArray[2] + "\n" + "If you can, try to reach out to " + alertObjectArray[0] + " or alert the authorities.";

        console.log(alertData)

        // because SMS is not set up, this formatted data currently has no where to go. 
        return alertData;
    }
};

function email(emailTextBody) {
    postmark.send({
        "From": "bm09148n@pace.edu",
        "To": "hanastanojkovic@gmail.com",
        "Subject": "Sexual Harassment Report!",
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