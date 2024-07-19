import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int total = 0;
  final List<GlobalKey<_ShoppingItemState>> _itemKeys = [
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
  ];

  void updateTotal(int price, int count) {
    setState(() {
      total += price * count;
    });
  }

  void clearAll() {
    setState(() {
      total = 0;
    });
    for (var key in _itemKeys) {
      key.currentState?.resetCount();
    }
  }

  String formatNumber(int number) {
    return number.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'), (Match match) => ',');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Shopping Cart"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ShoppingItem(
                      key: _itemKeys[0],
                      title: "iPad Pro",
                      price: 32000,
                      onUpdateTotal: updateTotal,
                    ),
                    ShoppingItem(
                      key: _itemKeys[1],
                      title: "iPad Mini",
                      price: 25000,
                      onUpdateTotal: updateTotal,
                    ),
                    ShoppingItem(
                      key: _itemKeys[2],
                      title: "iPad Air",
                      price: 29000,
                      onUpdateTotal: updateTotal,
                    ),
                    ShoppingItem(
                      key: _itemKeys[3],
                      title: "iPad Pro",
                      price: 39000,
                      onUpdateTotal: updateTotal,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${formatNumber(total)} ฿',
                      style: const TextStyle(fontSize: 24, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: clearAll,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text("Clear"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class ShoppingItem extends StatefulWidget {
  final String title;
  final int price;
  final Function(int price, int count) onUpdateTotal;

  ShoppingItem({
    required Key key,
    required this.title,
    required this.price,
    required this.onUpdateTotal,
  }) : super(key: key);

  @override
  State<ShoppingItem> createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
  int count = 0;

  void _incrementCount() {
    setState(() {
      count++;
    });
    widget.onUpdateTotal(widget.price, 1);
  }

  void _decrementCount() {
    if (count > 0) {
      setState(() {
        count--;
      });
      widget.onUpdateTotal(widget.price, -1);
    }
  }

  void resetCount() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.price} ฿",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _decrementCount,
                  icon: const Icon(Icons.remove),
                  color: Colors.red,
                ),
                Text(
                  count.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
                IconButton(
                  onPressed: _incrementCount,
                  icon: const Icon(Icons.add),
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
