// only going to deal with requests & map data to other files
// mailing script
var postmark = require("postmark")('f8536579-7284-4950-9e3d-977cc96332d0');

// Initialized List variable to store Emails and their matching Verification Codes
var list = [];

module.exports = {
    // below is temporary alert stored in a variable
    testalert: {
        "name": "eiman",
        "location": [40.7134519, -74.003797],
        "date": "04/09/2015",
        "time": "3:34PM",
        "contacts": ["1234567890", "1234567890", "1234567890", "1234567890", "1234567890"]
    },

    report: function(data) { 
        var subjectLine = "Sexual Harrassment Report!"

        var reportObjectArray = [];
        for (var key in data) {
            reportObjectArray.push(data[key].toString());
        }

        var reportData = "Name: " + reportObjectArray[0] + "\n" + "Date of Incident: " + reportObjectArray[1] + "\n" + "Time of Incident: " + reportObjectArray[2] + "\n\n" + reportObjectArray[3];

        email(subjectLine, reportData);

        return "This is the Report page";
    },
    alert: function(data) {
        var subjectLine = "Sexual Harrassment Alert!"

        var alertObjectArray = [];
        for (var key in data) {
            alertObjectArray.push(data[key]);
        }

        var alertData = alertObjectArray[0] + " is in trouble!" + "\n" + "Alert sent from this location: " + getGoogleMapLink(alertObjectArray[1]) + "\n" + "at " + alertObjectArray[3] + " on " + alertObjectArray[2] + "\n" + "If you can, try to reach out to " + alertObjectArray[0] + " or alert the authorities.";


        email(subjectLine, alertData);

        // because SMS is not set up, this formatted data currently has no where to go. 
        return alertData;
    },

    // Checks to see if email matches @pace.edu
    checkEmail: function(givenEmail) {

        if (givenEmail.indexOf("@pace.edu") != -1) {

            combinePair(givenEmail);

        } else {
            console.log("wrong email");
        }
    },

    // Checks to see if email and code match in the list
    checkCode: function(givenEmail, givenCode) {

        for (var index = 0; index < list.length; index++) {

            if (list[index].email == givenEmail) {

                if (list[index].code == givenCode) {

                    console.log("Your code matches!");
                    
                    return true;
                } else {
                    console.log("Incorrect verification code.");
                    return false;
                }
            }
        }
    },
    //Lets user know whether their email is registered or not
    removeFromList: function(givenEmail,givenCode){
      
      for (var index = 0; index < list.length; index++) {

            if (list[index].email == givenEmail) {

                if (list[index].code == givenCode) {

                    console.log("Server acknowledges that App completed registration");

                    list.splice(index, 1);
      
                    return true;
                } else {
                    console.log("Something went wrong.");
                    return false;
                }
            }
        }      

    }
};

// Retrieves Google Maps coordinates of the user's location
function getGoogleMapLink(location) {

    return "https://www.google.com/maps/place/" + "/@" + location[0].toString() + "," + location[1].toString() + ",18z/data=!4m2!3m1!1s0x0:0x0";

}

// Once email is ensured to be of the Pace domain, it is then combined with a code
function combinePair(checkedEmail) {

    code = generateCode(4);

    var emailCodePair = {
        "email": checkedEmail,
        "code": code
    }

    list.push(emailCodePair);

    sendCode(emailCodePair);

}

// Generates a randomized code of a certain length
function generateCode(len) {
    var text = "";
    var charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for (var i = 0; i < len; i++) {
        text += charset.charAt(Math.floor(Math.random() * charset.length));
    }
    return text;
}

// Sends email with the verification code
function sendCode(emailCodePair) {

    postmark.send({
        "From": "bm09148n@pace.edu",
        "To": "hs20139n@pace.edu",
        "Subject": "Verification code for Sexual Harassment App!",
        "TextBody": "Type this into POSTMAN localhost:8080/verification/" + emailCodePair.email + "/" + emailCodePair.code,
        "Tag": "Important"
    }, function(error, success) {
        if (error) {
            console.error("Unable to send via postmark: " + error.message);
            return;
        }
        console.info("Sent to postmark for delivery")
    });
}

// Sends email with the user's report or their alert
function email(emailTextSubject, emailTextBody) {
    postmark.send({
        "From": "bm09148n@pace.edu",
        "To": "hanastanojkovic@gmail.com",
        "Subject": '' + emailTextSubject + '',
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