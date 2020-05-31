import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {

  fetchData()async{
    final url = "http://192.168.43.100:3000/api/quotes";
    var res = await http.get(url);
    return jsonDecode(res.body)["quotes"];
  }


  @override
  Widget build(BuildContext context) {
    final colors =[
      Vx.gray800,
      Vx.red800,
      Vx.blue800,
      Vx.green800,
      Vx.teal800,
      Vx.purple800,
      Vx.pink800,
      Vx.orange800,
    ];
    return Material(
      child: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            if(snapshot.hasData){
              return StatefulBuilder(
                builder:(context, setState) {
                  final color = colors[Random().nextInt(8)];
                  return VxSwiper(
                      scrollDirection: Axis.vertical,
                      height: context.screenHeight,
                      viewportFraction: 1.0,
                      onPageChanged: (index){
                        setState((){});
                      },
                      items: snapshot.data.map<Widget>(
                  (el) =>VStack(
                      ["QuotesX".text.white.xl4.bold.make(),
                      "${el["quoteText"]}".text.white.italic.bold.xl3.make().shimmer().box.shadow2xl.make(),
                      IconButton(
                        icon: Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 30,
                      ),
                          onPressed: (){
                              Share.share("${el["quoteText"]}");
                          })
                    ],
                          crossAlignment: CrossAxisAlignment.center,
                          alignment: MainAxisAlignment.spaceAround,
                          ).animatedBox.p16.color(color).make().h(context.screenHeight),
                      )
                          .toList());
                }
              );
            }

            return "Nothing found.".text.makeCentered();
          }else if(snapshot.connectionState==ConnectionState.none){
            return "Something went wrong".text.makeCentered();
          }
          return CircularProgressIndicator().centered();
        },
      )
    );
  }
}