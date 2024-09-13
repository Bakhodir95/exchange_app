import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_bloc.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_event.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_state.dart';
import 'package:exchange_app/src/extentions/mediaquery.dart';
import 'package:exchange_app/src/models/exchange.dart';
import 'package:exchange_app/src/repositories/exchange_repositories.dart';
import 'package:exchange_app/src/services/exchange_api_service.dart';
import 'package:exchange_app/src/services/searchviewdelegate.dart';
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

  void _onSearchButtonPressed() async {
    showSearch(
      context: context,
      delegate: ExchangeSearchDelegate(exchanges),
    );
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
                  onPressed: _onSearchButtonPressed,
                  icon: const Icon(Icons.search),
                ),
              ],
              title: Text(
                context.tr("exchange_rates"),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
            builder: (context, state) {
              if (state is ExchangeRateLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ExchangeRateLoaded) {
                exchanges = state.exchangeRates;
                List<Exchange> filteredExchanges = exchanges.where((exchange) {
                  return exchange.sell != null;
                }).toList();

                filteredExchanges.sort((a, b) => a.sell!.compareTo(b.sell!));

                return CarouselSlider.builder(
                  options: CarouselOptions(
                    height: context.screenHeight,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 6),
                    enableInfiniteScroll: true,
                    scrollDirection: Axis.vertical,
                    viewportFraction: 0.33,
                    enlargeCenterPage: true,
                  ),
                  itemCount: filteredExchanges.length,
                  itemBuilder: (context, index, realIndex) {
                    return Center(
                      child: Container(
                        width: context.screenWidth,
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
                          padding: const EdgeInsets.all(10),
                          child: HomeWidget(exchange: filteredExchanges[index]),
                        ),
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
      ),
    );
  }
}
