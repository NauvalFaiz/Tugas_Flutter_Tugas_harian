import 'package:amicons/amicons.dart';
import 'package:belajar_flutter_r7/Widgets/Pages/Navbar/widgets/custom_widget_news.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Hotnews extends StatelessWidget {
  Hotnews({super.key});
  final Color iconcolor = Color(0xFF6161D3);
  final Color textcolor = Color(0xFF6161D3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, iconcolor.withOpacity(0.1)],
                  ),
                ),
              ),

              AppBar(
                
                shadowColor: Colors.black12,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  "Search News",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 3.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Amicons.vuesax_notification),
                    ),
                  ),
                ],
                leading: IconButton(
                  icon: Icon(Amicons.vuesax_search_normal, color: iconcolor),
                  onPressed: () {},
                ),
              ),

              Positioned(
                bottom: -25,
                left: 16,
                right: 16,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(Amicons.vuesax_search_normal),
                      hintText: "Search news...",
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Trending News",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
                    height: 250,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        final card = news[index];
                        return SizedBox(
                          width: 280,
                          child: Card(
                            color: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 130,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/logoSekolah.png",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    card.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                  SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Amicons.iconly_time_circle_fill,
                                              color: iconcolor,
                                              size: 20,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              card.Stringa,
                                              style: TextStyle(
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            Icon(
                                              Amicons.vuesax_messages_3,
                                              size: 18,
                                              color: iconcolor,
                                            ),
                                            SizedBox(width: 2),
                                            Text(
                                              card.Stringb,
                                              style: TextStyle(
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(width: 12),
                      itemCount: news.length,
                    ),
                  ),
                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Other Result",
                      style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final card = news[index];
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 130,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/logoSekolah.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                card.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.4),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Amicons.iconly_time_circle_fill,
                                          color: iconcolor,
                                          size: 20,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          card.Stringa,
                                          style: TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Icon(
                                          Amicons.vuesax_messages_3,
                                          size: 18,
                                          color: iconcolor,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          card.Stringb,
                                          style: TextStyle(
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 12),
                    itemCount: news.length,
                  ),
                  SizedBox(height: 20), // Tambahkan spacing di bagian bawah
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
