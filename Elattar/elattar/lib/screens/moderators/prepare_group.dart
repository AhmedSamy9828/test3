import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elattar/screens/moderators/prepare_product.dart';
import 'package:flutter/material.dart';

class PrepareGroup extends StatefulWidget {
  const PrepareGroup({Key? key,
    required this.salesId,
    required this.productUnits,
    required this.totalPriceProducts,
  }) : super(key: key);

  final String salesId;
  final int productUnits;
  final int totalPriceProducts;

  static String id = 'PrepareGroup';

  @override
  State<PrepareGroup> createState() => _PrepareGroupState();
}

class _PrepareGroupState extends State<PrepareGroup> {
  @override
  Widget build(BuildContext context) {
    var refFireStore = FirebaseFirestore.instance.collection('Groups');
    // var asd = MediaQuery.of(context).size.width;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تحديد الاصناف',
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
          stream: refFireStore.orderBy('groupsCode',)
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
                  String groupId = snapshot.data!.docs[i].id;
                  String groupsCode = snapshot.data!.docs[i]['groupsCode'];
                  String groupsName = snapshot.data!.docs[i]['groupsName'];
                  String groupsSection = snapshot.data!.docs[i]['groupsSection'];
                  String groupsBrunch = snapshot.data!.docs[i]['groupsBrunch'];
                  int quantityOfProductsInGroups = snapshot.data!.docs[i]['quantityOfProductsInGroups'];
                  String dateOfArrivalGroup = snapshot.data!.docs[i]['dateOfArrivalGroup'];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 200,
                        width: mediaQueryWidth * .95,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            // child: SingleChildScrollView(
                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PrepareProduct(
                                              salesId: widget.salesId,
                                              groupId: groupId,
                                              groupsCode: groupsCode,
                                              groupsName: groupsName,
                                              groupsSection: groupsSection,
                                              groupsBrunch: groupsBrunch,
                                              quantityOfProductsInGroups: quantityOfProductsInGroups,
                                              dateOfArrivalGroup: dateOfArrivalGroup,
                                              productUnits: widget.productUnits,
                                              totalPriceProducts: widget.totalPriceProducts,
                                            )
                                        )
                                    );
                                  },
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        AutoSizeText(
                                          snapshot.data!.docs[i]['groupsCode'],
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
                                          snapshot.data!.docs[i]['groupsName'],
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
                                          '$groupsSection || $groupsBrunch ',
                                          // snapshot.data!.docs[i]['groupsSection'],
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
                                          ('${snapshot.data!.docs[i]['quantityOfProductsInGroups']}'),
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
                                //         Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //                 builder: (context) => ModifyGroups(
                                //                   groupsId: groupsId,
                                //                   groupsCode: groupsCode,
                                //                   groupsName: groupsName,
                                //                   groupsSection: groupsSection,
                                //                   groupsBrunch: groupsBrunch,
                                //                   quantityOfProductsInGroups: quantityOfProductsInGroups,
                                //                   dateOfArrivalGroup: dateOfArrivalGroup,
                                //                 )
                                //             )
                                //         );
                                //       },
                                //       child: const Icon(Icons.edit,),
                                //     ),
                                //   ],
                                // ),
                              ],
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
                  //   padding: EdgeInsets.only(
                  //     left: asd * .01,
                  //     right: asd * .01,
                  //     top: 20,
                  //   ),
                  //   child: InkWell(
                  //     onTap: (){
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => PrepareProduct(
                  //                 salesId: widget.salesId,
                  //                 groupId: groupId,
                  //                 groupsCode: groupsCode,
                  //                 groupsName: groupsName,
                  //                 groupsSection: groupsSection,
                  //                 groupsBrunch: groupsBrunch,
                  //                 quantityOfProductsInGroups: quantityOfProductsInGroups,
                  //                 dateOfArrivalGroup: dateOfArrivalGroup,
                  //                 productUnits: widget.productUnits,
                  //                 totalPriceProducts: widget.totalPriceProducts,
                  //               )
                  //           )
                  //       );
                  //     },
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(35.0),
                  //         border: Border.all(
                  //           color: Colors.black,
                  //           width: 2,
                  //         ),
                  //       ),
                  //       child: Column(
                  //         children: [
                  //           Center(
                  //             child: AutoSizeText(
                  //               groupsName,
                  //               style: const TextStyle(
                  //                 fontSize: 15,
                  //                 color: Colors.black,
                  //               ),
                  //               minFontSize: 10,
                  //               maxLines: 2,
                  //             ),
                  //           ),
                  //           Center(
                  //             child: AutoSizeText(
                  //               groupsSection,
                  //               style: const TextStyle(
                  //                 fontSize: 10,
                  //                 color: Colors.black,
                  //               ),
                  //               minFontSize: 5,
                  //               maxLines: 2,
                  //             ),
                  //           ),
                  //           Center(
                  //             child: AutoSizeText(
                  //               '$quantityOfProductsInGroups',
                  //               style: const TextStyle(
                  //                 fontSize: 10,
                  //                 color: Colors.black,
                  //               ),
                  //               minFontSize: 5,
                  //               maxLines: 2,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // );
                }
            );
          }
      ),
    );
  }
}
