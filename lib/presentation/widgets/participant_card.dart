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
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF1E3A8A)),
                ),
              ),
              if (widget.icon != null)
                IconButton(
                    icon: Icon(
                      widget.icon,
                      size: 35,
                      color: Color(0xFF1E3A8A),
                    ),
                    onPressed: () => _addParticipant(
                        "Edwinaaaaaaaa", "e.devlegelaer@student.hemo.be")),
            ],
          ),
          Container(
            constraints: BoxConstraints(
                // Limiter la hauteur du container pour limiter la tailel des participants
                maxHeight: widget.tableParticipantsHeight),
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
          )
        ],
      ),
    );
  }
}
