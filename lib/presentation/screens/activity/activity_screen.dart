import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:holiday_mobile/data/models/location/location.dart';
import 'package:holiday_mobile/logic/blocs/activity_bloc/activity_bloc.dart';
import 'package:holiday_mobile/logic/blocs/holiday_bloc/holiday_bloc.dart';
import 'package:holiday_mobile/presentation/widgets/common/custom_message.dart';
import 'package:holiday_mobile/presentation/widgets/common/icon_with_text.dart';
import 'package:holiday_mobile/presentation/widgets/common/progress_loading_widget.dart';
import 'package:holiday_mobile/routes/app_router.gr.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

@RoutePage()
class ActivityScreen extends StatefulWidget {
  final String activityId;
  final String holidayId;

  const ActivityScreen({super.key, @PathParam() required this.activityId, @PathParam() required this.holidayId,});

  @override
  State<ActivityScreen> createState() => _ActivityState();
}

class _ActivityState extends State<ActivityScreen> {
  final ActivityBloc _activityBloc = ActivityBloc();
  late Activity _activity;

  @override
  void initState() {
    _activityBloc.add(GetActivity(activityId: widget.activityId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Activité"),
        ),
      body: _buildActivity(),
    );
  }

  Widget _buildActivity(){
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _activityBloc,
        child: BlocListener<ActivityBloc, ActivityState>(
          listener: (context, state) {
            if (state.status == ActivityStateStatus.error) {
              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showMaterialBanner(CustomMessage(message: state.errorMessage!).build(context));
            }
            if (state.status == ActivityStateStatus.deleted) {
              context.router.pop(context);
            }
          },
          child: BlocBuilder<ActivityBloc, ActivityState>(
            builder: (context, state) {
              if (state.status == ActivityStateStatus.initial || state.status == ActivityStateStatus.loading) {
                return const LoadingProgressor();
              } else if (state.status == ActivityStateStatus.loaded) {
                _activity = state.activity! ;
                return _buildActivityInformation(context, _activity);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }


  Widget _buildActivityInformation(BuildContext context, Activity activity){
    return Center(
        child: IntrinsicHeight(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network('https://10.0.2.2:7048/${activity.activityPath}'),
                ),

                /**
                 * Container(
                    height: 200,
                    child: Image.asset(
                    "assets/images/bgHoliday.jpg",
                    fit: BoxFit.cover, // Ajuste l'image pour remplir la largeur sans déformation
                    ),
                    )
                 */

                Container(
                  margin: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 190.0,
                        child: FittedBox(
                          fit: BoxFit.scaleDown, //Ca permet d'adapater la taille du texte pour qu'il rentre dans la taille de la SizeBox
                          child: Text(
                            activity.name,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Color(0xFF1E3A8A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              showDeleteConfirmationDialog(context, activity);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                  // Marge pour le Text
                  child: Text(
                    activity.description,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      iconWithText(Icons.calendar_month, '30/03/2022'),
                      iconWithText(Icons.euro, '${activity.price}'),
                      iconWithText(Icons.location_on, activity.location.country),
                      iconWithText(Icons.people_sharp, 'XX'),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          context.router.push(EncodeParticipantActivityRoute(activityId: activity.id!));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A8A),
                        ),
                        icon: const Icon(Icons.group),
                        label: const Text("Participants"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          //TODO METTRE DANS UN BLOC ?
                          List<geocoding.Location> geocodedLocations = await Location.locationsFromAddress(activity.location.getFormattedAddress());
                          //TODO CHANGER ICI POUR METTRE l'ID DE LA HOLIDAY
                          context.router.push(MapRoute(destinationLatitude: geocodedLocations[0].latitude, destinationLongitude: geocodedLocations[0].longitude));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A8A),
                        ),
                        icon: const Icon(Icons.location_on),
                        label: const Text("S'y rendre"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, Activity activity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text(
              "Etes-vous sûr de vouloir supprimer cette activité ?"),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Fermer la popup
                  },
                  child: const Text("Annuler"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _activityBloc.add(DeleteActivity(activity: activity));
                    context.read<HolidayBloc>().add(GetHoliday(holidayId: widget.holidayId));
                  },
                  child: const Text("Supprimer"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}