// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';


class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/solarinfo.jpg"),
                fit: BoxFit.cover,
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.chevron_left),color: Colors.white70,
                  iconSize: 40)
                ],),
               Container(
               height: 400,
                decoration: const BoxDecoration(
                 borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(40),
                   topRight: Radius.circular(40),
                 ),
                  color: Color(0xff0B1329),
                ),
                child: ListView(
                 children: [
                  const Padding(
                    padding: EdgeInsets.only(left:20, top: 40),
                      child: 
                      Text("How does Shine works?",
                        style: TextStyle(
                         fontSize: 24,
                         color: Colors.white,
                         fontWeight: FontWeight.bold)),
                     ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left:20, right: 25),
                      child: 
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
                        style: TextStyle(
                         fontSize: 15,
                         color: Colors.white70,
                     )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                     left: 20, right: 25, bottom: 20, top: 30
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Examples', style: TextStyle(fontSize: 18, color: Colors.white,)),
                        Text('69', style: TextStyle(fontSize: 17, color: Colors.white38,))
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left:20, right: 25),
                      child: 
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries. Hi Yoyoyoyo",
                        style: TextStyle(
                         fontSize: 15,
                         color: Colors.white70,
                     )),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left:20, right: 25),
                      child: 
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries. Hi Yoyoyoyo",
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
        ],
      )
    );
  }
}