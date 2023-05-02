import 'package:flutter/material.dart';
import 'package:ticketing_system/config/responsive.dart';
import 'package:ticketing_system/config/size_config.dart';
import 'package:ticketing_system/style/colors.dart';
import 'package:ticketing_system/widgets/appbar_action_items.dart';
import 'package:ticketing_system/widgets/create_ticket.dart';
import 'package:ticketing_system/widgets/header.dart';
import 'package:ticketing_system/widgets/ticket_list.dart';
import 'package:ticketing_system/widgets/sidemenu.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  final _drawerKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: const SizedBox(
        width: 100,
        child: SideMenu(),
      ),
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(flex: 1, child: SideMenu()),
          Expanded(
            flex: 10,
            child: SizedBox(
              width: double.infinity,
              height: SizeConfig.screenHeight,
              child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 30.0),
                  child: Column(
                    children: [
                      const Header(),
                      SizedBox(height: SizeConfig.blockSizeVertical! * 4),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 3,
                      ),
                      const TicketList(),
                    ],
                  )),
            ),
          ),
          if (Responsive.isDesktop(context))
            Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  height: SizeConfig.screenHeight,
                  color: AppColors.secondaryBg,
                  padding: const EdgeInsets.symmetric(
                    vertical: 30.0,
                    horizontal: 30.0,
                  ),
                  child: Column(children: [
                    const AppBarActionItems(),
                    CreateTicket(formKey: _formKey),
                  ]),
                ))
        ],
      )),
    );
  }
}
