import 'package:equatable/equatable.dart';

abstract class ExchangeRateEvent extends Equatable {
  const ExchangeRateEvent();

  @override
  List<Object> get props => [];
}

class FetchExchangeRates extends ExchangeRateEvent {}

class ShareApp extends ExchangeRateEvent {
  String urlAddress;

  ShareApp({required this.urlAddress});
}

class CallNumber extends ExchangeRateEvent {
  String callNumber;

  CallNumber({required this.callNumber});
}

class LaunchTelegram extends ExchangeRateEvent {}

class AboutUsViewed extends ExchangeRateEvent {}
