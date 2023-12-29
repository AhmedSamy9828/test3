import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowCheck extends StatefulWidget {
  const ShowCheck({Key? key,
    required this.clientName,
    required this.clientGovernorate,
    required this.clientAddress,
    required this.clientNumber,
    required this.orderDate,
    required this.factory,
    required this.address,
    required this.number1,
    required this.number2,

    required this.salesId,
    required this.moderatorName,
    required this.moderatorId,
    required this.productUnits,
    required this.totalPriceProducts,

  }) : super(key: key);

  final String clientName;
  final String clientGovernorate;
  final String clientAddress;
  final String clientNumber;
  final String orderDate;
  final String factory;
  final String address;
  final String number1;
  final String number2;

  final String salesId;
  final String moderatorName;
  final String moderatorId;
  final int productUnits;
  final int totalPriceProducts;

  static String id = 'ShowCheck';

  @override
  State<ShowCheck> createState() => _ShowCheckState();
}

class _ShowCheckState extends State<ShowCheck> {

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    var refFireStore = FirebaseFirestore.instance
        .collection('Sales').doc(widget.salesId).collection('ClientProducts');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.totalPriceProducts}',
          style: const TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Colors.blue,
        elevation: 5,
        automaticallyImplyLeading: false,
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
                  return
                    // Column(
                    // children: <Widget>[
                    //   const Divider(thickness: 2,color: Colors.lightBlueAccent,),
                    SingleChildScrollView(
                      child: Row(
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
                                              '${snapshot.data!.docs[i]['productsCode']}||${snapshot.data!.docs[i]['productsName']}',
                                              // snapshot.data!.docs[i]['productName'],
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
                                              '${snapshot.data!.docs[i]['productsSize']}||${snapshot.data!.docs[i]['productsColor']}',
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                              ),
                                              minFontSize: 10,
                                              maxLines: 3,
                                            ),
                                            // AutoSizeText(
                                            //   '${snapshot.data!.docs[i]['productsPrice']} {${snapshot.data!.docs[i]['totalProducts']}}',
                                            //   textDirection: TextDirection.rtl,
                                            //   textAlign: TextAlign.start,
                                            //   style: const TextStyle(
                                            //     fontSize: 20,
                                            //     color: Colors.black,
                                            //   ),
                                            //   minFontSize: 10,
                                            //   maxLines: 3,
                                            // ),
                                            AutoSizeText(
                                              // '${snapshot.data!.docs[i]['productsPrice']} {${snapshot.data!.docs[i]['totalProducts']}}',
                                              '{Old=${snapshot.data!.docs[i]['productsPrice']}\$} _ {New=${snapshot.data!.docs[i]['newPriceProduct']}\$}',
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
                                              // '${snapshot.data!.docs[i]['productsPrice']} {${snapshot.data!.docs[i]['totalProducts']}}',
                                              '{Total=${snapshot.data!.docs[i]['totalProducts']}}',
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
                                        Text(' إجمالي السعر: ${snapshot.data!.docs[i]['totalPrice']}'),
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
                    );

                    // ],
                  // );
                }
            );
          }
      ),
    );
  }
  widgetInkWell({name, address, number, onTap, onTapEdite, price, priceA}){
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          // height: 200,
          width: mediaQueryWidth * .95,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: onTap,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AutoSizeText(
                            name,
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
                            address,
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
                            number,
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
                            price,
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
                            priceA,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: <Widget>[
                  //     InkWell(
                  //       onTap: onTapEdite,
                  //       child: const Icon(Icons.edit,),
                  //     ),
                  //
                  //   ],
                  // ),

                ],
              ),
              // ),
            ),
          ),
        ),
      ],
    );

  }
  MaterialStateProperty<Color> getColor(Color color, Color colorPressed){
    getColor(Set<MaterialState> state){
      if(state.contains(MaterialState.pressed)){
        return colorPressed;
      } else {
        return color;
      }
    }
    return MaterialStateProperty.resolveWith(getColor);
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
