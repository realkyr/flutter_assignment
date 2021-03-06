import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController repass = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  void _continue(BuildContext context) async {
    print(email.text);
    print(password.text);
    print(repass.text);
    if (email.text == 'admin'){
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text('user นี้มีอยู่ในระบบแล้ว'),
      ));
    } else if (email.text == '' || password.text == '' || repass.text == '') {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text('กรุณาระบุข้อมูลให้ครบถ้วน'),
      )
    );
    } else if (password.text == repass.text) {
      await auth.createUserWithEmailAndPassword(email: email.text, password: password.text);
      Navigator.pop(context);
    } else {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text('กรุณาใส่ password ให้ตรงกัน'),
      )
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(shrinkWrap: true, children: <Widget>[
              ListTile(
                leading: Icon(Icons.email),
                title: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'E-mail',
                  ),
                  controller: email,
                ),
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                  ),
                  controller: password,
                  obscureText: true,
                ),
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Confirm Password',
                  ),
                  controller: repass,
                  obscureText: true,
                ),
              ),
              ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 50),
              child: Builder(
                builder: (context) => RaisedButton(
                    onPressed: () => this._continue(context),
                    child: Text('Continue', style: TextStyle(color: Colors.white)),
                    color: Theme.of(context).accentColor,
                    splashColor: Colors.blueGrey,
                  )
                ),
              )
            ]
          ),
        )
    );
  }
}
