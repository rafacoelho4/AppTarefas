import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Tarefas'),
        centerTitle: true,
        elevation: 0,
      ),
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List todoList = [];

  Map<String, dynamic> lastRemoved;
  int lastRemovedPos;

  TextEditingController tarefaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        todoList = json.decode(data);
      });
    });
  }

  void addTodo() {
    setState(() {
      Map<String, dynamic> newTodo = Map();
      newTodo["title"] = tarefaController.text;
      tarefaController.text = '';
      newTodo["ok"] = false;

      todoList.add(newTodo);
      _saveData();
    });
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return File('${directory.path}/data.json');
  }

  Future<File> _saveData() async {
    String data = json.encode(todoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (err) {
      return null;
    }
  }

  Future<Null> refresh() async {
    await Future.delayed(Duration(seconds: 1));

    todoList.sort((a, b) {
      if (a["ok"] && !b["ok"])
        return 1;
      else if (!a["ok"] && b["ok"])
        return -1;
      else
        return 0;
    });

    setState(() {
      _saveData();
    });
  }

  Widget buildItem(context, index) {
    return Dismissible(
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        onDismissed: (direction) {
          setState(() {
            lastRemoved = Map.from(todoList[index]);
            lastRemovedPos = index;
            todoList.removeAt(index);

            _saveData();

            final snack = SnackBar(
              content: Text('Tarefa \"${lastRemoved["title"]}\" deletada!'),
              action: SnackBarAction(
                label: 'Desfazer',
                onPressed: () {
                  setState(() {
                    todoList.insert(lastRemovedPos, lastRemoved);
                    _saveData();
                  });
                },
              ),
              duration: Duration(seconds: 2),
            );

            Scaffold.of(context).removeCurrentSnackBar();
            Scaffold.of(context).showSnackBar(snack);
          });
        },
        direction: DismissDirection.startToEnd,
        background: Container(
          color: Colors.redAccent[700],
          child: Align(
            alignment: Alignment(-0.9, 0),
            child: Icon(
              Icons.delete_outline,
              color: Colors.white,
            ),
          ),
        ),
        child: CheckboxListTile(
          value: todoList[index]["ok"],
          onChanged: (c) {
            setState(() {
              todoList[index]["ok"] = c;
            });
          },
          title: Text(todoList[index]["title"]),
          secondary: CircleAvatar(
            child: todoList[index]["ok"] == true
                ? Icon(Icons.done)
                : Icon(Icons.notification_important),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(18, 24, 18, 14),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: tarefaController,
                  decoration: InputDecoration(
                      labelText: 'Nova tarefa',
                      labelStyle: TextStyle(color: Colors.indigo)),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              RaisedButton(
                onPressed: () {
                  addTodo();
                },
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.indigo,
              )
            ],
          ),
        ),
        Expanded(
            child: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemCount: todoList.length,
            itemBuilder: buildItem,
          ),
        )),
      ],
    );
  }
}
