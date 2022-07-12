import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medically_frontend/models/doctor.dart';
import 'package:http/http.dart' as http;

class DoctorsProvider with ChangeNotifier {
  var _doctors;

  final List _domains = [
    {
      "id": 1,
      "domain_name": "domain 1",
    },
    {
      "id": 2,
      "domain_name": "domain 2",
    },
    {
      "id": 3,
      "domain_name": "domain 3",
    },
    {
      "id": 4,
      "domain_name": "domain 4",
    }
  ];

  Future<void> fetchDoctors() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/get-doctors');
    var response = await http.get(url);
    // print(json.decode(response.body)['doctors']);
    _doctors = json
        .decode(response.body)['doctors']
        .map((e) => Doctor.fromJson(e))
        .toList();
    notifyListeners();
  }

  List getDoctors(var searchText, var domainId) {
    var _doctorsList = [];
    if (_doctors != null) {
      if (domainId == 0) {
        for (var i = 0; i < _doctors.length; i++) {
          if (_doctors[i].name.contains(searchText)) {
            _doctorsList.add(_doctors[i]);
          }
        }
      } else {
        for (var i = 0; i < _doctors.length; i++) {
          if (_doctors[i].name.contains(searchText) &&
              _doctors[i].domainId == domainId) {
            _doctorsList.add(_doctors[i]);
          }
        }
      }
    } else {
      return [];
    }

    return [..._doctorsList];
  }

  List get getDomains {
    return [..._domains];
  }

  List getFavorites(var searchText) {
    final _favoritesIDs = [5, 6];
    var _favorites = [];

    for (var i = 0; i < _doctors.length; i++) {
      if (_doctors[i].name.contains(searchText) &&
          _favoritesIDs.contains(_doctors[i].id)) {
        _favorites.add(_doctors[i]);
      }
    }

    return [..._favorites];
  }

  Doctor getDoctorByID(var docID) {
    var _doc;
    for (var i = 0; i < _doctors.length; i++) {
      if (_doctors[i].id == docID) {
        _doc = _doctors[i];
      }
    }
    return _doc;
  }
}
