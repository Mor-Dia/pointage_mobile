import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pointage_mobile/components/ButtonField.dart';
import 'package:pointage_mobile/components/TopDialogNotification.dart';
import 'package:pointage_mobile/components/type_paiement_card.dart';
import 'package:pointage_mobile/constant.dart';
import 'package:pointage_mobile/core/utils/Capitalized.dart';
import 'package:pointage_mobile/core/utils/helpers.dart';
import 'package:pointage_mobile/services/api/models/programme_model.dart';
import 'package:pointage_mobile/services/api/models/type_notificationpush_model.dart';

import '../core/models/user_model.dart';
import '../services/api/models/type_paiement_model.dart';
import '../services/authentication_bloc/authentication_bloc.dart';
import '../services/data_bloc/bloc/data_bloc.dart';
import '../services/data_bloc/presentation/bloc_based_widget.dart';
import '../services/post_api_bloc.dart';
import 'animated_gesture_detector.dart';

class CardTypeNotificationPush extends StatefulWidget {
  final TypeNotificationPush tnp;
  final Function? onTNPChecked;
  const CardTypeNotificationPush(
      {super.key, required this.tnp, this.onTNPChecked});

  @override
  State<CardTypeNotificationPush> createState() =>
      _CardTypeNotificationPushState();
}

class _CardTypeNotificationPushState extends State<CardTypeNotificationPush> {
  late TypeNotificationPush? tnp;
  bool isAllowed = true;

  @override
  void initState() {
    tnp = widget.tnp;
    if (tnp != null) {
      isAllowed = tnp?.isAllowed ?? false;
    }
    super.initState();
  }

  onCheckboxChanged(value, elementId) {
    setState(() {
      isAllowed = !isAllowed;
    });
    if (widget.onTNPChecked != null) {
      widget.onTNPChecked!(elementId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        isThreeLine: true,
        contentPadding: const EdgeInsets.all(8.0),
        title: Text(
          "${tnp?.designation ?? ''}",
          softWrap: true,
          maxLines: 2,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 12,
            fontWeight: FontWeight.w900,
          ),
        ),
        subtitle: Text(
          "${tnp?.description ?? ''}",
          maxLines: 3,
          style: const TextStyle(
            color: Colors.grey,
            overflow: TextOverflow.ellipsis,
            fontSize: 10,
            fontStyle: FontStyle.italic,
          ),
        ),
        trailing: Checkbox(
            value: isAllowed,
            onChanged: (value) {
              onCheckboxChanged(value, tnp?.id);
            }));
  }
}
