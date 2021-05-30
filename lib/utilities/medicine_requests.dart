import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_interface/constants.dart';

class MedicineRequest {
  final String medicineID;
  final RequestStatus status;
  final String quantity;
  final String? location;

  MedicineRequest({
    required this.medicineID,
    this.status = RequestStatus.unknown,
    required this.quantity,
    this.location,
});

  Text getStatusAsText() {
    if(status == RequestStatus.completed) {
      return Text(
        'Completed',
        style: TextStyle(
          color: Colors.green,
          fontSize: 19.0,
        )
      );
    }else if(status == RequestStatus.pending) {
      return Text(
          'Pending',
          style: TextStyle(
            color: Colors.red,
            fontSize: 19.0,
          )
      );
    }else if(status == RequestStatus.timedOut) {
      return Text(
          'Timed Out',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 19.0,
          )
      );
    }
    else {
      return Text('');
    }
  }
}