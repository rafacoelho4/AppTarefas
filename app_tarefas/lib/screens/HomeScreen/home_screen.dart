import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              TextField(),
              RaisedButton(
                onPressed: () {},
                color: Colors.blue,
                child: Text(
                  'Adicionar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              )
            ],
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[200],
          ),
          title: Text('Atividade 1'),
          trailing: Icon(Icons.edit),
        )
      ],
    );
  }
}
