/*  EMAIL SETUP
    Postmark is the service used for emails. 
*/

var postmark = require("postmark")('f8536579-7284-4950-9e3d-977cc96332d0')

module.exports = {
    email: function(recipient, emailTextSubject, emailTextBody) {
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
            console.info("Sent to postmark for delivery!")
        });
    },
    verificationEmail: function(list) {
        postmark.send({
            "From": "bm09148n@pace.edu",
            "To": ''+list.email+'',
            "Subject": "Verification code for Sexual Harassment App!",
            "TextBody": "[FOR TESTING] Type this into POSTMAN localhost:8080/verification/"+list.email+"/"+list.verificationcode,
            "Tag": "Important"
        }, function(error, success) {
             if (error) {
                console.error("Unable to send via postmark: " + error.message);
                return;
             }
            console.info("Sent to postmark for delivery!")
        });
    }
}