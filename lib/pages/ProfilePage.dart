import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:term_project/pages/MyListPage.dart';
import 'package:term_project/pages/setting_page.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/ProfilePage';
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> screens = [
    MyListPage.routeName,
    SettingsPage.routeName,
  ];
  final List<Segments> myList = [
    Segments(
        routeName: MyListPage.routeName,
        icon: const Icon(Icons.favorite_border_outlined, color: Colors.yellow),
        title: 'Favorites'),
    Segments(
        routeName: SettingsPage.routeName,
        icon: const Icon(Icons.settings, color: Colors.yellow),
        title: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.person_sharp,
        ),
        title: const Text('Profile'),
        backgroundColor: const Color.fromRGBO(53, 83, 88, 1),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  height: 150,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        "${FirebaseAuth.instance.currentUser!.photoURL}"),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${FirebaseAuth.instance.currentUser!.displayName}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "${FirebaseAuth.instance.currentUser!.email}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: myList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Card(
                      color: const Color.fromRGBO(53, 83, 88, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(myList[index].routeName);
                        },
                        //Navigation bar gelmiyor whyy?
                        leading: myList[index].icon,
                        title: Text(
                          myList[index].title,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class Segments {
  final Icon icon;
  final String title;
  String routeName;

  Segments({required this.icon, required this.title, required this.routeName});
}
