import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, dynamic>> _allTracks = [
    {
      "img": "pic1.jpeg",
      "title": "How Much I Love You",
      "artist": 'Smoke to Key'
    },
    {
      "img": "pic2.jpeg",
      "title": "Delusion of Yours",
      "artist": 'Smoke to Key'
    },
    {"img": "pic3.jpeg", "title": "Feel the Sand", "artist": 'Make A Wish'},
    {"img": "pic4.jpeg", "title": "Believe in Youth", "artist": 'A Not Nimbus'},
  ];

  late List<Map<String, dynamic>> _foundTracks = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    _foundTracks = _allTracks;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allTracks;
    } else {
      results = _allTracks
          .where((user) => user["title"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTracks = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: const Text('Search Track'),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
            child: CupertinoSearchTextField(
                controller: controller,
                onChanged: (value) => _runFilter(value),
                placeholderStyle: TextStyle(color: Colors.white)),
          ),
          Expanded(
              child: _foundTracks.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: _foundTracks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                            color: Color.fromARGB(179, 249, 230, 244),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.20,
                                      maxHeight:
                                          MediaQuery.of(context).size.width *
                                              0.12,
                                    ),
                                    child: Image.asset(
                                      'lib/assets/${_foundTracks[index]['img']}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          _foundTracks[index]['title'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            2, 0, 0, 3),
                                        child: Text(
                                          _foundTracks[index]['artist'],
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon:
                                          const Icon(Icons.play_arrow_rounded)),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                  : Container(
                      height: 500,
                      width: double.infinity,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 200,
                              child: Column(children: [
                                Text('No Tracks Found',
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.8))),
                                const Icon(Icons.music_off_rounded,
                                    color: Colors.grey),
                              ]),
                            )
                          ]),
                    ))
        ],
      ),
    );
  }
}
