import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/routes/app_router.gr.dart';

class ParticipantCard extends StatefulWidget {
  final double nameColumnWidth;
  final double emailColumnWidth;
  final double buttonColumnWidth;
  final double tableParticipantsHeight;
  final String title;
  final IconData? icon;
  final List<Participant> participants;
  final String holidayId;

  const ParticipantCard({
    super.key,
    required this.nameColumnWidth,
    required this.emailColumnWidth,
    required this.buttonColumnWidth,
    required this.tableParticipantsHeight,
    required this.title,
    this.icon,
    required this.participants,
    required this.holidayId
  });

  @override
  State<ParticipantCard> createState() => _ParticipantCardState();
}

class _ParticipantCardState extends State<ParticipantCard> {


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: widget.tableParticipantsHeight),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            // Header
            // TODO : propre
            if (widget.title != '' && widget.icon != null)
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF1E3A8A)),
                  ),
                  if (widget.icon != null)
                    Container(
                      alignment: Alignment.center,
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, // cerle en fond
                        color: Color(0xFF1E3A8A),
                      ),
                      child: IconButton(
                        onPressed: () => { context.router.push(EncodeParticipant(holidayId: widget.holidayId))},
                        icon: const Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Tableau des participants
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columnSpacing: 10,
                  columns: [
                    DataColumn(
                      label: SizedBox(
                        width: widget.nameColumnWidth,
                        // 20% de la largeur de l'écran
                        child: const Text('Nom'),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: widget.emailColumnWidth,
                        // 50% de la largeur de l'écran
                        child: const Text('Email'),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    widget.participants.length,
                    (index) => DataRow(cells: [
                      DataCell(
                        SizedBox(
                          width: widget.nameColumnWidth,
                          child: Text(
                            "${widget.participants[index].firstName}  ${widget.participants[index].lastName}"  ?? '',
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: widget.emailColumnWidth,
                          child: Text(
                            widget.participants[index].email ?? '',
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
