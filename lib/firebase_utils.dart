import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/app_user.dart';
import 'package:evently/model/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection(String userId) {
    return getUserCollection()
        .doc(userId)
        .collection(Event.collectionName)
        .withConverter<Event>(
            fromFirestore: (snapshot, options) =>
                Event.fromFireStore(snapshot.data()),
            toFirestore: (event, _) => event.toFirestore());
  }

  static CollectionReference<AppUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(AppUser.collectionName)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                AppUser.fromFirestore(snapshot.data()),
            toFirestore: (appUser, _) => appUser.toFirestore());
  }

  static Future<void> addEventToFirestore(Event event, String userId) {
    // Add event data to Firestore
    var collection = getEventCollection(userId);
    var docRef = collection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }

  static Future<AppUser?> readUserFromFirestore(String id) async {
    var querySnapshot = await getUserCollection().doc(id).get();
    return querySnapshot.data();
  }

  static addUserToFirestore(AppUser appUser) {
    return getUserCollection().doc(appUser.id).set(appUser);
  }
}
