'use strict';

function sendEmail(event, context, callback) {
    callback(null, { message: 'I did a thing!' });
}

module.exports = {
  sendEmail
}