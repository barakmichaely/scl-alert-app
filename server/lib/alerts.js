/*  ALERTS SETUP
    Alert JSON data is gathered from the report POST request.
    The below function organizes the JSON data into an email.
    The recipient can be changed to whomever is working on this code for testing.
*/

var email = require('./email'),
    recipient = "hanastanojkovic@gmail.com",
    subjectLine = "Sexual Harrassment Alert!",
    alertObjectArray = []
    
module.exports = { 
    alert: function(data) {

        for (var key in data) {
            alertObjectArray.push(data[key]);
        }

        var alertData = alertObjectArray[0] + " is in trouble!" + "\n" + 
                          "Alert sent from this location: " + getGoogleMapLink(alertObjectArray[1]) + "\n" +
                          "at " + alertObjectArray[3] + " on " + alertObjectArray[2] + "\n" + 
                          "If you can, try to reach out to " + alertObjectArray[0];
        email.email(recipient, subjectLine, alertData);
        
        return alertData;
    }
};

function getGoogleMapLink(location) {
        return "https://www.google.com/maps/place/" +"/@" +location[0].toString() +","+location[1].toString()+ ",18z/data=!4m2!3m1!1s0x0:0x0";
}
