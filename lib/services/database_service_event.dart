import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/models/event.dart';

class DatabaseServiceEvent {
  String uid;

  DatabaseServiceEvent({this.uid});

  final CollectionReference eventsCollection =
      Firestore.instance.collection('events');

  Future updateDatabase(Event event) async {
    await eventsCollection.document(uid).setData({
      'name': event.name,
      'date': event.data,
      'latitude': event.latitude,
      'longitude': event.longitude,
      'time': event.time,
    });
  }

  List<Event> _eventsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Event(
        name: doc.data['name'],
        data: doc.data['date'],
        latitude: doc.data['latitude'],
        longitude: doc.data['longitude'],
      );
    }).toList();
  }

  Stream<List<Event>> get events {
    return eventsCollection
        .snapshots()
        .map((QuerySnapshot snapshot) => _eventsListFromSnapshot(snapshot));
  }
}