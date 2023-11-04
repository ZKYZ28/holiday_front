import 'package:flutter/material.dart';

class ParticipantCard extends StatefulWidget {
  final double nameColumnWidth;
  final double emailColumnWidth;
  final double buttonColumnWidth;
  final double tableParticipantsHeight;
  final String title;
  final IconData? icon;

  const ParticipantCard({
    super.key,
    required this.nameColumnWidth,
    required this.emailColumnWidth,
    required this.buttonColumnWidth,
    required this.tableParticipantsHeight,
    required this.title,
    this.icon,
  });

  @override
  State<ParticipantCard> createState() => _ParticipantCardState();
}

class _ParticipantCardState extends State<ParticipantCard> {
  List<Map<String, String>> participants = [];

  void _addParticipant(String name, String email) {
    setState(() {
      participants.add({'name': name, 'email': email});
    });
  }

  void _removeParticipant(int index) {
    setState(() {
      participants.removeAt(index);
    });
  }

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
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF1E3A8A)),
                  ),
                  if (widget.icon != null)
                    Container(
                      alignment: Alignment.center,
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // cerle en fond
                        color: Color(0xFF1E3A8A),
                      ),
                      child: IconButton(
                        onPressed: () => _addParticipant(
                            "Edwinaaaaaaaa", "e.devlegelaer@student.hemo.be"),
                        icon: Icon(
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
                        child: Text('Nom'),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: widget.emailColumnWidth,
                        // 50% de la largeur de l'écran
                        child: Text('Email'),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: widget.buttonColumnWidth,
                        // 20% de la largeur de l'écran
                        child: Text(''),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    participants.length,
                    (index) => DataRow(cells: [
                      DataCell(
                        SizedBox(
                          width: widget.nameColumnWidth,
                          child: Text(
                            participants[index]['name'] ?? '',
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: widget.emailColumnWidth,
                          child: Text(
                            participants[index]['email'] ?? '',
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: widget.buttonColumnWidth,
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () => _removeParticipant(index),
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
