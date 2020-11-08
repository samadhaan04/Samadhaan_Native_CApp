const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { firestore } = require('firebase-admin');

admin.initializeApp();

const db = admin.firestore();




exports.myFunction1 = functions.firestore
    .document(`Complaints/{complaint}`)
    .onUpdate(async (change, context) => {
       
        // var stateCode, newCityCode ,oldCityCode, stateRef,statedoc,cityRef,citydoc;
        // var stateCodeMap,cityCodeMap = {};
        var feed = change.after.data();
        var prevfeed = change.before.data();
        var newDepartment = feed.department;
        var newCity = feed.city;
        var oldCity = prevfeed.city;
        var state = feed.state;
        var prevDepartment = prevfeed.department;
        const token = feed.token;
        var owner = feed.name;
        var notify;

        // stateRef = db.collection('DepartmentNames').doc('StateCode');
        // statedoc = await stateRef.get();
        // if (statedoc.exists) {
        //     stateCodeMap = statedoc.data();
        //     console.log(stateCodeMap);
        // }
        // cityRef = db.collection('DepartmentNames').doc('CityCode');
        // citydoc = await cityRef.get();
        // if (citydoc.exists) {
        //     cityCodeMap = citydoc.data();
        //     console.log(cityCodeMap);
        // }



        // for(var pro in stateCodeMap)
        // {
        //     if(stateCodeMap[pro] === state)
        //     {
        //         stateCode = pro;
        //     }
        // }

        // for(var bro in cityCodeMap)
        // {
        //     if(cityCodeMap[bro] === newCity)
        //     {
        //         newCityCode = bro;
        //     }
        //     if(cityCodeMap[bro] === oldCity)
        //     {
        //         oldCityCode = bro;
        //     }
        // }
        

        // console.log(`stateCode = ${stateCode}, newCityCode = ${newCityCode}, oldCityCode = ${oldCityCode}`);


        if (feed.deptFeedback !== null && feed.deptFeedback !== prevfeed.deptFeedback) {
            notify = admin.messaging().sendToDevice(
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
            return admin.messaging().sendToDevice(
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
            notify = admin.messaging().sendToDevice(
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
            notify = admin.messaging().sendToDevice(
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
            notify = admin.messaging().sendToDevice(
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





        const topic = db.collection('DepartmentNames').doc('topic').get().then(snapshot => {
            const data = snapshot.data();
            var t = data.topic;

            var finalnewTopic = `${state}${newCity}${t[newDepartment]}`
            var finaloldTopic = `${state}${oldCity}${t[prevDepartment]}`
            var finalAdmin = `${state}${newCity}admin`;


            console.log(`topic ${finalnewTopic}`);
            if (feed.userFeedback !== null && feed.userFeedback !== prevfeed.userFeedback) {
                notify = admin.messaging().sendToTopic(
                    finalnewTopic,
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
                    finalAdmin,
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
                    finaloldTopic,
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
                    finaloldTopic,
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
                notify = admin.messaging().sendToTopic(
                    finalnewTopic,
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
    .onCreate(async (snap, context) => {
        console.log('starting');
        var feed = snap.data();
        var department = feed.department;
        var owner = feed.name;
        // var stateCode, cityCode , stateRef ,statedoc,cityRef,citydoc;
        var city = feed.city;
        var state = feed.state;
        // var stateCodeMap,cityCodeMap = {};
        var subject = feed.subject;
        var notify;
        // stateRef = db.collection('DepartmentNames').doc('StateCode');
        // statedoc = await stateRef.get();
        // if (statedoc.exists) {
        //     stateCodeMap = statedoc.data();
        //     console.log(stateCodeMap);
        // }
        // cityRef = db.collection('DepartmentNames').doc('CityCode');
        // citydoc = await cityRef.get();
        // if (citydoc.exists) {
        //     cityCodeMap = citydoc.data();
        //     console.log(cityCodeMap);
        // }



        // for(var pro in stateCodeMap)
        // {
        //     if(stateCodeMap[pro] === state)
        //     {
        //         stateCode = pro;
        //     }
        // }

        // for(var bro in cityCodeMap)
        // {
        //     if(cityCodeMap[bro] === city)
        //     {
        //         cityCode = bro;
        //     }
            
        // }
        

        // console.log(`stateCode = ${stateCode}, cityCode = ${cityCode}`);


        const topic = db.collection('DepartmentNames').doc('topic').get().then(snapshot => {
            const data = snapshot.data();
            var t = data.topic;

            var finalTopic = `${state}${city}${t[department]}`

            // var finalAdmin = `${state}${city}admin`;

            console.log(`topic ${finalTopic}`);

            notify = admin.messaging().sendToTopic(finalTopic,
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
