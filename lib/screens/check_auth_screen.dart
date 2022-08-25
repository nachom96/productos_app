import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: FutureBuilder(
        future: authService.readToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: const [
                  Text('Espere'),
                  CircularProgressIndicator()
                ],
              ),
            );
          }

          if (snapshot.data == ''){
          // Instrucción que se ejecuta tan pronto tan pronto la construcción del widget termine
          Future.microtask((){
            Navigator.pushReplacement(context, PageRouteBuilder(
              pageBuilder: ( _, __, ___) => LoginScreen(),
              transitionDuration: Duration( seconds: 0),
              ));
          // Navigator.of(context).pushReplacementNamed('login');
          }); 
            
          } else{
            // Instrucción que se ejecuta tan pronto tan pronto la construcción del widget termine
          Future.microtask((){
            Navigator.pushReplacement(context, PageRouteBuilder(
              pageBuilder: ( _, __, ___) => HomeScreen(),
              transitionDuration: Duration( seconds: 0),
              ));
          // Navigator.of(context).pushReplacementNamed('login');
          }); 
          }
          return Container();
        },
      ),
    );
  }
}
