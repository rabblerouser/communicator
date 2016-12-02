var aws = require('aws-sdk');

console.log("File loaded");

function handler(event, context, callback) {
    console.log("event: ", event);
    console.log("context: ", context);
    callback(null, {message: "I did a thing!"});
}

function sendEmail(event, context, callback) {
    callback(null, { message: 'I did a thing!' });
}

module.exports = {
  handler,
  sendEmail
}