import 'package:flutter/material.dart';
import 'package:shop/providers/counter.dart';

class CounterPage extends StatefulWidget {
  const CounterPage();

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exemplo Contador"),
      ),
      body: Column(
        children: [
          Text((CounterProvider.of(context)?.state.value as int).toString() ??
              '0'),
          IconButton(
            onPressed: () {
              setState(() {
                CounterProvider.of(context)?.state.inc();
              });
              print(
                  (CounterProvider.of(context)?.state.value as int).toString());
            },
            icon: Icon(
              Icons.add,
              color: Colors.blue,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                CounterProvider.of(context)?.state.dec();
              });
              print(
                  (CounterProvider.of(context)?.state.value as int).toString());
            },
            icon: Icon(
              Icons.remove,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
