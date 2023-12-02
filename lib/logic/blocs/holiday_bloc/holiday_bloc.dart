import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/data/providers/data/HolidayData.dart';
import 'package:holiday_mobile/data/providers/data/LocationData.dart';
import 'package:holiday_mobile/data/repositories/authentification_api_repository.dart';
import 'package:holiday_mobile/data/repositories/holiday_api_repository.dart';
import 'package:holiday_mobile/main.dart';
import 'package:timezone/timezone.dart';

part 'holiday_event.dart';
part 'holiday_state.dart';

class HolidayBloc extends Bloc<HolidayEvent, HolidayState> {
  final HolidayApiRepository holidayRepository = HolidayApiRepository();
  late AuthRepository _repository;

  HolidayBloc({ required AuthRepository repository}) : super(const HolidayState()) {
    _repository = repository;

    on<GetHolidayByParticipant>((GetHolidayByParticipant event, Emitter<HolidayState> emit) async {
      try {
        emit(state.copyWith(status: HolidayStateStatus.loading));

        // // TODO : tester si ça survient à nouveau (impossible de reproduire le bug)
        // final participantId = _repository.userConnected?.id ?? 'UNKNOW';
        // if (participantId == 'UNKNOW') {
        //   emit(state.copyWith(status: HolidayStateStatus.error, errorMessage : "Utilisateur non authentifié. Merci de vous reconnecter ! "));
        //   return;
        // }
        final holidaysByParticipant = await holidayRepository.fetchHolidayByParticipant(false);
        emit(state.copyWith(status: HolidayStateStatus.loaded, holidaysList: holidaysByParticipant));
      } on ApiException catch (e) {
        emit(state.copyWith(status: HolidayStateStatus.error, errorMessage : e.toString()));
      }
    });

    on<GetHolidayPublished>((GetHolidayPublished event, Emitter<HolidayState> emit) async {
      try {
        emit(state.copyWith(status: HolidayStateStatus.loading));

        final holidaysPublished = await holidayRepository.fetchHolidayPublished(true);

        emit(state.copyWith(status: HolidayStateStatus.loaded, holidaysList: holidaysPublished));
      } on ApiException catch (e) {
        emit(state.copyWith(status: HolidayStateStatus.error, errorMessage : e.toString()));
      }
    });

    on<GetHoliday>((GetHoliday event, Emitter<HolidayState> emit) async {
      try {
        emit(state.copyWith(status: HolidayStateStatus.loading));

        final holidayId = event.holidayId;
        final holiday = await holidayRepository.fetchHoliday(holidayId);

        emit(state.copyWith(status: HolidayStateStatus.loaded, holidayItem: holiday));
      } on ApiException catch (e) {
        emit(state.copyWith(status: HolidayStateStatus.error, errorMessage : e.toString()));
      }
    });

    on<PublishHoliday>((PublishHoliday event, Emitter<HolidayState> emit) async {
      try {
        final holiday = event.holiday;
        final location = event.holiday.location;
        print(holiday.endDate);
        print(holiday.startDate);

        await holidayRepository.updateHoliday(
            HolidayData(
              name:  holiday.name,
              description:  holiday.description ?? '',
              startDate: TZDateTime.parse(globalLocation!, holiday.startDate),
              endDate: TZDateTime.parse(globalLocation!, holiday.endDate),
              locationData: LocationData(
                locationId: location.id,
                country:  location.country,
                locality: location.locality,
                street:  location.street ?? '',
                postalCode: location.postalCode,
                numberBox:  location.number ?? '',
              ),
              file: null,
              isPublish: true,
              creatorId: repository.userConnected!.id,
              deleteImage: false,
              initialPath: holiday.holidayPath,
              holidayId: holiday.id,
            )
        );

        final holidayPublish = state.holidayItem;
        holidayPublish?.isPublish = true;

        emit(state.copyWith(status: HolidayStateStatus.published, holidayItem: holidayPublish));
      } on ApiException catch (e) {
        emit(state.copyWith(status: HolidayStateStatus.error, errorMessage : e.toString()));
      }
    });

    on<GetAllParticipantNotYetInHoliday>((GetAllParticipantNotYetInHoliday event, Emitter<HolidayState> emit) async {
      try {
        emit(state.copyWith(status: HolidayStateStatus.loading));

        final String holidayId = event.holidayId;
        final participants = await holidayRepository.getAllParticipantNotYetInHoliday(holidayId, false);

        emit(state.copyWith(status: HolidayStateStatus.loaded, participantsList: participants));
      } on ApiException catch (e) {
        emit(state.copyWith(status: HolidayStateStatus.error, errorMessage: e.toString()));
      }
    });

    on<DeleteHoliday>((DeleteHoliday event, Emitter<HolidayState> emit) async {
      try {
        final holidayId = event.holidayId;
        await holidayRepository.deleteHoliday(holidayId);

      } on ApiException catch (e) {
        emit(state.copyWith(status: HolidayStateStatus.error, errorMessage : e.toString()));
      }
    });

    on<ExportHolidayToIcs>((ExportHolidayToIcs event, Emitter<HolidayState> emit) async {
      try {
        final holidayId = event.holidayId;
        await holidayRepository.exportHolidayToIcs(holidayId);

      } on ApiException catch (e) {
        emit(state.copyWith(status: HolidayStateStatus.error, errorMessage : e.toString()));
      }
    });

    on<WaitingActivityAction>((WaitingActivityAction event, Emitter<HolidayState> emit)  {
      emit(state.copyWith(status: HolidayStateStatus.waitingActivityAction));
    });

    on<ResetHolidayStatus>((ResetHolidayStatus event, Emitter<HolidayState> emit) async {
      emit(state.copyWith(status: HolidayStateStatus.loading));
    });

    on<LeaveHoliday>((LeaveHoliday event, Emitter<HolidayState> emit) async {
      try {
        final holidayId = event.holidayId;
        await holidayRepository.leaveHoliday(holidayId);

        emit(state.copyWith(status: HolidayStateStatus.left));

      } on ApiException catch (e) {
        emit(state.copyWith(status: HolidayStateStatus.error, errorMessage : e.toString()));
      }
    });

  }
}