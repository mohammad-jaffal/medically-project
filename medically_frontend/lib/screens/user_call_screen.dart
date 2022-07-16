import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:medically_frontend/providers/agora_provider.dart';
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
  late AgoraClient _client;
  var token;
  var name;
  @override
  void initState() {
    final agoraProvider = Provider.of<AgoraProvider>(context, listen: false);
    token = agoraProvider.getToken;
    name = agoraProvider.getTName;
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async {
    const appId = "cfdf49c6205745eba30ed0ebadc79407";
    _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "cfdf49c6205745eba30ed0ebadc79407",
        channelName: name,
        tempToken: token,
      ),
      agoraEventHandlers: AgoraRtcEventHandlers(
        leaveChannel: (RtcStats stats) {
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
        appBar: AppBar(
          title: Text("video"),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: _client,
                layoutType: Layout.floating,
                showNumberOfUsers: true,
                // showAVState: true,
                disabledVideoWidget: Container(
                  color: Colors.lightBlue,
                  child: const Center(
                    child: Text('Camera off'),
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
