// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:elattar/screens/login.dart';
// import 'package:elattar/screens/moderators/home_moderators.dart';
import 'package:elattar/screens/moderators/prepare_group.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendTheOrder extends StatefulWidget {
  const SendTheOrder({Key? key,
    required this.salesId,
    required this.clientName,
    required this.clientGovernorate,
    required this.clientAddress,
    required this.clientNumber,
    required this.productUnits,
    required this.totalPriceProducts,
  }) : super(key: key);

  final String clientName;
  final String salesId;
  final String clientGovernorate;
  final String clientAddress;
  final String clientNumber;
  final int productUnits;
  final int totalPriceProducts;
  static String id = 'SendTheOrder';

  @override
  State<SendTheOrder> createState() => _SendTheOrderState();
}

class _SendTheOrderState extends State<SendTheOrder> {

  late String moderatorsName = '';

  ver() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot infoModerators = await FirebaseFirestore.instance.collection('Moderators').doc(user!.uid).get();
    setState(() {
      moderatorsName= infoModerators['name'];
    });
  }

  @override
  void initState() {
    ver();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    // double mediaQueryHeight = MediaQuery.of(context).size.height;
    // User? user = FirebaseAuth.instance.currentUser;
    var refFireStore = FirebaseFirestore.instance
        .collection('Sales').doc(widget.salesId)
        .collection('ClientProducts');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إرسال الطلبيه',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 5,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: ()
            async {
              showLoading(context);
              await FirebaseFirestore.instance
                  .collection('Sales').doc(widget.salesId).update({
                'preparation' : 'false',
                'waiting' : 'true',
              });
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              },
            icon: const Icon(
              Icons.send_time_extension,
              // size: 30,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PrepareGroup(
                      salesId: widget.salesId,
                      productUnits: widget.productUnits,
                      totalPriceProducts: widget.totalPriceProducts,
                    )
                )
            );
          },
          icon: const Icon(
            Icons.add,
            // color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
              stream: refFireStore.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {return const Center(child: Text('Something went wrong'));}
                if (snapshot.connectionState == ConnectionState.waiting) {return const Center(child: Text("Loading"));}
                return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 2,
                    ),
                    itemBuilder: (context, i) {
                      String productsCode = snapshot.data!.docs[i]['productsCode'];
                      String productsName = snapshot.data!.docs[i]['productsName'];
                      String productsSize = snapshot.data!.docs[i]['productsSize'];
                      String productsColor = snapshot.data!.docs[i]['productsColor'];
                      int productsPrice = snapshot.data!.docs[i]['productsPrice'];
                      int newPriceProduct = snapshot.data!.docs[i]['newPriceProduct'];
                      int totalProducts = snapshot.data!.docs[i]['totalProducts'];
                      int totalPrice = snapshot.data!.docs[i]['totalPrice'];
                      return Column(
                        children: <Widget>[
                          const Divider(thickness: 2,color: Colors.lightBlueAccent,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: mediaQueryWidth * .95,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        InkWell(
                                          // onTap: onTap,
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                AutoSizeText(
                                                  ' $productsCode || $productsName',
                                                  textDirection: TextDirection.rtl,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  ),
                                                  minFontSize: 10,
                                                  maxLines: 3,
                                                ),
                                                AutoSizeText(
                                                  '$productsSize || $productsColor',
                                                  textDirection: TextDirection.rtl,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  ),
                                                  minFontSize: 10,
                                                  maxLines: 3,
                                                ),
                                                AutoSizeText(
                                                  '{Old=$productsPrice\$} _ {New=$newPriceProduct\$}',
                                                  textDirection: TextDirection.rtl,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  ),
                                                  minFontSize: 10,
                                                  maxLines: 3,
                                                ),
                                                AutoSizeText(
                                                  '{Total=$totalProducts}',
                                                  textDirection: TextDirection.rtl,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  ),
                                                  minFontSize: 10,
                                                  maxLines: 3,
                                                ),
                                              ]
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(' إجمالي السعر: $totalPrice'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                );
              }
              ),
    );
  }
  showLoading(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              title: Text('أنتظر قليلاً'),
              content: SizedBox(
                  height: 50,
                  child: Center(
                      child: CircularProgressIndicator()
                  )
              )
          );
        }
    );
  }
}
