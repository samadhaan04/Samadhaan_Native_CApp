const functions = require('firebase-functions');
const admin = require('firebase-admin');


exports.myFunction = functions.firestore
  .document('Complaints/{complaint}')
  .onCreate((snapshot, context) => { 
      console.log(snapshot.data());
   });
