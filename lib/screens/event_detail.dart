import 'package:flutter/material.dart';

class EventDetail extends StatelessWidget {

  final String title;
  final String imgUrl;
  final bool isFav;
  final String dateTime;
  final String loc;
  const EventDetail({this.title='no-title', this.isFav=false, this.imgUrl='', this.dateTime='', this.loc='', Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text(title, style: const TextStyle(color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87) ,
        backgroundColor:Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
            Icons.favorite,
            color: isFav ? Colors.red : Colors.grey,
            size: 22.0,
        ),
          )],
        ),
      body:  Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height/2,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius:
                    BorderRadius.circular(7),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            imgUrl)))),
            const SizedBox(
              height: 8,
            ),
            Text(
              dateTime,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              loc,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38),
            ),
          ],
        ),
      ),
    );
  }
}
