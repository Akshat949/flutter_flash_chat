import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_iterators/auth/signup.dart';

class Intropage extends StatelessWidget {
  const Intropage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 390,
            height: 620,
            decoration: const BoxDecoration(
              color: Color(0xff263a29),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            child: Center(
              child: Image.asset(
                "images/TAXX1.png",
                height: 400,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(244, 42),
                  backgroundColor: Color(0xff263a29)),
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const Signup();
                    }));
              },
              child: Text(
                "Get started",
                style: GoogleFonts.georama(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
