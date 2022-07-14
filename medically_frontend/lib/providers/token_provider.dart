import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:medically_frontend/models/user.dart';
import 'package:medically_frontend/providers/user_provider.dart';
import 'package:medically_frontend/screens/bottom_bar.dart';
import 'package:medically_frontend/services/token_prefs.dart';
import 'package:provider/provider.dart';

import '../doctor_screens/doctor_bottom_bar.dart';
import '../models/doctor.dart';
import 'doctor_provider.dart';
import 'doctors_provider.dart';

class TokenProvider with ChangeNotifier {
  TokenPrefs tokenPrefs = TokenPrefs();
  var _token;

  void setToken(var token) {
    _token = token;
    tokenPrefs.setToken(token);
    // validateToken();
  }

  Future<String> validateToken(String token, BuildContext context) async {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    final doctorsProvider =
        Provider.of<DoctorsProvider>(context, listen: false);
    var url = Uri.parse('http://10.0.2.2:8000/api/profile');
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    var saved_body = json.decode(response.body);
    if (saved_body['message'] == 'Unauthenticated.') {
      tokenProvider.setToken('none');
      return 'none';
    } else {
      var saved_type = saved_body['type'];
      if (saved_type == 1) {
        var u = User(
          id: saved_body['id'],
          name: saved_body['name'],
          email: saved_body['email'],
          base64Image: saved_body['profile_picture'],
          balance: saved_body['balance'],
          type: saved_body['type'],
        );

        await doctorsProvider.fetchDoctors();
        userProvider.setuser(u);
        return 'user';

        // if doctor go to doctor screens
      } else if (saved_type == 2) {
        var detailsUrl = Uri.parse('http://10.0.2.2:8000/api/get-doctor');
        var detailsResponse = await http.post(detailsUrl, body: {
          'doctor_id': '${saved_body['id']}',
        });
        if (detailsResponse.statusCode == 200) {
          var details_response_body =
              json.decode(detailsResponse.body)['doctor'][0];

          var d = Doctor(
            id: details_response_body['doctor_id'],
            name: details_response_body['name'],
            email: details_response_body['email'],
            base64Image: details_response_body['profile_picture'],
            balance: details_response_body['balance'],
            type: details_response_body['type'],
            rating: double.parse(details_response_body['rating']),
            channelName: details_response_body['channel_name'],
            channelToken: details_response_body['channel_token'],
            bio: details_response_body['bio'],
            domainId: details_response_body['domain_id'],
            online: details_response_body['online'] == 1,
          );
          doctorProvider.setDoctor(d);
          return 'doctor';
        }
      } else {
        print('do nothing');
      }
    }

    return 'none';
  }

  String get getToken {
    return _token;
  }
}
