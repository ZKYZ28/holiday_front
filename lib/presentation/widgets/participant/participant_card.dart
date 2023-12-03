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
  final List<Participant>? participants;
  final List<Participant>? participantInActivity;
  final String elementId;
  final void Function(Participant)? onDeleteParticipant;
  final bool isPublish;

  const ParticipantCard({
    super.key,
    required this.nameColumnWidth,
    required this.emailColumnWidth,
    required this.buttonColumnWidth,
    required this.tableParticipantsHeight,
    required this.title,
    this.icon,
    this.participants,
    this.participantInActivity,
    required this.elementId,
    this.onDeleteParticipant,
    required this.isPublish
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
                  if (widget.icon != null && widget.participants != null &&  widget.isPublish == false)
                    Container(
                      alignment: Alignment.center,
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, // cerle en fond
                        color: Color(0xFF1E3A8A),
                      ),
                      child: IconButton(
                        onPressed: () => { context.router.push(EncodeParticipantHolidayRoute(holidayId: widget.elementId))},
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
                        child: const Text('Nom'),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: widget.emailColumnWidth,
                        child: const Text('Email'),
                      ),
                    ),
                    if (widget.participantInActivity != null)
                      const DataColumn(
                        label: SizedBox(
                          child: Text(''),
                        ),
                      ),
                  ],
                  rows: widget.participants != null
                      ? buildParticipantsList(widget.participants!)
                      : buildParticipatesList(widget.participantInActivity!),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> buildParticipantsList(List<Participant> participants) {
    return List<DataRow>.generate(
      widget.participants!.length,
          (index) => DataRow(cells: [
        DataCell(
          SizedBox(
            width: widget.nameColumnWidth,
            child: Text(
              "${widget.participants?[index].firstName}  ${widget.participants?[index].lastName}"  ?? '',
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: widget.emailColumnWidth,
            child: Text(
              widget.participants?[index].email ?? '',
            ),
          ),
        ),
      ]),
    );
  }

  List<DataRow> buildParticipatesList(List<Participant> participantInActivity) {
    return List<DataRow>.generate(
      widget.participantInActivity!.length,
          (index) => DataRow(cells: [
        DataCell(
          SizedBox(
            width: widget.nameColumnWidth,
            child: Text(
              "${widget.participantInActivity?[index].firstName}  ${widget.participantInActivity?[index].lastName}"  ?? '',
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: widget.emailColumnWidth,
            child: Text(
              widget.participantInActivity?[index].email ?? '',
            ),
          ),
        ),
        DataCell(
          SizedBox(
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                widget.onDeleteParticipant?.call(widget.participantInActivity![index]);
              },
            ),
          ),
        ),
      ]),
    );
  }

}


