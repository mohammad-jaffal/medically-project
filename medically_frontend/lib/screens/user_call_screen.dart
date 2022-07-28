import 'package:agora_uikit/controllers/rtm_channel_event_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:medically_frontend/providers/agora_provider.dart';
import 'package:provider/provider.dart';

import '../providers/calls_provider.dart';
import '../providers/doctors_provider.dart';
import 'package:agora_uikit/agora_uikit.dart';

import '../providers/user_provider.dart';

class UserCallScreen extends StatefulWidget {
  const UserCallScreen({Key? key}) : super(key: key);
  static const routeName = '/user-call-screen';

  @override
  State<UserCallScreen> createState() => _UserCallScreenState();
}

class _UserCallScreenState extends State<UserCallScreen> {
  late AgoraClient _client;
  var token;
  var name;
  @override
  void initState() {
    // get doctors channel info from agora provider
    final agoraProvider = Provider.of<AgoraProvider>(context, listen: false);
    token = agoraProvider.getToken;
    name = agoraProvider.getTName;
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async {
    // initialising agora client
    const appId = "cfdf49c6205745eba30ed0ebadc79407";
    _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "cfdf49c6205745eba30ed0ebadc79407",
        channelName: name,
        tempToken: token,
      ),
      agoraEventHandlers: AgoraRtcEventHandlers(
        leaveChannel: (RtcStats stats) async {
          // close the call screen and update calls
          await Provider.of<CallsProvider>(context, listen: false)
              .fetchUserCalls(
                  Provider.of<UserProvider>(context, listen: false).getUserId);

          Provider.of<UserProvider>(context, listen: false).updateBalance();
          Navigator.pop(context);
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print('someone left');
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
