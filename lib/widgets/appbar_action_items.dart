import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketing_system/utils/api_utils.dart';
import 'package:ticketing_system/utils/token_util.dart';

class AppBarActionItems extends StatelessWidget {
  const AppBarActionItems({
    super.key,
  });

  logout(BuildContext context) async {
    final response =
        await ApiUtils.submitData(context, 'api/v1/auth/logout', {});

    if (response.statusCode == 200) {
      TokenUtil().deleteToken();

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/calendar.svg',
              width: 20.0,
            )),
        const SizedBox(
          width: 10.0,
        ),
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/ring.svg',
              width: 20.0,
            )),
        const SizedBox(
          width: 15.0,
        ),
        IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout_outlined)),
      ],
    );
  }
}
