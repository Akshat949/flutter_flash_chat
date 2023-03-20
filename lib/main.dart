import 'package:flach_chat/screens/chat_screen.dart';
import 'package:flach_chat/screens/login_screen.dart';
import 'package:flach_chat/screens/registration_screen.dart';
import 'package:flach_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';



Future main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const FlachChat());
}
class FlachChat extends StatelessWidget {
  const FlachChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.black54
          ),
          bodyText2: TextStyle(color:Colors.white),
          subtitle1: TextStyle(color: Colors.black),
        )
      ),
      initialRoute: WelcomeScreen.id,
      routes:{
        WelcomeScreen.id:(context)=> WelcomeScreen(),
        LoginScreen.id:(context)=> LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        ChatScreen.id:(context)=> ChatScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}


