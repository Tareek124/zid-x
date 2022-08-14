// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<void> callOnFcmApiSendPushNotifications({
  required String title,
  required String imageUrl,
  required String phoneNumber,
  required String uid,
  required String name,
  required String description,
  required String price,
}) async {
  const postUrl = 'https://fcm.googleapis.com/fcm/send';
  final data = {
    "to":
        "dBK5FIMDROKdWxA7B2VleO:APA91bG0tdgDYYUqpUjTtKgtOaezac88rI_vn9ZG6gwCjR9U2hSM-DhoKkab1lrn-pSAr32xHiKb8uaDZ-UUeN6G_ZhioB0LM-gu4BrXOPV0sh6A8DZelL0EUua8i04gznNtoBxFrXNs",
    "notification": {
      "title": title,
      "body": description,
      "image": imageUrl,
    },
    "data": {
      "type": '0rder',
      "id": "28",
      "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      'title': title,
      'uid': uid,
      'name': name,
      'imageurl': imageUrl,
      'description': description,
      'price': price,
      'phonenumber': phoneNumber,
    },
  };

  final headers = {
    'content-type': 'application/json',
    'Authorization':
        'key=AAAA1YzIPKs:APA91bGgN_e69oEHeAsN81eJ89NejEPPJ7hDWUND2gGaOTalFpIlqqvIMWhwss0AxQoIghvNM8tqdYgli-mQZl6IdWKgifwK5W8MwBvhyks1wE733tThreqHCrd239pgOJCGhrFKOv60' // 'key=YOUR_SERVER_KEY'
  };

  final response = await http.post(Uri.parse(postUrl),
      body: json.encode(data),
      encoding: Encoding.getByName('utf-8'),
      headers: headers);

  if (response.statusCode == 200) {
    print('Push Notification Succeded');
  } else {
    print('Push Notification Error');
  }
}
