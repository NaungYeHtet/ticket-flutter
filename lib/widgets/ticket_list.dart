import 'package:flutter/material.dart';
import 'package:ticketing_system/config/responsive.dart';
import 'package:ticketing_system/config/size_config.dart';
import 'package:ticketing_system/style/colors.dart';
import 'package:ticketing_system/style/style.dart';
import 'package:ticketing_system/utils/api_utils.dart';

class TicketList extends StatefulWidget {
  const TicketList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TicketListState createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {
  List<dynamic> _ticketData = [];

  @override
  void initState() {
    super.initState();
    _fetchTickets();
  }

  Future<void> _fetchTickets() async {
    final data = await ApiUtils.fetchData(context, 'api/v1/tickets');
    setState(() {
      _ticketData = data as List<dynamic>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection:
          Responsive.isDesktop(context) ? Axis.vertical : Axis.horizontal,
      child: SizedBox(
        width: Responsive.isDesktop(context)
            ? double.infinity
            : SizeConfig.screenWidth,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: _ticketData
              .map((ticket) => TableRow(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    children: [
                      PrimaryText(
                        text: ticket['title'] as String,
                        size: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondary,
                      ),
                      PrimaryText(
                        text: ticket['description'] as String,
                        size: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondary,
                      ),
                      PrimaryText(
                        text: ticket['status'] as String,
                        size: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondary,
                      ),
                      IconButton.outlined(
                        onPressed: () => {},
                        icon: const Icon(
                          Icons.mark_chat_read_outlined,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
