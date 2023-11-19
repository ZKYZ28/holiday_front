part of 'holiday_bloc.dart';

abstract class HolidayEvent extends Equatable{
    const HolidayEvent();

    @override
    List<Object> get props => [];
}

class GetHolidayPublished extends HolidayEvent {}

class GetHolidayByParticipant extends HolidayEvent {
    const GetHolidayByParticipant();

    @override
    List<Object> get props => [];
}

class GetHoliday extends HolidayEvent {
    final String holidayId;

    const GetHoliday({required this.holidayId});

    @override
    List<Object> get props => [holidayId];
}

class PublishHoliday extends HolidayEvent {
    final Holiday holiday;

    const PublishHoliday({required this.holiday});

    @override
    List<Object> get props => [holiday];
}

class DeleteHoliday extends HolidayEvent {
    final Holiday holiday;

    const DeleteHoliday({required this.holiday});

    @override
    List<Object> get props => [holiday];
}

class WaitingActivityAction extends HolidayEvent {

}