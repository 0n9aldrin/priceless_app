import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:priceless/auth/toast.dart';
import 'package:priceless/stocks/models/storage/storage.dart';

import 'main.dart';

final dbRef = FirebaseDatabase.instance.reference();
final uid = UID;

bookmarkStock({@required StorageModel model}) async {
  try {
    var stocks = dbRef.child("savedStocks");
    stocks.child(uid).child(model.symbol).set(model.companyName);
    // var snaps = await stocks.child(uid)s.once();
    // print(snaps.value.toString());
    //   DataSnapshot snap = await stocks.child(uid).once();
    //   if (snap.value == null) {
    //     stocks.child(uid).set({model.symbol: model.companyName});
    //     // print("snap is null");
    //     // showSuccessToast('Saved', context);
    //   } else {
    //     // stocks.child(uid).push().set(model.toJson());
    //     stocks.child(uid).set({model.symbol: model.companyName});

    //     // stocks.child(uid).update(model.toJson());
    //     // showSuccessToast('Updated', context);
    //     // print("Done");
    //   }
  } catch (e) {
    // print(e.toString());
  }
}

deleteStock({@required String symbol}) async {
  try {
    var stocks = dbRef.child("savedStocks").child(uid);
    stocks.child(symbol).remove();
    // print(snap.key);
  } catch (e) {
    print(e.toString());
  }
}

Future<List<StorageModel>> fetchStock() async {
  try {
    Map<dynamic, dynamic> stocks;
    List<StorageModel> models = [];
    await dbRef.child("savedStocks").child(uid).once().then((snap) {
      print(snap.value.toString());
      stocks = snap.value;
    });
    stocks.forEach((key, value) {
      print("KEY:$key");
      models.add(StorageModel.fromJson(
          {'symbol': key.toString(), 'companyName': value.toString()}));
    });
    models.forEach((element) {
      print("MODEL VALUE: ${element.companyName}");
    });
    return models;
    // print(models.toString());

    // print(snap.key);
  } catch (e) {
    print(e.toString());
  }
}
