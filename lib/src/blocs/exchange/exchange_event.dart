import 'package:equatable/equatable.dart';

abstract class ExchangeRateEvent extends Equatable {
  const ExchangeRateEvent();

  @override
  List<Object> get props => [];
}

class FetchExchangeRates extends ExchangeRateEvent {}

// ignore: must_be_immutable
class ShareApp extends ExchangeRateEvent {
  String urlAddress;

  ShareApp({required this.urlAddress});
}

// ignore: must_be_immutable
class CallNumber extends ExchangeRateEvent {
  String callNumber;

  CallNumber({required this.callNumber});
}

// ignore: must_be_immutable
class LaunchTelegram extends ExchangeRateEvent {
  String telegramLink;
  LaunchTelegram({required this.telegramLink});
}

class AboutUsViewed extends ExchangeRateEvent {}

class ErrorLoaded extends ExchangeRateEvent {}
