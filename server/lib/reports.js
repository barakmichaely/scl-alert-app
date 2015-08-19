/*  REPORTS SETUP
    Report JSON data is gathered from the report POST request.
    The below function organizes the JSON data into an email.
    The recipient can be changed to whomever is working on this code for testing.
*/

var email = require('./email'),
    recipient = "hanastanojkovic@gmail.com",
    subjectLine = "Sexual Harrassment Report!",
    reportObjectArray = []

module.exports = { 
    report: function(data) {
 
        for (var key in data) {
            reportObjectArray.push(data[key].toString());
        }

        var reportData = "Name: " + reportObjectArray[0] + "\n" +
                         "Date of Incident: " + reportObjectArray[1] + "\n" + 
                         "Time of Incident: " + reportObjectArray[2] + "\n\n" + reportObjectArray[3];

        email.email(recipient, subjectLine, reportData);

        return reportData;
    }
};