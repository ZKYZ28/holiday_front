part of 'holiday_bloc.dart';

abstract class HolidayEvent extends Equatable{
    const HolidayEvent();

    @override
    List<Object> get props => [];
}

class GetHolidayPublished extends HolidayEvent {}

class GetHolidayByParticipant extends HolidayEvent {
    final String participantId;

    const GetHolidayByParticipant({required this.participantId});

    @override
    List<Object> get props => [participantId];
}