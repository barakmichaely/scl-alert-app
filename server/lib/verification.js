/*  VERIFICATION SETUP
     Upon using the app for the first time, the user must use their pace email as their login credential.
     The email must be verified before further use of the application to ensure safe use.
*/
var email = require('./email'),
    code,
    counter = 0,
    list = [];

module.exports = {    
    checkEmail: function(givenEmail){
        if (givenEmail.indexOf("@pace.edu")!=-1){
            code = generateCode(4);
            list.push({"email":givenEmail,"verificationcode":code});
            email.verificationEmail(list[counter]);
            counter = counter + 1;
        }
        else {
          console.log("Incorrect email. Try again.");
        }
    },
    checkCode: function(givenEmail, givenCode){
        for (var index = 0;index<list.length;index++){
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
  }

function generateCode(len) {
    var text = "";
    var charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for( var i=0; i < len; i++ ){
        text += charset.charAt(Math.floor(Math.random() * charset.length));
    }
    return text;
}
