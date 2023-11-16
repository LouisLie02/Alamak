import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musicapps/pages/home.dart';
import 'searchPage.dart';

class ListTrack extends StatefulWidget {
  final String? email;
  const ListTrack({Key? key, this.email}) : super(key: key);

  @override
  State<ListTrack> createState() => _ListTrackState();
}

class _ListTrackState extends State<ListTrack> {
  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Library',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: DrawerBar(
        emails: widget.email,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: SizedBox(
              height: 50,
              child: TextField(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
                cursorHeight: 25,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.mic),
                      color: Colors.white,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    fillColor: Colors.blueGrey,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: 'Search Here...',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
