import 'package:flutter/material.dart';
import 'package:task_firebase/controllers/users_controller.dart';
import 'package:task_firebase/screens/add_edit_screen.dart';

class AdvListScreen extends StatefulWidget {
  const AdvListScreen({super.key});

  @override
  State<AdvListScreen> createState() => _AdvListScreenState();
}

class _AdvListScreenState extends State<AdvListScreen> {
  late Future<List<Map<String, dynamic>>> _advsFuture;

  @override
  void initState() {
    super.initState();
    _loadAdvs();
  }

  void _loadAdvs() {
    _advsFuture = UsersController.getAllAdvs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advertisements')),
      body: FutureBuilder(
        future: _advsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No advertisements yet.'));
          }

          final advs = snapshot.data!;
          return ListView.builder(
            itemCount: advs.length,
            itemBuilder: (context, index) {
              var adv = advs[index];
              return ListTile(
                title: Text(adv['name'] ?? ''),
                subtitle: Image.network(
                  adv['image'] ?? '',
                  width: 100,
                  height: 70,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AdvAddEditScreen(
                          advId: adv['id'],
                          currentName: adv['name'],
                          currentImage: adv['image'],
                        ),
                      ),
                    );
                    setState(_loadAdvs);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.amber,

        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AdvAddEditScreen()),
          );
          setState(_loadAdvs);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
