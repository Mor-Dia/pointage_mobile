import 'package:flutter/material.dart';
import 'package:yogivida_mobile/services/api/models/notificationpush_model.dart';

import '../constant.dart';

class NotificationContainer extends StatefulWidget {
  final NotificationPush notificationPush;

  const NotificationContainer({super.key, required this.notificationPush});

  @override
  State<NotificationContainer> createState() => _NotificationContainerState();
}

class _NotificationContainerState extends State<NotificationContainer> {

  late NotificationPush notificationPush;
 @override
  void initState() {
    notificationPush = widget.notificationPush;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: greyColorL))
        ),
        child: Padding(
          padding: const EdgeInsets.all(spacingConstant),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${notificationPush.title}",
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 3,
                style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "${notificationPush.description}",
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              )
            ],
          ),
        ),
      );
  }
}
