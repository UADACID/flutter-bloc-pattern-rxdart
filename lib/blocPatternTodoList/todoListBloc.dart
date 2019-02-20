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

  // Stream to handle the counter

  StreamController<List<Todo>> _listController = BehaviorSubject<List<Todo>>();
  StreamSink<List<Todo>> get _inAdd => _listController.sink;
  ValueObservable<List<Todo>> get outList => _listController.stream;

  // Stream yang di gunakan untuk event submit
  StreamController _actionSubmitController = BehaviorSubject();
  StreamSink get onSubmitTodo => _actionSubmitController;

  // Stream yang di gunakan untuk event delete
  StreamController _actionDeleteController = BehaviorSubject();
  StreamSink get onDeleteTodo => _actionDeleteController;

  // Stream yang di gunakan untuk event done
  StreamController _actionDoneController = BehaviorSubject();
  StreamSink get onDoneTodo => _actionDoneController;

  TodoListBloc() {
    _actionSubmitController.stream.listen(_logicSubmit);
    _actionDeleteController.stream.listen(_logicDelete);
    _actionDoneController.stream.listen(_logicDone);
  }

  // proses submit
  void _logicSubmit(data) {
    _list.add(Todo(title: data, done: false));
    _inAdd.add(_list);
  }

  // proses delete
  void _logicDelete(index) {
    _list.removeAt(index);
    _inAdd.add(_list);
  }

  void _logicDone(index) {
    // print(index);
    _list[index].done = !_list[index].done;
    _inAdd.add(_list);
  }

  void dispose() {
    _actionSubmitController.close();
    _actionDeleteController.close();
    _listController.close();
    _actionDoneController.close();
  }
}
