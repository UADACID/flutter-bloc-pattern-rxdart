import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/blocPatternTodoList/blocProvider.dart';
import 'package:flutter_rx_bloc/blocPatternTodoList/todoListBloc.dart';

class TodoList extends StatelessWidget {
  final _textEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final todoListBloc = BlocProvider.of<TodoListBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC Todo List'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  controller: _textEditController,
                ),
                RaisedButton(
                  onPressed: () {
                    var text = _textEditController.text;
                    if (text.length > 0) {
                      todoListBloc.onSubmitTodo.add(text);
                      _textEditController.clear();
                    }
                  },
                  child: Icon(Icons.add),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            StreamBuilder(
              stream: todoListBloc.outList,
              initialData: [],
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(snapshot.data[index]),
                              // Icon(Icons.delete)
                              IconButton(
                                onPressed: () {
                                  todoListBloc.onDeleteTodo.add(index);
                                },
                                icon: Icon(Icons.delete),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
