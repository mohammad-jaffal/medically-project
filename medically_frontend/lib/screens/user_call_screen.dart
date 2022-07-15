import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/doctors_provider.dart';
import 'package:agora_uikit/agora_uikit.dart';

class UserCallScreen extends StatefulWidget {
  const UserCallScreen({Key? key}) : super(key: key);
  static const routeName = '/user-call-screen';

  @override
  State<UserCallScreen> createState() => _UserCallScreenState();
}

class _UserCallScreenState extends State<UserCallScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final doctorId =
//         int.parse(ModalRoute.of(context)!.settings.arguments.toString());
//     final doctorsProvider = Provider.of<DoctorsProvider>(context);
//     var doctor = doctorsProvider.getDoctorByID(doctorId);
//     print(doctor.channelToken);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(doctorId.toString()),
//       ),
//       body: Center(
//         child: Text(doctor.channelName),
//       ),
//     );
//   }
// }

// {
  late AgoraClient _client;

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async {
    const appId = "cfdf49c6205745eba30ed0ebadc79407";
    var t = "";
    _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "cfdf49c6205745eba30ed0ebadc79407",
        channelName: "",
        tempToken: t,
      ),
    );
    await _client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("video"),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: _client,
                layoutType: Layout.grid,
                showNumberOfUsers: true,
              ),
              AgoraVideoButtons(
                client: _client,
                enabledButtons: const [
                  // BuiltInButtons.toggleCamera,
                  BuiltInButtons.callEnd,
                  BuiltInButtons.toggleMic,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
