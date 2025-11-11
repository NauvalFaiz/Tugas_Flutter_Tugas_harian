import 'package:belajar_flutter_r7/Widgets/Pages/Navbar/widgets/CustomTitle.dart';
import 'package:belajar_flutter_r7/Widgets/Pages/Navbar/widgets/ProfileCompany.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings_rounded)),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/profile.png"),
              ),
              SizedBox(height: 10),
              Text(
                "Nauval Faiz Luthf Hisyam",
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Mobile Developer",
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  'Completed your profile',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text("(1/5)", style: TextStyle(color: Colors.blue)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: List.generate(5, (index) {
              return Expanded(
                child: Container(
                  height: 7,
                  width: 10,
                  margin: EdgeInsets.only(right: index == 4 ? 0 : 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: index == 0 ? Colors.blue : Colors.black12,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 180,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final card = profilecompany[index];
                return SizedBox(
                  height: 160,
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Icon(card.icon, size: 30),
                          SizedBox(height: 10),
                          Text(card.title, textAlign: TextAlign.center),
                          const Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(card.buttonText),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  Padding(padding: EdgeInsets.only(right: 5)),
              itemCount: profilecompany.length,
            ),
          ),
          SizedBox(height: 35),
          ...List.generate(customtitle.length, (index) {
            final tile = customtitle[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Card(
                color: Colors.white,
                elevation: 4,
                shadowColor: Colors.black12,
                child: ListTile(
                  title: Text(tile.title),
                  leading: Icon(tile.icon),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
