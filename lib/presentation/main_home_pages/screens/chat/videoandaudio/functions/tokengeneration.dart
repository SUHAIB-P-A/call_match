import 'package:agora_token_service/agora_token_service.dart';
import 'package:call_match/core/agoraconfig.dart';



String generateToken(String channelName, String uid) {
  const role =
      RtcRole.publisher; // Use RtcRole.publisher instead of string "publisher"
  final expiry =
      DateTime.now().add(Duration(minutes: 30)).millisecondsSinceEpoch ~/
          1000; // Token expires in 30 minutes

  return RtcTokenBuilder.build(appId: appId, appCertificate: appCertificate, channelName: channelName, uid: uid, role: role, expireTimestamp: expiry);
}
