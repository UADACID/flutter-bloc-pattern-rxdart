import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/blocPattern/blocProvider.dart';
import 'package:flutter_rx_bloc/blocPattern/counterPage.dart';
import 'package:flutter_rx_bloc/blocPattern/incrementBloc.dart';
// import 'package:flutter_rx_bloc/cummonStream/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<IncrementBloc>(
      bloc: IncrementBloc(),
      child: MaterialApp(
        title: 'Demo',
        home: CounterPage(),
      ),
    );
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   home: BlocProvider<IncrementBloc>(
    //     bloc: IncrementBloc(),
    //     child: CounterPage(),
    //   ),
    // );
  }
}
