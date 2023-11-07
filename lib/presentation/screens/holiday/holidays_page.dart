import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/logic/blocs/holiday_bloc/holiday_bloc.dart';
import 'package:holiday_mobile/presentation/widgets/common/error_message.dart';
import 'package:holiday_mobile/presentation/widgets/holiday/holiday_card.dart';
import 'package:auto_route/annotations.dart';

import '../../../data/models/holiday/holiday.dart';
import '../../../routes/app_router.gr.dart';
import '../../widgets/common/progress_loading_widget.dart';

@RoutePage()
class HolidaysPage extends StatefulWidget {
  const HolidaysPage({Key? key}) : super(key: key);

  //Création de l'état
  @override
  _HolidaysPageState createState() => _HolidaysPageState();
}

class _HolidaysPageState extends State<HolidaysPage> {
  //Création du bloc
  final HolidayBloc _holidayBloc = HolidayBloc();

  @override
  void initState() {
    _holidayBloc.add(const GetHolidayByParticipant(participantId: 'c59e12dd-3dbd-47ed-945a-ae8a8bf6dadb'));
    super.initState();
  }

  // Switch du toggle
  bool isToggled = false;

  void toggleSwitch(bool value) {
    setState(() {
      isToggled = value;

      // Appeler la méthode du bloc en fonction de la valeur de isToggled
      if (isToggled) {
        _holidayBloc.add(GetHolidayPublished());
      } else {
        _holidayBloc.add(const GetHolidayByParticipant(participantId: 'c59e12dd-3dbd-47ed-945a-ae8a8bf6dadb'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isToggled
            ? 'Vacances publiées par les utilisateurs'
            : 'Mes vacances'),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Encoder'),
            onPressed: () {
              context.router.push(const EncodeHoliday());
            },
          ),
        ],
      ),

      body: _buildListHoliday(),
    );
  }

  Widget _buildListHoliday() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _holidayBloc,
        child: BlocListener<HolidayBloc, HolidayState>(
          listener: (context, state) {
            if (state is HolidayError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<HolidayBloc, HolidayState>(
            builder: (context, state) {
              if (state is HolidayInitial) {
                return const LoadingProgressor();
              } else if (state is HolidayLoading) {
                return const LoadingProgressor();
              } else if (state is HolidayLoaded) {
                return _buildHolidayCard(context, state.holidays);
              } else if (state is HolidayError) {
                return ErrorMessage(message: state.message);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHolidayCard(BuildContext context, List<Holiday> holidays) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Switch(
              value: isToggled,
              onChanged: toggleSwitch,
              activeColor: const Color(0xFF1E3A8A),
            ),
            const Text('Vacances publiées par les utilisateurs'),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: holidays.length,
            itemBuilder: (context, index) {
              final holiday = holidays[index];
              final name = holiday.name;
              final description = holiday.description;
              final pathUrl = holiday.holidayPath;

              return HolidayCard(
                name: name,
                description: description,
                pathUrl : pathUrl
              );
            },
          ),
        ),
      ],
    );
  }
}
