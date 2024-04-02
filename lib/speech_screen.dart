import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {

  SpeechToText speechToText = SpeechToText();


  var listening = false;
  var text = 'Hold the Button and Start Speaking';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: AvatarGlow(
          glowRadiusFactor: 0.6,
          animate: listening,
          duration: Duration(milliseconds: 2000),
          glowColor: Colors.cyan,
          repeat: true,
          child: GestureDetector(
            onTapDown: (details) async{
              if(!listening){
                var available = await speechToText.initialize();
                if(available){
                  setState(() {
                    listening = true;
                    speechToText.listen(
                      onResult: (result){
                        setState(() {
                          text = result.recognizedWords;
                        });
                      }
                    );
                  });
                }
              }
            },
            onTapUp: (details){
              setState(() {
                listening = false;
              });
              speechToText.stop();
            },
            child: CircleAvatar(
              backgroundColor: Colors.cyan,
              radius: 35,
              child: Icon(listening ? Icons.mic : Icons.mic_none, color: Colors.white),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Speech To Text' , style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'rubik',
        ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assests/bg2.jpg'),
            fit: BoxFit.cover,
          )
        ),
        child: SingleChildScrollView(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            margin: EdgeInsets.only(bottom: 150),
            child: Text(text, style: TextStyle(
              fontSize: 30,
              color: listening ? Colors.cyan  : Colors.black87,
              fontWeight: FontWeight.w400,
              fontFamily: 'satisfy',
            ),
            ),
          ),
        ),
      ),
    );
  }
}
