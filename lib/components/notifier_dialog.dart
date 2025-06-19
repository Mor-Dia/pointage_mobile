import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

showNotifyingDialog(
    {required BuildContext context, String? message, bool isError = false}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Future.delayed(const Duration(seconds: 10), () {
      //   if (Navigator.canPop(context)) {
      //     Navigator.of(context).pop();
      //   }
      // });
      return Dialog(
        backgroundColor: Colors.white,
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                isError
                    ? 'assets/images/denied.svg'
                    : 'assets/images/validated.svg',
                height: 50,
              ),
              Expanded(
                child: Text(
                  message ?? "",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              )
            ],
          ),
        ),
      );
    },
  ).then((onValue) {});
}
