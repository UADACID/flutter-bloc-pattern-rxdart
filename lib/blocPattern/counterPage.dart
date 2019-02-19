import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/blocPattern/blocProvider.dart';
import 'package:flutter_rx_bloc/blocPattern/incrementBloc.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc bloc = BlocProvider.of<IncrementBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC Pattern'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: StreamBuilder(
              stream: bloc.outCounter,
              initialData: 0,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text('you tap me ${snapshot.data}');
              },
            ),
          ),
          RaisedButton(
            child: Text('check tap counter on other page'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) => Test()));
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          bloc.incrementCounter.add(null);
        },
      ),
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc bloc = BlocProvider.of<IncrementBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: StreamBuilder(
              stream: bloc.outCounter,
              initialData: 0,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Text('you tap me ${snapshot.data}');
              },
            ),
          ),
          RaisedButton(
            child: Text('reset counter'),
            onPressed: () {
              bloc.resetCounter.add('hello');
            },
          )
        ],
      ),
    );
  }
}
