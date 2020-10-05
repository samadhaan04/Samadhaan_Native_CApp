const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { firestore } = require('firebase-admin');

admin.initializeApp();

const db = admin.firestore();


exports.myFunction1 = functions.firestore
    .document(`Complaints/{complaint}`)
    .onUpdate((change, context) => {
        console.log('update starting');
        var feed = change.after.data();
        var prevfeed = change.before.data();
        var newDepartment = feed.department;
        var prevDepartment = prevfeed.department;
        const token = feed.token;
        var owner = feed.name;
        var notify;
        if (feed.deptFeedback !== null && feed.deptFeedback !== prevfeed.deptFeedback) {
            notify =  admin.messaging().sendToDevice(
                token,
                {
                    notification: {
                        title: `FeedBack Received From ${newDepartment}!`,
                        body: feed.deptFeedback,
                        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                    },
                    data: {
                        "id": context.params.complaint,
                    }

                },
            );
        }
        if (feed.status === 1 && prevfeed.status !== 1) {
            console.log('Complaint marked Complete');
            return  admin.messaging().sendToDevice(
                token,
                {
                    notification: {
                        title: `Complaint Marked Complete by ${newDepartment}!`,
                        body: feed.subject,
                        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                    },
                    data: {
                        "id": context.params.complaint,
                    }

                },
            );
        }
        if (feed.transferRequest !== null && prevfeed.transferRequest !== feed.transferRequest) {
            notify =  admin.messaging().sendToDevice(
                token,
                {
                    notification: {
                        title: `${newDepartment} Requested Transfer of Complaint!`,
                        body: feed.subject,
                        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                    },
                    data: {
                        "id": context.params.complaint,
                    }
                },
            );
        }
        if ((prevfeed.department === feed.department) && (feed.transferRequest === null && prevfeed.transferRequest !== null)) {
            notify =  admin.messaging().sendToDevice(
                token,
                {
                    notification: {
                        title: "Transfer Request Dismissed By Admin!",
                        body: feed.subject,
                        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                    },
                    data: {
                        "id": context.params.complaint,
                    }

                },
            );
        }
        if ((prevfeed.department !== feed.department) && (feed.transferRequest === null && prevfeed.transferRequest !== null)) {
            notify =  admin.messaging().sendToDevice(
                token,
                {
                    notification: {
                        title: "Transfer Request Approved By Admin!",
                        body: feed.subject,
                        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                    },
                    data: {
                        "id": context.params.complaint,
                    }

                },
            );
        }

        //jkcnfjnejinrnvrnvjh
        const topic = db.collection('DepartmentNames').doc('topic').get().then(snapshot => {
            const data = snapshot.data();
            var t = data.topic;
            
            console.log(`topic ${t[newDepartment]}`);
            if (feed.userFeedback !== null && feed.userFeedback !== prevfeed.userFeedback) {
                notify = admin.messaging().sendToTopic(
                    t[newDepartment],
                    {
                        notification: {
                            title: "FeedBack Received From User!",
                            body: feed.userFeedback,
                            clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                        },
                        data: {
                            "id": context.params.complaint,
                        }
    
                    },
                );
            }
            if (feed.transferRequest !== null && prevfeed.transferRequest !== feed.transferRequest) {
                notify = admin.messaging().sendToTopic(
                    'admin',
                    {
                        notification: {
                            title: `Transfer Request Recieved by ${newDepartment}!`,
                            body: feed.transferRequest,
                            clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                        },
                        data: {
                            "id": context.params.complaint,
                        }
    
                    },
                );
            }
            if ((prevfeed.department === feed.department) && (feed.transferRequest === null && prevfeed.transferRequest !== null)) {
                notify = admin.messaging().sendToTopic(
                    t[prevDepartment],
                    {
                        notification: {
                            title: "Transfer Request Dismissed By Admin!",
                            body: feed.userFeedback,
                            clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                        },
                        data: {
                            "id": context.params.complaint,
                        }
    
                    },
                );
            }
            if ((prevfeed.department !== feed.department) && (feed.transferRequest === null && prevfeed.transferRequest !== null)) {
                notify = admin.messaging().sendToTopic(
                    t[prevDepartment],
                    {
                        notification: {
                            title: "Transfer Request Approved By Admin!",
                            body: feed.userFeedback,
                            clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                        },
                        data: {
                            "id": context.params.complaint,
                        }
    
                    },
                );
                notify =admin.messaging().sendToTopic(
                    t[newDepartment],
                    {
                        notification: {
                            title: `New Complaint By ${owner}`,
                            body: `${subject}`,
                            clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                        },
                        data: {
                            "id": context.params.complaint,
                        }
    
                    },
                );
            }
            return t;
        });
        return notify;
    });

exports.myFunction2 = functions.firestore
    .document('Complaints/{complaint}')
    .onCreate((snap, context) => {
        console.log('starting');
        var feed = snap.data();
        var department = feed.department;
        var owner = feed.name;
        var subject = feed.subject;
        var notify;
        const topic = db.collection('DepartmentNames').doc('topic').get().then(snapshot => {
            const data = snapshot.data();
            var t = data.topic;
            console.log(`topic ${t[department]}`);
            notify = admin.messaging().sendToTopic(t[department],
                {
                    notification: {
                        title: `New Complaint By ${owner}`,
                        body: `${subject}`,
                        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
                    },
                    data: {
                        "id": context.params.complaint,
                    }
                },
            );
            return t;
        });
         
        return notify;
    });
