import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

///生成腾讯云即时通信测试用userSig
///
class GenerateTestUserSig {
  GenerateTestUserSig({required this.sdkappid, required this.key});
  int sdkappid;
  String key;

  ///生成UserSig
  String genSig({
    required String identifier,
    required int expire,
    List<int>? userBuf,
  }) {
    int currTime = _getCurrentTime();
    String sig = '';
    // ignore: prefer_collection_literals
    Map<String, dynamic> sigDoc = Map<String, dynamic>();
    sigDoc.addAll({
      "TLS.ver": "2.0",
      "TLS.identifier": identifier,
      "TLS.sdkappid": sdkappid,
      "TLS.expire": expire,
      "TLS.time": currTime,
    });

    sig = _hmacsha256(
      identifier: identifier,
      currTime: currTime,
      expire: expire,
    );
    sigDoc['TLS.sig'] = sig;
    String jsonStr = json.encode(sigDoc);
    List<int> compress = zlib.encode(utf8.encode(jsonStr));
    return _escape(content: base64.encode(compress));
  }

  int _getCurrentTime() {
    return (DateTime.now().millisecondsSinceEpoch / 1000).floor();
  }

  String _hmacsha256({
    required String identifier,
    required int currTime,
    required int expire,
  }) {
    int sdkappid = this.sdkappid;
    String contentToBeSigned =
        "TLS.identifier:$identifier\nTLS.sdkappid:$sdkappid\nTLS.time:$currTime\nTLS.expire:$expire\n";
    Hmac hmacSha256 = Hmac(sha256, utf8.encode(key));
    Digest hmacSha256Digest =
        hmacSha256.convert(utf8.encode(contentToBeSigned));
    return base64.encode(hmacSha256Digest.bytes);
  }

  String _escape({
    required String content,
  }) {
    return content
        // ignore: unnecessary_string_escapes
        .replaceAll('\+', '*')
        // ignore: unnecessary_string_escapes
        .replaceAll('\/', '-')
        .replaceAll('=', '_');
  }
}
