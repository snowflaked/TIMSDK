import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_info_result.dart';
import 'package:discuss/common/avatar.dart';
import 'package:discuss/common/colors.dart';

class FriendProfilePanel extends StatelessWidget {
  const FriendProfilePanel(this.userInfo, this.isSelf, {Key? key})
      : super(key: key);
  final V2TimFriendInfoResult? userInfo;
  final bool isSelf;
  getSelfSignature() {
    if (userInfo!.friendInfo!.userProfile!.selfSignature == '' ||
        userInfo!.friendInfo!.userProfile!.selfSignature == null) {
      return "";
    } else {
      return userInfo!.friendInfo!.userProfile!.selfSignature;
    }
  }

  hasNickName() {
    return !(userInfo!.friendInfo!.userProfile!.nickName == '' ||
        userInfo!.friendInfo!.userProfile!.nickName == null);
  }

  @override
  Widget build(BuildContext context) {
    if (userInfo == null) {
      return Container(
        height: 112,
      );
    }

    return Container(
      height: 112,
      padding: const EdgeInsets.all(16),
      color: CommonColors.getWitheColor(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Avatar(
              avtarUrl: userInfo!.friendInfo!.userProfile!.faceUrl == null ||
                      userInfo!.friendInfo!.userProfile!.faceUrl == ''
                  ? 'images/logo.png'
                  : userInfo!.friendInfo!.userProfile!.faceUrl,
              width: 80,
              height: 80,
              radius: 9.6,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 昵称
                  SizedBox(
                    height: 30,
                    child: Text(
                      (userInfo!.friendInfo!.userProfile!.nickName == null ||
                              userInfo!.friendInfo!.userProfile!.nickName == '')
                          ? "${userInfo!.friendInfo!.userProfile!.userID}"
                          : "${userInfo!.friendInfo!.userProfile!.nickName}",
                      style: TextStyle(
                        fontSize: 20,
                        color: CommonColors.getTextBasicColor(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 23,
                    child: Text(
                      '用户ID：${userInfo!.friendInfo!.userProfile!.userID}',
                      style: TextStyle(
                        fontSize: 14,
                        color: CommonColors.getTextWeakColor(),
                      ),
                    ),
                  ),
                  !isSelf
                      ? SizedBox(
                          height: 23,
                          child: Text(
                            '个性签名：${getSelfSignature()}',
                            style: TextStyle(
                              fontSize: 14,
                              color: CommonColors.getTextWeakColor(),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
