import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'task.dart';

//collection reference
//transaction handler

final CollectionReference myCollection = Firestore.instance.collection('todolist');

class FirestoreService {
  // after all details have been entered and submit button is clicked
  Future<Task> createTODOtask(String taskName, String taskDetails, String taskDate, String taskTime, String taskType) async{
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(myCollection.document());

      final Task task = Task(taskName, taskDetails, taskDate, taskTime, taskType);
      final Map<String, dynamic> data = task.toMap();
      await tx.set(ds.reference, data);
      return data;
    };

    // run transaction
    return Firestore.instance.runTransaction(createTransaction).then((mapData){
      return Task.fromMap(mapData);
    }).catchError((onError) {
      print('error:$onError');
      return null;
    });
  }

  //retrieve the data
  Stream<QuerySnapshot> getTaskList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = myCollection.snapshots();  //reference of collection
    if(offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if(limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }
}