import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:musicapps/models/MyAnalyticsHelper.dart';
import 'package:musicapps/models/authentication.dart';
import 'package:musicapps/models/database.dart';
import 'package:musicapps/models/user.dart';
import '../models/trackModel.dart';
import 'listTrack.dart';
import 'login.dart';
import 'profile.dart';
import 'register.dart';
import 'searchPage.dart';
import 'requestAPI.dart';

// class HomeBar extends StatefulWidget {
//   @override
//   _HomeBarState createState() => _HomeBarState();
// }

// class _HomeBarState extends State<HomeBar> {
//   int selectedPage = 0;

//   final _pageOptions = [
//     HomePage(),
//     ListTrack(),
//     Profile(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Periksa status login saat widget diinisialisasi
//     // checkLoginStatus();
//   }

//   // Fungsi untuk memeriksa status login
//   // Future<void> checkLoginStatus() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   bool loggedIn = prefs.getBool('isLoggedIn') ?? false;

//   //   if (loggedIn) {
//   //     // Jika pengguna sudah login, periksa apakah data login valid di database.
//   //     String email = prefs.getString('email') ?? "";
//   //     String password = prefs.getString('password') ?? "";

//   //     DatabaseHelper dbHelper = DatabaseHelper();
//   //     await dbHelper.initDb(); // Inisialisasi database jika belum dilakukan.

//   //     User? user = await dbHelper.getUserByPassword(email, password);

//   //     if (user != null) {
//   //       setState(() {
//   //         isLoggedIn = true;
//   //       });
//   //     } else {
//   //       prefs.setBool('isLoggedIn', false);
//   //     }
//   //   } else {
//   //     setState(() {
//   //       isLoggedIn = false;
//   //     });
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     List<Song> songs = Song.songs;
//     List<Playlist> playlists = Playlist.playlists;
//     return Scaffold(
//       body: _pageOptions[selectedPage],
//     );
//   }
// }

class HomePage extends StatefulWidget {
  final String? email;
  final List<Music>? tracks;

  const HomePage({Key? key, this.email, this.tracks}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // AudioPlayer audioPlayer = AudioPlayer();
  MyAnalyticsHelper fbAnalytics = MyAnalyticsHelper();
  int selectedPage = 0;
  late HttpHelper helper;
  late List? tracks;

  late final List<Widget> _pageOptions;

  Future<void> loadData() async {
    tracks = await helper.getData();
    setState(() {
      tracks = tracks;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageOptions = [
      HomePageContent(),
      ListTrack(),
      Profile(),
    ];
    helper = HttpHelper();
    loadData();
  }

  // @override
  // void dispose() {
  //   audioPlayer.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Colors.white)),
      ),
      drawer: DrawerBar(emails: widget.email),
      body: FutureBuilder<List<Music>?>(
        future:
            helper.getData(), // Call the getData method from your HttpHelper
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Music>? tracks = snapshot.data;

            return ListView.builder(
              itemCount: tracks?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tracks![index].title),
                  subtitle: Text(tracks[index].artist),
                  leading: CircleAvatar(
                      backgroundImage: tracks[index].image != null &&
                              tracks[index].image.isNotEmpty
                          ? NetworkImage(tracks[index].image)
                          : NetworkImage(tracks[index].image)),
                );
              },
            );
          }
        },
      ),

      //     _pageOptions[selectedPage],
      // bottomNavigationBar: BottomNavigationBar(
      //   iconSize: 25,
      //   backgroundColor: Colors.blueGrey,
      //   elevation: 0,
      //   selectedFontSize: 10,
      //   selectedIconTheme: IconThemeData(color: Colors.lime, size: 30),
      //   selectedItemColor: Colors.limeAccent,
      //   selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      //   unselectedItemColor: Colors.white70,
      //   showUnselectedLabels: false,
      //   currentIndex: selectedPage,
      //   onTap: (index) {
      //     setState(() {
      //       selectedPage = index;
      //     });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home_rounded),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.music_note),
      //       label: 'My Library',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person_2_rounded),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),

      // Column(
      //   children: [
      //     Padding(
      //       padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
      //       child: Text('Home'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () async {
      //         fbAnalytics.testEventLog('Send_Event');
      //         // audioPlayer.play(Song.songs[0].url as Source);
      //       },
      //       child: Text("Play Music"),
      //     ),
      //   ],
      // ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome to Your Music App',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Tambahkan logika untuk aksi tombol di sini
          },
          child: Text('Explore Music'),
        ),
        // Tambahkan widget atau konten lain sesuai kebutuhan
      ],
    );
  }
}

class DrawerBar extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String? emails;

  DrawerBar({super.key, required this.emails});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.lightGreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.face_6_sharp,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          "Guest",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          "$emails",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       TextButton(
          //         onPressed: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               fullscreenDialog: true,
          //               builder: (context) => LoginPage(),
          //             ),
          //           );
          //         },
          //         child: const Text('LOGIN'),
          //         style: TextButton.styleFrom(
          //           foregroundColor: Color.fromARGB(255, 96, 43, 103),
          //           backgroundColor: Colors.white,
          //           shape: const BeveledRectangleBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(5)),
          //           ),
          //           textStyle: TextStyle(fontWeight: FontWeight.bold),
          //           elevation: 3,
          //         ),
          //       ),
          //       TextButton(
          //         onPressed: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => RegisterPage(),
          //             ),
          //           );
          //         },
          //         child: Text('REGISTER'),
          //         style: TextButton.styleFrom(
          //           backgroundColor: Colors.lightGreen,
          //           foregroundColor: Colors.white,
          //           shape: const BeveledRectangleBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(5)),
          //           ),
          //           textStyle: TextStyle(fontWeight: FontWeight.bold),
          //           elevation: 3,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => HomePage(
                    email: emails,
                  ),
                ),
              );
            },
            leading: Icon(Icons.home_filled),
            title: Text("Home"),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.play_circle_fill_rounded),
            title: Text("Playlist"),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => HomePage(
                    email: emails,
                  ),
                ),
              );
            },
            leading: Icon(Icons.question_mark_sharp),
            title: Text("About Us"),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
          ),
          const Divider(),
          TextButton(
            onPressed: () async {
              await AuthFirebase().logOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: const Text(
              'Log Out?',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

logoutLoading(BuildContext context) {
  return AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(),
        Container(
            margin: EdgeInsets.only(left: 15),
            child: Text("This will take few seconds...")),
      ],
    ),
  );
}
