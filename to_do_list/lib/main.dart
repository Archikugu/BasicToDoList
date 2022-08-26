import "package:flutter/material.dart";

void main() {
  runApp(App());
}

class ToDoItem {
  String title, description;
  bool isDone;

  ToDoItem(
      {required this.title, required this.description, required this.isDone});
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<ToDoItem> items = [
    ToDoItem(
      title: "Markete git",
      description: "Abur cubur al",
      isDone: false,
    ),
    ToDoItem(
      title: "Toplantıya katıl",
      description: "Ürünü anlat",
      isDone: true,
    ),
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                reverse: true,
                itemCount: items.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    thickness: 5,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  ToDoItem item = items.elementAt(index);

                  if (item.isDone) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              title: item.title,
                              description: item.description,
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        tileColor: Colors.green.withOpacity(0.25),
                        title: Text(
                          item.title,
                        ),
                        subtitle: Text(
                          item.description,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              item.isDone = false;
                            });
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  }

                  return ListTile(
                    title: Text(
                      item.title,
                    ),
                    subtitle: Text(
                      item.description,
                    ),
                    trailing: Wrap(children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            item.isDone = true;
                          });
                        },
                        icon: Icon(Icons.done),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            items.remove(item);
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                        ),
                      ),
                    ]),
                  );
                },
              ),
            ),
            Divider(
              thickness: 15,
            ),
            Expanded(
              child: ListView(padding: const EdgeInsets.all(32), children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Item",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(label: Text("Title")),
                      controller: titleController,
                    ),
                    TextField(
                      decoration: InputDecoration(label: Text("Description")),
                      controller: descriptionController,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ToDoItem newItem = ToDoItem(
                          title: titleController.text,
                          description: descriptionController.text,
                          isDone: false,
                        );

                        titleController.clear();
                        descriptionController.clear();

                        setState(() {
                          items.add(newItem);
                        });
                      },
                      child: Text("Add"),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  String title;
  String description;

  DetailScreen({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(title),
            Text(description),
            ElevatedButton(
              onPressed: () {},
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
