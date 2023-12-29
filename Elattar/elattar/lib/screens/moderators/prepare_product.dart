import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elattar/screens/moderators/product_selection.dart';
import 'package:flutter/material.dart';

class PrepareProduct extends StatefulWidget {
  const PrepareProduct({Key? key,
    required this.salesId,
    required this.productUnits,
    required this.totalPriceProducts,

    required this.groupId,
    required this.groupsCode,
    required this.groupsName,
    required this.groupsSection,
    required this.groupsBrunch,
    required this.quantityOfProductsInGroups,
    required this.dateOfArrivalGroup,
  }) : super(key: key);

  final String salesId;
  final int productUnits;
  final int totalPriceProducts;

  final String groupId;
  final String groupsCode;
  final String groupsName;
  final String groupsSection;
  final String groupsBrunch;
  final int quantityOfProductsInGroups;
  final String dateOfArrivalGroup;

  static String id = 'PrepareProduct';

  @override
  State<PrepareProduct> createState() => _PrepareProductState();
}

class _PrepareProductState extends State<PrepareProduct> {
  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    var refFireStore = FirebaseFirestore.instance
        .collection('Groups').doc(widget.groupId)
        .collection('Products');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تحديد منتج',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 40,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 5,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: refFireStore.orderBy('productsCode',)
          // .orderBy('date', descending: true)
              .snapshots(),
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
                  String productId = snapshot.data!.docs[i].id;
                  String productsCode = snapshot.data!.docs[i]['productsCode'];
                  String productsName = snapshot.data!.docs[i]['productsName'];
                  String productsSize = snapshot.data!.docs[i]['productsSize'];
                  String productsColor = snapshot.data!.docs[i]['productsColor'];
                  int quantityOfProducts = snapshot.data!.docs[i]['quantityOfProducts'];
                  int productsPrice = snapshot.data!.docs[i]['productsPrice'];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 180,
                        width: mediaQueryWidth * .95,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: SingleChildScrollView(
                              // child:
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: <Widget>[
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context, MaterialPageRoute(
                                      builder: (context) => ProductSelection(
                                        salesId: widget.salesId,
                                        productUnits: widget.productUnits,
                                        totalPriceProducts: widget.totalPriceProducts,

                                        groupId: widget.groupId,
                                        groupsName: widget.groupsName,
                                        groupsCode: widget.groupsCode,
                                        groupsSection: widget.groupsSection,
                                        groupsBrunch: widget.groupsBrunch,
                                        quantityOfProductsInGroups: widget.quantityOfProductsInGroups,
                                        dateOfArrivalGroup: widget.dateOfArrivalGroup,

                                        productId: productId,
                                        productsCode: productsCode,
                                        productsName: productsName,
                                        productsSize: productsSize,
                                        productsColor: productsColor,
                                        quantityOfProducts: quantityOfProducts,
                                        productsPrice: productsPrice,
                                      )
                                  )
                                  );
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      AutoSizeText(
                                        productsCode,
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
                                        productsName,
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
                                        '$productsSize -  $productsColor ',
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
                                        'جم$productsPrice || { $quantityOfProducts }',
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
                              //       onTap: (){
                              //         // Navigator.push(
                              //         //     context,
                              //         //     MaterialPageRoute(
                              //         //         builder: (context) => ModifyGroups(
                              //         //           groupsId: groupsId,
                              //         //           groupsCode: groupsCode,
                              //         //           groupsName: groupsName,
                              //         //           groupsSection: groupsSection,
                              //         //           groupsBrunch: groupsBrunch,
                              //         //           quantityOfProductsInGroups: quantityOfProductsInGroups,
                              //         //           dateOfArrivalGroup: dateOfArrivalGroup,
                              //         //         )
                              //         //     )
                              //         // );
                              //       },
                              //       child: const Icon(Icons.edit,),
                              //     ),
                              //   ],
                              // ),
                              // ],
                            ),
                            // ),
                            // ),
                          ),
                        ),
                      ),
                    ],
                    // ),
                  );
                  //   Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5,),
                  //   child: LayoutBuilder(
                  //       builder: (context, constrains) {
                  //         double localHeight = constrains.maxHeight;
                  //         // double localWidth = constrains.maxWidth;
                  //         return InkWell(
                  //           child: Column(
                  //             children: <Widget>[
                  //               SizedBox(
                  //                 height: localHeight * .1,
                  //                 child: AutoSizeText(
                  //                   productsName,
                  //                   style: const TextStyle(
                  //                     fontSize: 25,
                  //                     color: Colors.black,
                  //                   ),
                  //                   minFontSize: 7,
                  //                   maxLines: 1,
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 height: localHeight * .1,
                  //                 child: AutoSizeText(
                  //                   'جم$productsPrice || { $quantityOfProducts }',
                  //                   style: const TextStyle(
                  //                     fontSize: 20,
                  //                     color: Colors.black,
                  //                   ),
                  //                   minFontSize: 7,
                  //                   maxLines: 1,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           onTap: () {
                  //             Navigator.push(
                  //                 context, MaterialPageRoute(
                  //                 builder: (context) => ProductSelection(
                  //                   salesId: widget.salesId,
                  //                   productUnits: widget.productUnits,
                  //                   totalPriceProducts: widget.totalPriceProducts,
                  //
                  //                   groupId: widget.groupId,
                  //                   groupsName: widget.groupsName,
                  //                   groupsCode: widget.groupsCode,
                  //                   groupsSection: widget.groupsSection,
                  //                   groupsBrunch: widget.groupsBrunch,
                  //                   quantityOfProductsInGroups: widget.quantityOfProductsInGroups,
                  //                   dateOfArrivalGroup: widget.dateOfArrivalGroup,
                  //
                  //                   productId: productId,
                  //                   productsCode: productsCode,
                  //                   productsName: productsName,
                  //                   productsSize: productsSize,
                  //                   productsColor: productsColor,
                  //                   quantityOfProducts: quantityOfProducts,
                  //                   productsPrice: productsPrice,
                  //                 )
                  //             )
                  //             );
                  //           },
                  //         );
                  //       }
                  //   ),
                  // );
                }
            );
          }
      ),
    );
  }
}
