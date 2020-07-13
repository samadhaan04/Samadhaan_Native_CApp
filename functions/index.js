const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();


exports.myFunction = functions.firestore
    .document('Complaints/{complaint}')
    .onUpdate((change, context) => {
        // var feed = snapshot.data().deptFeedback;
        var feed = change.after.data();
        const newValue = change.after.data();
        const token = newValue.token;
        console.log(token);
        if (feed.deptFeedback !== null) {
            return admin.messaging().sendToDevice(
                token,
                {
                    notification: {
                        title: "FeedBack Received From Department!",
                        body: feed.deptFeedback,
                        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                        icon: 'assets/images/samadhaan.png',
                        priority : "high",
                    },
                },
            );
        }



    });
