import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box usersBox;
  late Box sessionBox;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    usersBox = Hive.box('usersBox');
    sessionBox = Hive.box('sessionBox');

    String currentUsername = sessionBox.get('currentUser');
    currentUser = usersBox.get(currentUsername);
  }

  void _addFavoriteMovie() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController movieController = TextEditingController();
        return AlertDialog(
          title: Text('Add Favorite Movie'),
          content: TextField(
            controller: movieController,
            decoration: InputDecoration(labelText: 'Movie Name'),
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
                  currentUser!.favoriteMovies.add(movieController.text);
                  currentUser!.save();
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Welcome, ${currentUser?.username}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addFavoriteMovie,
              child: Text('Add Favorite Movie'),
            ),
            SizedBox(height: 20),
            Text(
              'Your Favorite Movies:',
              style: TextStyle(fontSize: 16),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentUser?.favoriteMovies.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(currentUser!.favoriteMovies[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
