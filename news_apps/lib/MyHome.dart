import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_apps/Model.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  TextEditingController search = TextEditingController();
  List<NewsQueryModel>newsModelList=<NewsQueryModel>[];
  List<String> NavBar = [
    "Top News",
    "Pakistan",
    "World",
    "Finance",
    "Health",
    "IT",
    "National"
  ];
  bool isLoading = true;
  getNewsByQuery(String query)async{
    String url="https://newsapi.org/v2/everything?q=$query&from=2023-10-17&sortBy=publishedAt&apiKey=9a251a3f47b0465fab06f6b21a0d3f6b";
 Response response =await get(Uri.parse(url));
 Map data =jsonDecode(response.body);
 setState(() {
   data["articles"].forEach((element){
     NewsQueryModel newsQueryModel= NewsQueryModel();
     newsQueryModel=NewsQueryModel.fromMap(element);
     newsModelList.add(newsQueryModel);
     // setState(() {
     //   isLoading=false;
     // });
   });
 });

  }

  @override
  Widget build(BuildContext context) {
    final List items = [
      Colors.black,
      Colors.blue,
      Colors.amber,
      Colors.brown,
      Colors.cyanAccent
    ];

    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Color(0xff899884),
        title: Text(
          'News App',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: InkWell(
                onTap: () {},
                child: TextField(
                  controller: search,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15), // Adjusted padding
                    hintText: "Search",
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: Icon(Icons.search),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: NavBar.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Add your logic here
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Color(0xff899884),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          NavBar[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: CarouselSlider(
                items: items.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "images/1.jpg",
                                  fit: BoxFit.fill,
                                  height: double.infinity,
                                ),
                              ),
                              Positioned(
                                  left: 6,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.black12.withOpacity(0),
                                              Colors.black
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter)),
                                    child: Text(
                                      "News Headline Here",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "LATEST NEWS",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsModelList.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  newsModelList[index].newsImg,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                ),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0),
                                        Colors.black,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newsModelList[index].newsHead,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        newsModelList[index].newsDes,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 14),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor:  Color(0xff899884)),
                          onPressed: () {},
                          child: Text(
                            "Show more",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
