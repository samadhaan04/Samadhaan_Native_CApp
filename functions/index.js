const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

var complaint;
exports.myFunction = functions.firestore
    .document(`Complaints/{complaint}`)
    .onUpdate((change, context) => {
        // var feed = snapshot.data().deptFeedback;
        console.log(context.params.complaint)
        var feed = change.after.data();
        var prevfeed = change.before.data();
        const token = feed.token;
        // console.log(token);
        if (feed.deptFeedback !== null && feed.deptFeedback!==prevfeed.deptFeedback) {
            return admin.messaging().sendToDevice(
                token,
                {
                    notification: {
                        title: "FeedBack Received From Department!",
                        body: feed.deptFeedback,
                        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                    },
                    data : {
                        "id" : context.params.complaint,
                    }
                    
                },
            );
        }



    });
