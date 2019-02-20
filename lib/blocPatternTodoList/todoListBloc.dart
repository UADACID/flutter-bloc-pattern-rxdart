import 'package:flutter_rx_bloc/blocPatternTodoList/blocBase.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class Todo {
  final String title;
  bool done;

  Todo({this.title, this.done});
}

class TodoListBloc implements BlocBase {
  List<Todo> _list = <Todo>[];
  bool _loading;
  int _counterDone;

  TodoListBloc() {
    _actionSubmitController.stream.listen(_logicSubmit);
    _actionDeleteController.stream.listen(_logicDelete);
    _actionDoneController.stream.listen(_logicDone);
  }

  Subject<List<Todo>> _listController = BehaviorSubject<List<Todo>>();
  StreamSink<List<Todo>> get _inAdd => _listController.sink;
  ValueObservable<List<Todo>> get outList => _listController.stream;

  // stream status loading
  Subject<bool> _loadingController = BehaviorSubject<bool>();
  StreamSink<bool> get _inLoading => _loadingController.sink;
  ValueObservable<bool> get outLoading => _loadingController.stream;
  // proses in out status loading

  void _logicLoading(value) {
    _loading = value;
    _inLoading.add(_loading);
  }

  // Stream yang di gunakan untuk event delete
  Subject _actionDeleteController = BehaviorSubject();
  StreamSink get onDeleteTodo => _actionDeleteController;
  // proses delete
  void _logicDelete(index) {
    _list.removeAt(index);
    _inAdd.add(_list);
    _countingStatusDone();
  }

  // Stream yang di gunakan untuk event done
  Subject _actionDoneController = BehaviorSubject();
  StreamSink get onDoneTodo => _actionDoneController;
  // proses done todo by index
  void _logicDone(index) {
    _list[index].done = !_list[index].done;
    _inAdd.add(_list);
    _countingStatusDone();
  }

  // Stream yang di gunakan untuk event submit
  Subject _actionSubmitController = BehaviorSubject();
  StreamSink get onSubmitTodo => _actionSubmitController;
  // proses submit
  void _logicSubmit(data) {
    _logicLoading(true);
    Future.delayed(Duration(milliseconds: 1000), () {
      _list.add(Todo(title: data, done: false));
      _inAdd.add(_list);
      _logicLoading(false);
    });
  }

// stream yang digunakan untuk event counting done = tru
  Subject<int> _counterDoneController = BehaviorSubject<int>();
  StreamSink<int> get _inCounterDone => _counterDoneController.sink;
  ValueObservable<int> get outCounterDone => _counterDoneController.stream;
// proses menghitung list status done = true
  void _countingStatusDone() {
    _counterDone = _list.where((i) => i.done == true).length;
    _inCounterDone.add(_counterDone);
  }

  void dispose() {
    _actionSubmitController.close();
    _actionDeleteController.close();
    _listController.close();
    _actionDoneController.close();
    _loadingController.close();
    _counterDoneController.close();
  }
}
