import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_iterators/auth/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Let's sign you in.",
                style: GoogleFonts.exo(fontWeight: FontWeight.w800, fontSize: 40),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                "Welcome back",
                style: GoogleFonts.exo(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                "You have been missed!",
                style: GoogleFonts.exo(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                width: 340,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff2638a29)),
                        borderRadius: BorderRadius.circular(8.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(8.5),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey.shade600,
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                width: 340,
                child: TextFormField(
                  obscureText: isShowPassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff2638a29)),
                        borderRadius: BorderRadius.circular(8.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff2638a29)),
                        borderRadius: BorderRadius.circular(8.5),
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: Colors.grey.shade600,
                      ),
                      suffixIcon: CupertinoButton(
                        onPressed: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                          });
                        },
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.visibility,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
            ),
            
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(244, 42),
                    backgroundColor: Color(0xff263a29)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Signup();
                  }));
                },
                child: Text(
                  "Sign in",
                  style: GoogleFonts.georama(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Color(0xffa0a0a0)),
                ),
                SizedBox(width: 5,),
                CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text(
                      "Register here",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff23d48e),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const Signup();
                      }));
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}