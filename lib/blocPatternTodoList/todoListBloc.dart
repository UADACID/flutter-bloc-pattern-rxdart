import 'package:flutter_rx_bloc/blocPatternTodoList/blocBase.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class TodoListBloc implements BlocBase {
  List<String> _list = <String>[];

  // Stream to handle the counter

  StreamController<List<String>> _listController =
      BehaviorSubject<List<String>>();
  StreamSink<List<String>> get _inAdd => _listController.sink;
  ValueObservable<List<String>> get outList => _listController.stream;

  // Stream yang di gunakan untuk event submit
  StreamController _actionSubmitController = BehaviorSubject();
  StreamSink get onSubmitTodo => _actionSubmitController;

  // Stream yang di gunakan untuk event delete
  StreamController _actionDeleteController = BehaviorSubject();
  StreamSink get onDeleteTodo => _actionDeleteController;

  TodoListBloc() {
    _actionSubmitController.stream.listen(_logicSubmit);
    _actionDeleteController.stream.listen(_logicDelete);
  }

  // proses submit
  void _logicSubmit(data) {
    _list.add(data);
    _inAdd.add(_list);
  }

  // proses delete
  void _logicDelete(index) {
    _list.removeAt(index);
    _inAdd.add(_list);
  }

  void dispose() {
    _actionSubmitController.close();
    _actionDeleteController.close();
    _listController.close();
  }
}
