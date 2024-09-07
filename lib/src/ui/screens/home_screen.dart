import 'package:exchange_app/src/blocs/exchange/exchange_bloc.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_event.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_state.dart';
import 'package:exchange_app/src/repositories/exchange_repositories.dart';
import 'package:exchange_app/src/services/exchange_api_service.dart';
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
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.green,
                                Colors.yellow,
                                Colors.blue
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(rate.title.toString()),
                                  Text(" CB ${rate.price.toString()} so`m"),
                                ],
                              ),
                              Text("Sell ${rate.sell.toString()}"),
                              Text("Buy ${rate.buy.toString()}"),
                              Text("Buy ${rate.date.toString()}")
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
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
