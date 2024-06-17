const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.listAllUsers = functions.region("asia-south1").https.onCall(async (data, context) => {
  if (!context.auth || !context.auth.token || !context.auth.token.admin) {
    throw new functions.https.HttpsError("permission-denied", "Must be an administrative user to list all users.");
  }

  const listAllUsers = (nextPageToken) => {
    return admin.auth().listUsers(1000, nextPageToken)
      .then((listUsersResult) => {
        const users = listUsersResult.users.map((userRecord) => userRecord.email);
        if (listUsersResult.pageToken) {
          return listAllUsers(listUsersResult.pageToken).then((nextUsers) => users.concat(nextUsers));
        }
        return users;
      });
  };

  return listAllUsers();
});
