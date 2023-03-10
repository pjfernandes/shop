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
    final provider = CounterProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exemplo Contador"),
      ),
      body: Column(
        children: [
          Text((provider?.state.value as int).toString() ?? '0'),
          IconButton(
            onPressed: () {
              setState(() {
                provider?.state.inc();
              });
              print((provider?.state.value as int).toString());
            },
            icon: Icon(
              Icons.add,
              color: Colors.blue,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                provider?.state.dec();
              });
              print((provider?.state.value as int).toString());
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
