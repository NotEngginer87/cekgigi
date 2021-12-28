import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class keuntungancard extends StatelessWidget {
  keuntungancard(this.judul, this.imgurl, this.deskripsi);

  final String? judul;
  final String? imgurl;
  final String? deskripsi;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 10,
      child: Container(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 4),
              child: SizedBox(
                child: Text(
                  judul!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pathwayGothicOne(
                      fontWeight: FontWeight.w500, fontSize: 24),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              height: MediaQuery.of(context).size.width - 90,
              child: Column(
                children: [
                  Expanded(
                    child: Ink.image(
                      image: NetworkImage(imgurl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                child: SizedBox(
                  child: Text(
                    deskripsi!,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class keuntunganmenggunakanaplikasi extends StatelessWidget {
  const keuntunganmenggunakanaplikasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference cardimg = firestore.collection('card');

    Widget buildkeuntunganCard(String? imgurl) => Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Ink.image(
                image: NetworkImage(
                  imgurl!,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return keuntunganmenggunakanaplikasi();
                    }));
                  },
                ),
                height: 180,
                width: 120,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        );

    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20,top: 20, bottom: 20),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              StreamBuilder<DocumentSnapshot>(
                stream: cardimg.doc('keuntungan').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                    var imgurl = data['imgurl'];

                    return buildkeuntunganCard(
                      imgurl,
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: cardimg.doc('cara').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                    var imgurl = data['imgurl'];

                    return Container(); //buildHelpCard(imgurl);
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ])));
  }
}
