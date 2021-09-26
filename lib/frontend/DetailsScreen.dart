// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final MediaQueryData padding = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 30,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: const Color(0xff0B1329),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
                child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                        image: AssetImage("assets/images/solarinfo.jpg"),
                        fit: BoxFit.fill),
                    color: const Color.fromRGBO(0, 20, 58, 100),
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: const SafeArea(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff0B1329),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 10, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // height: 400,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text("How does Shine works?",
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.only(left: 20, right: 25),
                                child: Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white70,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 25, bottom: 20, top: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('Examples',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        )),
                                    Text('69',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white38,
                                        ))
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 20, right: 25),
                                child: Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not. Hi Yoyoyoyo",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white70,
                                    )),
                              ),
                              const SizedBox(height: 20),
                              const Padding(
                                padding: EdgeInsets.only(left: 20, right: 25),
                                child: Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries. Hi Yoyoyoyo",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white70,
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ))));
  }
}
