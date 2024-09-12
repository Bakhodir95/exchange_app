import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_bloc.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_event.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_state.dart';
import 'package:exchange_app/src/models/exchange.dart';
import 'package:exchange_app/src/repositories/exchange_repositories.dart';
import 'package:exchange_app/src/services/exchange_api_service.dart';
import 'package:exchange_app/src/ui/screens/settings_screen.dart';
import 'package:exchange_app/src/ui/widgets/home_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeRateScreen extends StatefulWidget {
  const ExchangeRateScreen({super.key});

  @override
  State<ExchangeRateScreen> createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends State<ExchangeRateScreen> {
  List<Exchange> exchanges = [];

  List<Exchange> _sortExchanges(List<Exchange> exchanges) {
    List<Exchange> filteredExchanges = exchanges.where((exchange) {
      return exchange.buy != null;
    }).toList();

    filteredExchanges.sort((a, b) => a.buy!.compareTo(b.buy!));

    return filteredExchanges;
  }

  void _onSortButtonPressed() {
    setState(() {
      exchanges = _sortExchanges(exchanges);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExchangeRateBloc(
        repository: ExchangeRateRepository(apiService: ExchangeApiService()),
      )..add(FetchExchangeRates()),
      child: Scaffold(
        drawer: const SettingsScreen(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreenAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: AppBar(
              actions: [
                IconButton(
                  onPressed: _onSortButtonPressed,
                  icon: const Icon(Icons.sort),
                ),
              ],
              title: Text(context.tr("exchange_rates")),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
          ),
        ),
        body: BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
          builder: (context, state) {
            if (state is ExchangeRateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ExchangeRateLoaded) {
              exchanges = state.exchangeRates;

              return CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 6),
                  enableInfiniteScroll: true,
                  scrollDirection: Axis.vertical,
                  viewportFraction: 0.3,
                ),
                items: exchanges.map((exchange) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context)
                            .size
                            .width, 
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: HomeWidget(
                              exchange:
                                  exchange), // Your widget to display exchange data
                        ),
                      );
                    },
                  );
                }).toList(),
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
