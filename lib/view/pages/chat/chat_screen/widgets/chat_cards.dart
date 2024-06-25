

import 'package:buzz_buddy/model/all_messages_model.dart';
import 'package:buzz_buddy/view/pages/chat/chat_screen/widgets/own_message_card.dart';
import 'package:buzz_buddy/view/pages/chat/chat_screen/widgets/replay_card.dart';
import 'package:buzz_buddy/view/pages/home/screen_home.dart';
import 'package:flutter/material.dart';

Widget getMessageCard(AllMessagesModel message) {
  if (message.senderId == logginedUserId) {
    return OwnMessageCard(
      message: message.text.trim(),
      time: message.createdAt,
    );
  } else {
    return ReplayCard(
      message: message.text.trim(),
      time: message.updatedAt,
    );
  }
}