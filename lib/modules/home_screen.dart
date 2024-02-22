import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/home_screen_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HomeScreenProvider provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<HomeScreenProvider>();
    provider.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer<HomeScreenProvider>(
        builder:
            (BuildContext context, HomeScreenProvider provider, Widget? child) {
          return ListView.builder(
            itemCount: provider.tasks?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(provider.tasks![index].title),
                subtitle: Text(provider.tasks![index].description),
                trailing:
                    Text(provider.tasks![index].date.toString().split(' ')[0]),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController updateTitleController =
                          TextEditingController(
                              text: provider.tasks![index].title);
                      TextEditingController updateDescriptionController =
                          TextEditingController(
                              text: provider.tasks![index].description);

                      return AlertDialog(
                        title: Text('Update ${provider.tasks![index].title}'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: updateTitleController,
                              decoration: const InputDecoration(
                                labelText: 'Task Title',
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: updateDescriptionController,
                              decoration: const InputDecoration(
                                labelText: 'Task Description',
                              ),
                            )
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (updateTitleController.text.isEmpty ||
                                  updateDescriptionController.text.isEmpty) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please fill all the fields'),
                                  ),
                                );
                                return;
                              }
                              provider.updateTask(
                                index,
                                updateTitleController.text,
                                updateDescriptionController.text,
                              );
                              Navigator.pop(context);
                            },
                            child: const Text('Update'),
                          ),
                        ],
                      );
                    },
                  );
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete ${provider.tasks![index].title}'),
                        content: const Text('Are you sure you want to delete?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              provider.deleteTask(index);
                              Navigator.pop(context);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Todo Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                        controller: provider.taskTitleController,
                        decoration: const InputDecoration(
                          labelText: 'Task Title',
                        )),
                    const SizedBox(height: 10),
                    TextField(
                        controller: provider.taskDescriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Task Description',
                        ))
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (provider.taskTitleController.text.isEmpty ||
                          provider.taskDescriptionController.text.isEmpty) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all the fields'),
                          ),
                        );
                        return;
                      }
                      provider.addTask();
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Add Todo Task',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
