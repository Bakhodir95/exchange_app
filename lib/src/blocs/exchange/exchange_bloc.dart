import 'package:bloc/bloc.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_event.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_state.dart';
import 'package:exchange_app/src/repositories/exchange_repositories.dart';

class ExchangeRateBloc extends Bloc<ExchangeRateEvent, ExchangeRateState> {
  final ExchangeRateRepository repository;

  ExchangeRateBloc({required this.repository}) : super(ExchangeRateLoading()) {
    on<FetchExchangeRates>(_onFetchExchangeRates);
  }

  Future<void> _onFetchExchangeRates(
      FetchExchangeRates event, Emitter<ExchangeRateState> emit) async {
    emit(ExchangeRateLoading());
    try {
      final exchangeRates = await repository.fetchExchangeRates();
      emit(ExchangeRateLoaded(exchangeRates: exchangeRates));
    } catch (e) {
      emit(ExchangeRateError(message: e.toString()));
    }
  }
}
