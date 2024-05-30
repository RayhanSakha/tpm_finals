import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/sparepart.dart';

class SparepartPage extends StatefulWidget {
  @override
  _SparepartPageState createState() => _SparepartPageState();
}

class _SparepartPageState extends State<SparepartPage> {
  late Box<Sparepart> sparepartBox;

  @override
  void initState() {
    super.initState();
    sparepartBox = Hive.box<Sparepart>('sparepartsBox');
  }

  void _addSparepart() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameController = TextEditingController();
        final TextEditingController stockController = TextEditingController();
        return AlertDialog(
          title: Text('Add Sparepart'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Sparepart Name'),
              ),
              TextField(
                controller: stockController,
                decoration: InputDecoration(labelText: 'Initial Stock'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text;
                final stock = int.tryParse(stockController.text) ?? 0;
                if (name.isNotEmpty && stock > 0) {
                  final newSparepart = Sparepart(name: name, stock: stock);
                  sparepartBox.add(newSparepart);
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editSparepart(Sparepart sparepart) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameController = TextEditingController(text: sparepart.name);
        final TextEditingController stockController = TextEditingController(text: sparepart.stock.toString());
        return AlertDialog(
          title: Text('Edit Sparepart'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Sparepart Name'),
              ),
              TextField(
                controller: stockController,
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  sparepart.name = nameController.text;
                  sparepart.stock = int.parse(stockController.text);
                  sparepart.save();
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSparepart(Sparepart sparepart) {
    setState(() {
      sparepart.delete();
    });
  }

  void _updateStock(Sparepart sparepart, int delta) {
    setState(() {
      sparepart.stock += delta;
      sparepart.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spareparts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addSparepart,
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: sparepartBox.listenable(),
        builder: (context, Box<Sparepart> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text('No spareparts available.'),
            );
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final sparepart = box.getAt(index) as Sparepart;
              return ListTile(
                title: Text(sparepart.name),
                subtitle: Text('Stock: ${sparepart.stock}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => _updateStock(sparepart, -1),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _updateStock(sparepart, 1),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editSparepart(sparepart),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteSparepart(sparepart),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
