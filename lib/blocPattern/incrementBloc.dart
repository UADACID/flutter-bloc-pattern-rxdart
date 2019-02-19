import 'package:flutter_rx_bloc/blocPattern/blocBase.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class IncrementBloc implements BlocBase {
  int _counter;

  // Stream to handle the counter

  StreamController<int> _counterController = BehaviorSubject<int>();
  StreamSink<int> get _inAdd => _counterController.sink;
  ValueObservable<int> get outCounter => _counterController.stream;

  // Stream to handle the action on the counter
  StreamController _actionController = BehaviorSubject();
  StreamSink get incrementCounter => _actionController;

  IncrementBloc() {
    _counter = 0;
    _actionController.stream.listen(_handleLogic);
  }

  void _handleLogic(data) {
    _counter = _counter + 1;
    _inAdd.add(_counter);
  }

  void dispose() {
    _actionController.close();
    _counterController.close();
  }
}
