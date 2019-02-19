import 'package:flutter_rx_bloc/blocPattern/blocBase.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class IncrementBloc implements BlocBase {
  int _counter;

  // Stream to handle the counter

  StreamController<int> _counterController = BehaviorSubject<int>();
  StreamSink<int> get _inAdd => _counterController.sink;
  ValueObservable<int> get outCounter => _counterController.stream;

  // Stream to handle the incrementaction on the counter
  StreamController _actionIncrementController = BehaviorSubject();
  StreamSink get incrementCounter => _actionIncrementController;

  // Stream to handle the resetaction on the counter
  StreamController _actionResetController = BehaviorSubject();
  StreamSink get resetCounter => _actionResetController;

  IncrementBloc() {
    _counter = 0;
    _actionIncrementController.stream.listen(_handleLogic);
    _actionResetController.stream.listen(_logicReset);
  }

  void _handleLogic(data) {
    _counter = _counter + 1;
    _inAdd.add(_counter);
  }

  void _logicReset(data) {
    _counter = 0;
    _inAdd.add(_counter);
  }

  void dispose() {
    _actionIncrementController.close();
    _counterController.close();
    _actionResetController.close();
  }
}
