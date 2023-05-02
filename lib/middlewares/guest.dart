import 'package:flutter/material.dart';
import 'package:ticketing_system/utils/token_util.dart';

class GuestMiddleware extends StatelessWidget {
  final Widget child;
  const GuestMiddleware({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: TokenUtil().getToken(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          // Token is available, render the child widget
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/');
          });

          return Container();
        } else {
          // Token is not available, push replacement route outside of the build method
          // Return a placeholder widget while the redirect happens
          return child;
        }
      },
    );
  }
}
