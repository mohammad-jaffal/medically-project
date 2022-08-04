import 'package:flutter/material.dart';
import 'package:medically_frontend/providers/agora_provider.dart';
import 'package:medically_frontend/providers/calls_provider.dart';
import 'package:medically_frontend/providers/doctor_provider.dart';
import 'package:provider/provider.dart';
import 'package:agora_uikit/agora_uikit.dart';

class DoctorCallScreen extends StatefulWidget {
  const DoctorCallScreen({Key? key}) : super(key: key);
  static const routeName = '/doctor-call-screen';

  @override
  State<DoctorCallScreen> createState() => _DoctorCallScreenState();
}

class _DoctorCallScreenState extends State<DoctorCallScreen> {
  late AgoraClient _client;
  var token;
  var name;
  @override
  void initState() {
    // get channel data
    final agoraProvider = Provider.of<AgoraProvider>(context, listen: false);
    token = agoraProvider.getToken;
    name = agoraProvider.getTName;
    super.initState();
    _initAgora();
  }

  // this function initialises the agora client
  Future<void> _initAgora() async {
    const appId = "cfdf49c6205745eba30ed0ebadc79407";
    _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "cfdf49c6205745eba30ed0ebadc79407",
        channelName: name,
        tempToken: token,
      ),
      agoraEventHandlers: AgoraRtcEventHandlers(
        leaveChannel: (RtcStats stats) async {
          // set incall to false, stop the timer, and update the calls
          Provider.of<AgoraProvider>(context, listen: false).setInCall(false);
          Provider.of<CallsProvider>(context, listen: false)
              .endTime(DateTime.now(), context);
          await Provider.of<CallsProvider>(context, listen: false)
              .fetchDoctorCalls(
                  Provider.of<DoctorProvider>(context, listen: false)
                      .getDoctorId);
          Navigator.pop(context);
        },
        userOffline: (int uid, UserOfflineReason reason) {
          // stop the call timer
          Provider.of<CallsProvider>(context, listen: false)
              .endTime(DateTime.now(), context);
        },
        userJoined: (int x, int y) {
          // start the call timer
          Provider.of<CallsProvider>(context, listen: false)
              .setTime(DateTime.now());
        },
      ),
    );
    await _client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: _client,
                layoutType: Layout.floating,
                showNumberOfUsers: false,
                // showAVState: true,
                disabledVideoWidget: Container(
                  color: Color.fromARGB(255, 54, 135, 255),
                  child: Center(
                    child: Icon(
                      Icons.videocam_off,
                      color: Colors.white,
                      size: 90,
                    ),
                  ),
                ),
              ),
              AgoraVideoButtons(
                client: _client,
                enabledButtons: const [
                  BuiltInButtons.toggleCamera,
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
