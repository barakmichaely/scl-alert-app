// only going to deal with requests & map data to other files
// mailing script
var postmark = require("postmark")('f8536579-7284-4950-9e3d-977cc96332d0');

// (VERIFICATION) Three variables below ... (add more later)
var list = [];
var code;
var counter = 0;
// It's Hana's email by default for testing purposes. If someone else is testing, change the default email to your own please.
var recipient = "hanastanojkovic@gmail.com";

module.exports = {    
  // below is temporary alert stored in a variable
    testalert: {
        "name": "eiman",
        "location": [40.7134519,-74.003797],
        "date": "04/09/2015",
        "time": "3:34PM",
        "contacts": ["1234567890", "1234567890", "1234567890", "1234567890", "1234567890"]
    },
    changeRecipient : function(newEmail){
      recipient = newEmail;
    },
    report: function(data) {
        // assume data received will be formatted in this order.
        //{"name":"barak","date":"Jun 11th 2013","time":"3:12PM","report":"blahblahblahblahblahblahblahblahblah"}  
        var subjectLine = "Sexual Harrassment Report!"

        var reportObjectArray = [];
        for (var key in data) {
            reportObjectArray.push(data[key].toString());
        }

        var reportData = "Name: " + reportObjectArray[0] + "\n" + "Date of Incident: " + reportObjectArray[1] + "\n" + "Time of Incident: " + reportObjectArray[2] + "\n\n" + reportObjectArray[3];

        email(recipient, subjectLine, reportData);

        return "This is the Report page";
    },
    alert: function(data) {
        // assume data received will be formatted in the order of "testalert"

        var subjectLine = "Sexual Harrassment Alert!"

        var alertObjectArray = [];
        for (var key in data) {
            alertObjectArray.push(data[key]);
        }

        var alertData = alertObjectArray[0] + " is in trouble!" + "\n" + "Alert sent from this location: " + getGoogleMapLink(alertObjectArray[1]) + "\n" + "at " + alertObjectArray[3] + " on " + alertObjectArray[2] + "\n" + "If you can, try to reach out to " + alertObjectArray[0] + " or alert the authorities.";


        email(recipient, subjectLine, alertData);

        // because SMS is not set up, this formatted data currently has no where to go. 
        return alertData;
  },

// (Verification Step 2) function checks to see if email matches @pace.edu
    checkEmail: function(givenEmail){


        if (givenEmail.indexOf("@pace.edu")!=-1){
            code = generateCode(4);

            //create empty list variable and add email into it
            list.push({"email":givenEmail,"verificationcode":code});

            sendCode(list[counter]);

            counter = counter + 1;

        }
        else {
          console.log("wrong email");
          // how do you get the original function in server.js called again?
        }
    },

// (Verification Final Step) checks to see if email and code match in the list
    checkCode: function(givenEmail, givenCode){
        
        for (var index = 0;index<list.length;index++){

            console.log("Looking at list[index]: "+list[index].email);
            console.log("List: "+list.toString());

            if (list[index].email == givenEmail){

                if (list[index].verificationcode == givenCode){

                  console.log("Looking at list[index].email: "+list[index].email);

                  console.log("Your email is verified!");
                  return true;
                }
                else {
                  console.log("Incorrect verification code.");
                  return false;
                }
            }
      }
}
};

function getGoogleMapLink(location) {
      
        return "https://www.google.com/maps/place/" +"/@" +location[0].toString() +","+location[1].toString()+ ",18z/data=!4m2!3m1!1s0x0:0x0";

}

// (Verification) generates a randomized code of a certain length
function generateCode(len)
{
    var text = "";
    var charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for( var i=0; i < len; i++ ){
        text += charset.charAt(Math.floor(Math.random() * charset.length));
      }
     return text;
}

// (Verification) This function sends email with the verification code
function sendCode(list){

    postmark.send({
      "From": "bm09148n@pace.edu",
      "To": ''+list.email+'',
      "Subject": "Verification code for Sexual Harassment App!",
      "TextBody": "Type this into POSTMAN localhost:8080/verification/"+list.email+"/"+list.verificationcode,
      "Tag": "Important"
    }, function(error, success) {
      if (error) {
          console.error("Unable to send via postmark: " + error.message);
          return;
      }
      console.info("Sent to postmark for delivery")
    });
}

function email(recipient,emailTextSubject, emailTextBody) {
    postmark.send({
        "From": "bm09148n@pace.edu",
        "To": ''+recipient+'',
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