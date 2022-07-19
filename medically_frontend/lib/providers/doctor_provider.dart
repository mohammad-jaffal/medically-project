import 'package:flutter/cupertino.dart';
import 'package:medically_frontend/models/doctor.dart';

class DoctorProvider with ChangeNotifier {
  var _doctor;
  void setDoctor(Doctor doctor) {
    _doctor = doctor;
  }

  Doctor get getDoctor {
    return _doctor;
  }

  void setOnline(bool status) {
    _doctor.online = status;
    notifyListeners();
  }

  int get getDoctorId {
    return _doctor.id;
  }

  void updateBalance(var balance) {
    _doctor.balance = int.parse(_doctor.balance) + balance;
  }
}
