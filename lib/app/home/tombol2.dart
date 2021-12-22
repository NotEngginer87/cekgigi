import 'package:flutter/material.dart';

import 'package:line_icons/line_icons.dart';

class tomboltombol extends StatefulWidget {
  const tomboltombol({Key? key}) : super(key: key);

  @override
  _tomboltombolState createState() => _tomboltombolState();
}

class _tomboltombolState extends State<tomboltombol> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.width / 5,
                child: Icon(
                  LineIcons.doctor,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text('riwayat'),
            ],
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.width / 5,
                child: Icon(
                  LineIcons.doctor,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text('konsultasi'),
            ],
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.width / 5,
                child: Icon(
                  LineIcons.doctor,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text('atur jadwal'),
            ],
          ),
        ],
      ),
    );
  }
}
