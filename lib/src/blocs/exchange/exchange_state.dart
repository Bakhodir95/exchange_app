import 'package:equatable/equatable.dart';
import 'package:exchange_app/src/models/exchange.dart';

abstract class ExchangeRateState extends Equatable {
  const ExchangeRateState();

  @override
  List<Object> get props => [];
}

class ExchangeRateLoading extends ExchangeRateState {}

class ExchangeRateLoaded extends ExchangeRateState {
  final List<Exchange> exchangeRates;

  const ExchangeRateLoaded({required this.exchangeRates});

  @override
  List<Object> get props => [exchangeRates];
}

class ExchangeRateError extends ExchangeRateState {
  final String message;

  const ExchangeRateError({required this.message});

  @override
  List<Object> get props => [message];
}
