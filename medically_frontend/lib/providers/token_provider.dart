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
    // check if token is legit
    var url = Uri.parse('http://10.0.2.2:8000/api/profile');
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    var savedBody = json.decode(response.body);
    // if the token is no loger active
    if (savedBody['message'] == 'Unauthenticated.') {
      tokenProvider.setToken('none');
      return 'none';
    } else {
      // fill the related provider with user depending on user type
      // and send the type to login in scren to navigate to the correct screen
      var savedType = savedBody['type'];
      if (savedType == 1) {
        var u = User(
          id: savedBody['id'],
          name: savedBody['name'],
          email: savedBody['email'],
          base64Image: savedBody['profile_picture'],
          balance: savedBody['balance'],
          type: savedBody['type'],
        );

        await doctorsProvider.fetchDoctors();
        userProvider.setuser(u);
        return 'user';
      } else if (savedType == 2) {
        // fetch the doctor details if the type is doctor
        var detailsUrl = Uri.parse('http://10.0.2.2:8000/api/get-doctor');
        var detailsResponse = await http.post(detailsUrl, body: {
          'doctor_id': '${savedBody['id']}',
        });
        if (detailsResponse.statusCode == 200) {
          var detailsBody = json.decode(detailsResponse.body)['doctor'][0];

          var d = Doctor(
            id: detailsBody['doctor_id'],
            name: detailsBody['name'],
            email: detailsBody['email'],
            base64Image: detailsBody['profile_picture'],
            balance: detailsBody['balance'],
            type: detailsBody['type'],
            rating: double.parse(detailsBody['rating']),
            channelName: detailsBody['channel_name'],
            channelToken: detailsBody['channel_token'],
            bio: detailsBody['bio'],
            domainId: detailsBody['domain_id'],
            online: detailsBody['online'] == 1,
          );
          doctorProvider.setDoctor(d);
          return 'doctor';
        }
      }
    }
    return 'none';
  }

  String get getToken {
    return _token;
  }
}
