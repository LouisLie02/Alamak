import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class playTrack extends StatefulWidget {
  const playTrack({Key?key}):super(key: key);

  @override
  State<playTrack> createState() => _playTrackState();
}

class _playTrackState extends State<playTrack> {
  late StreamSubscription _sub;
  final Stream _myStream = 
  Stream.periodic(const Duration(seconds: 1),(int count){
    return count;
  });

  String formattedTime(int time) // --> time in form of seconds
  {    
    final int sec = time % 60;
    final int min = (time / 60).floor();
    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }

  int percent = 0;//persentase untuk progres indicator
  int total = 100 ; //misal ini adalah total durasi musik
  double track = 0; //tampilan value progress
  var reset = false;
  bool playing = false;

    @override
  void initState() {
    _sub = _myStream.listen((event) {
      setState(() {
        if (track == 1) { //jika lagu sudah selesai sampai habis
          _sub.cancel();
          percent = 1;
          track = 1.0;
        } else {
          percent += 1;
          track = percent / 100;
      }});
    });
    super.initState(); //awalnya lagu dimainkan otomatis
  }

    void resetTimer(){
    setState(() {
      percent=0;
      track=0;
      reset=false;
      _sub.resume();
    });    

  }

  void startTimer() {
    if (!reset) {
      _sub.resume();
      reset = false;
    }
  }

  void pauseTimer(){
    if(!reset){
      _sub.pause();
      reset=false;
    }
  }

  void skipTimer(){
    if (!reset){
      percent += 5;
      track = percent/100;
    }
  }

  void flipTimer(){
    if (!reset){
      percent -= 5;
      track = percent/100;
    }
    if (total <= 5){
      percent = 0;
      track = 0;
      total = 0;
      _sub.resume();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playing Tracks...'),
      ),
      body : Center(
        child: LayoutBuilder(builder: (context,constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15.0),
                child: Image.network('https://images.designtrends.com/wp-content/uploads/2016/01/27194119/c1.jpg',height: 250,
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Royal Blood',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                  const Text('Tesla Maneez')
                ],
              ),),

              Padding(padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget> [
                    Text(formattedTime(percent)),
                    Text(formattedTime(total))
                  ],
                ),),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0),
                  ),
                  child: LinearProgressIndicator(
                  value: track,
                  backgroundColor: Colors.grey,
                  color: Colors.deepPurple,
                  minHeight: 8.0,
                  )),
            
                ),

                
      
                Padding(padding: EdgeInsets.all(10.0),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Ink(
                  decoration: const ShapeDecoration(shape: CircleBorder(),
                  color: Colors.white10),
                  child: IconButton(
                    onPressed:flipTimer,
                    icon: Icon(Icons.skip_previous,color: Colors.deepPurple,)),
                ),

                Ink(
                  decoration: const ShapeDecoration(shape: CircleBorder(),
                  color: Colors.deepPurple),
                  child: IconButton(
                    onPressed:pauseTimer,
                    icon: Icon(Icons.pause_outlined,color: Colors.white,)),
                ),
                Ink(
                  decoration: const ShapeDecoration(shape: CircleBorder(),
                  color: Colors.white10),
                  child: IconButton(
                    onPressed:startTimer,
                    icon: Icon(Icons.play_arrow,color: Colors.deepPurple,)),
                ),
                Ink(
                  decoration: const ShapeDecoration(shape: CircleBorder(),
                  color: Colors.white10),
                  child: IconButton(
                    onPressed:resetTimer,
                    icon: Icon(Icons.loop,color: Colors.deepPurple,)),
                ),

                Ink(
                  decoration: const ShapeDecoration(shape: CircleBorder(),
                  color: Colors.white10),
                  child: IconButton(
                    onPressed:skipTimer,
                    icon: Icon(Icons.skip_next,color: Colors.deepPurple,)),
                ),

                
              ],
            ),
                )
      
            
            ],
          );
        
        
        })),

      );
  }
}