import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medically_frontend/doctor_screens/update_bio_screen.dart';
import 'package:medically_frontend/providers/token_provider.dart';
import 'package:medically_frontend/screens/login_screen.dart';
import 'package:native_notify/native_notify.dart';
import 'package:provider/provider.dart';
import '../consts/constants.dart';
import '../providers/calls_provider.dart';
import '../providers/dark_theme_provider.dart';
import '../providers/doctor_provider.dart';
import 'package:http/http.dart' as http;
import '../providers/reviews_provider.dart';

class DoctorInfoScreen extends StatefulWidget {
  const DoctorInfoScreen({Key? key}) : super(key: key);

  @override
  State<DoctorInfoScreen> createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  String apiConst = Constants.api_const;
  final myController = TextEditingController();
  Future pickImage(ImageSource source) async {
    print('camera');
    final image = await ImagePicker().pickImage(
      source: source,
      maxHeight: 200,
      maxWidth: 200,
    );
    if (image == null) return;
    List<int> imageBytes = await image.readAsBytes() as List<int>;
    String base64Image = base64Encode(imageBytes);
    // log(base64Image);
    Provider.of<DoctorProvider>(context, listen: false)
        .updateImage(base64Image);
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    final doctorProvider = Provider.of<DoctorProvider>(context);
    // get the doctor object
    var doctor = doctorProvider.getDoctor;
    var bytesImage = const Base64Decoder().convert(doctor.base64Image);

    final tokenProvider = Provider.of<TokenProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name.toString()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // doctor profile picture card
              Card(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.memory(
                                bytesImage,
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 2,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: FloatingActionButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Select option',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 54, 135, 255),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              // camera
                                              InkWell(
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.camera,
                                                        color: themeState
                                                                .getDarkTheme
                                                            ? Colors.white
                                                            : const Color
                                                                    .fromARGB(
                                                                255,
                                                                54,
                                                                135,
                                                                255),
                                                      ),
                                                    ),
                                                    const Text(
                                                      'Camera',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pickImage(ImageSource.camera);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              // gallery
                                              InkWell(
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.image,
                                                        color: themeState
                                                                .getDarkTheme
                                                            ? Colors.white
                                                            : const Color
                                                                    .fromARGB(
                                                                255,
                                                                54,
                                                                135,
                                                                255),
                                                      ),
                                                    ),
                                                    const Text(
                                                      'Gallery',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pickImage(
                                                      ImageSource.gallery);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              // remove image
                                              InkWell(
                                                child: Row(
                                                  children: const [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.remove_circle,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Remove',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.red),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  Provider.of<DoctorProvider>(
                                                          context,
                                                          listen: false)
                                                      .deleteImage();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.add_a_photo_rounded,
                                  color: themeState.getDarkTheme
                                      ? Colors.white
                                      : Colors.grey[600],
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 5),
              // online status card
              Card(
                child: SwitchListTile(
                  title: Text(doctor.online ? "Online" : "Offline"),
                  secondary: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                    child: Icon(doctor.online
                        ? Icons.person_outline_outlined
                        : Icons.person_off_outlined),
                  ),
                  onChanged: (bool value) async {
                    var url = Uri.parse('$apiConst/user/set-doctor-status');
                    var response = await http.post(url, body: {
                      'doctor_id': '${doctor.id}',
                      'status': value ? '1' : '0',
                    });
                    if (json.decode(response.body)['success']) {
                      doctorProvider.setOnline(value);
                    }
                  },
                  value: doctor.online,
                ),
              ),

              const SizedBox(height: 5),
              // email item card
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        size: 35,
                        color: themeState.getDarkTheme
                            ? Colors.white
                            : Colors.grey[600],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          doctor.email,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // bio card
              Card(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.text_snippet,
                          size: 35,
                          color: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: Text(
                              doctor.bio,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, UpdateBioScreen.routeName);
                  },
                ),
              ),
              const SizedBox(height: 5),
              // rating item card
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_border,
                        size: 35,
                        color: themeState.getDarkTheme
                            ? Colors.white
                            : Colors.grey[600],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          doctor.rating.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // ballance item card
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.monetization_on_outlined,
                        size: 35,
                        color: themeState.getDarkTheme
                            ? Colors.white
                            : Colors.grey[600],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          doctor.balance.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // theme item card
              Card(
                child: SwitchListTile(
                  title: Text(
                    themeState.getDarkTheme ? "Dark mode" : "Light mode",
                    style: const TextStyle(fontSize: 20),
                  ),
                  secondary: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                    child: Icon(themeState.getDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined),
                  ),
                  onChanged: (bool value) {
                    themeState.setDarkTheme = value;
                  },
                  value: themeState.getDarkTheme,
                ),
              ),
              const SizedBox(height: 5),
              // logout item card
              Card(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 35,
                          color: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            'Log out',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    // show "are u sure ?" dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          title: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 6.0),
                                child: Icon(Icons.exit_to_app),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Sure ?'),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'NO',
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // destroy token, clear data, clear notification subject id
                                tokenProvider.setToken('none');
                                Provider.of<CallsProvider>(context,
                                        listen: false)
                                    .clearCalls();
                                Provider.of<ReviewsProvider>(context,
                                        listen: false)
                                    .clearReviews();
                                NativeNotify.registerIndieID('-');
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    LoginScreen.routeName,
                                    (Route<dynamic> route) => false);
                              },
                              child: const Text(
                                'YES',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
