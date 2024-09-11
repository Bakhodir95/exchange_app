import 'package:bloc/bloc.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_event.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_state.dart';
import 'package:exchange_app/src/repositories/exchange_repositories.dart';
import 'package:url_launcher/url_launcher.dart';

class ExchangeRateBloc extends Bloc<ExchangeRateEvent, ExchangeRateState> {
  final ExchangeRateRepository repository;

  ExchangeRateBloc({required this.repository}) : super(ExchangeRateLoading()) {
    on<FetchExchangeRates>(_onFetchExchangeRates);
    on<ShareApp>(_launchURL);
    on<CallNumber>(_callPhoneNumber);
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

  Future<void> _launchURL(
      ShareApp event, Emitter<ExchangeRateState> emit) async {
    final Uri uri = Uri.parse(event.urlAddress);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${event.urlAddress}';
    }
  }

  Future<void> _callPhoneNumber(
      CallNumber event, Emitter<ExchangeRateState> emit) async {
    final Uri url = Uri(
      scheme: 'tel',
      path: event.callNumber,
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
