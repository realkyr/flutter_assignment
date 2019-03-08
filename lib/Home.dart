import 'package:flutter/material.dart';
import './main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Placeholder extends StatelessWidget {
  final String title;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Placeholder(this.title);

  void _logout(context) async {
    await auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(children: <Widget>[
        Center(child: Text(title)),
        RaisedButton(child: Text('Log Out'), onPressed: () => _logout(context),)
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int index = 0;
  final List<Widget> _children = [
    Placeholder('Home'),
    Placeholder('Notify'),
    Placeholder('Map'),
    Placeholder('Profile'),
    Placeholder('Settings')
    ];

  void _navHandler(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).primaryColor,
          ),
          child: BottomNavigationBar(
            currentIndex: index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                title: Text('Notifications'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text('map')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Setting')
              ),
            ],
            onTap: _navHandler,
          ),
        ),
        body: _children[index]);
  }
}
