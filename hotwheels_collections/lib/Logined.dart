import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'provider/GoogleSignIn.dart';

class LoginedPage extends StatelessWidget {
  const LoginedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logined"),
        actions: [
          TextButton(
              onPressed: () {
                final provider = Provider.of<GoogleSignProvider>(context,listen: false);
                provider.logout();
              },
              style: TextButton.styleFrom(
                primary: Colors.pink,
              ),
              child: Text("logout"))
        ],
      ),
      
    );
  }
}
