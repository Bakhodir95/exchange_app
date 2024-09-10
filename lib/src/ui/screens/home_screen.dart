import 'package:exchange_app/src/blocs/exchange/exchange_bloc.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_event.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_state.dart';
import 'package:exchange_app/src/repositories/exchange_repositories.dart';
import 'package:exchange_app/src/services/exchange_api_service.dart';
import 'package:exchange_app/src/ui/screens/settings_screen.dart';
import 'package:exchange_app/src/ui/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeRateScreen extends StatelessWidget {
  const ExchangeRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExchangeRateBloc(
          repository: ExchangeRateRepository(apiService: ExchangeApiService()))
        ..add(FetchExchangeRates()),
      child: Scaffold(
        drawer: const SettingsScreen(),
        appBar: AppBar(
          title: const Text("Exchange Rates"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
          builder: (context, state) {
            if (state is ExchangeRateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ExchangeRateLoaded) {
              return ListView.builder(
                itemCount: state.exchangeRates.length,
                itemBuilder: (context, index) {
                  final rate = state.exchangeRates[index];
                  return HomeWidget(exchange: rate);
                },
              );
            } else if (state is ExchangeRateError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
