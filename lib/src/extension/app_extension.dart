import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_club/src/enums/snack_type_enum.dart';

extension NavigatorContext on BuildContext {
  back() {
    Navigator.pop(this);
  }

  dissmissLoading() {
    Navigator.pop(this);
  }

  pushScreen({required Widget nextScreen}) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => nextScreen));
  }

  pushReplacementScreen({required Widget nextScreen}) {
    Navigator.pushReplacement(
        this, MaterialPageRoute(builder: (context) => nextScreen));
  }

  showSnackBar(
      {required String title,
      required String message,
      required SnackTypeEnum snackTypeEnum}) {
    AnimatedSnackBar(
      builder: ((context) {
        return MaterialAnimatedSnackBar(
          titleText: '${title}',
          messageText: '${message}',
          type: snackTypeEnum == SnackTypeEnum.error
              ? AnimatedSnackBarType.error
              : snackTypeEnum == SnackTypeEnum.warning
                  ? AnimatedSnackBarType.warning
                  : AnimatedSnackBarType.success,
        );
      }),
    ).show(this);
  }
}
