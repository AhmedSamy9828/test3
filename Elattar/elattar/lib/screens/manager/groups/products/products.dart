import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:elattar/screens/manager/groups/modify_groups.dart';
import 'package:elattar/screens/manager/groups/products/add_products.dart';
import 'package:elattar/screens/manager/groups/products/modify_a_products.dart';
// import 'package:elattar/screens/manager/suppliers/modify_a_product.dart';
// import 'package:elattar/screens/manager/suppliers/add_product.dart';
// import 'package:elattar/screens/manager/suppliers/modify_group.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({Key? key,
    required this.groupsId,
    required this.groupsCode,
    required this.groupsName,
    required this.groupsSection,
    required this.groupsBrunch,
    required this.quantityOfProductsInGroups,
    required this.dateOfArrivalGroup,

  }) : super(key: key);
  static String id = 'Products';

  final String groupsId;
  final String groupsCode;
  final String groupsName;
  final String groupsSection;
  final String groupsBrunch;
  final int quantityOfProductsInGroups;
  final String dateOfArrivalGroup;


  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    var refFireStore = FirebaseFirestore.instance.collection('Groups').doc(widget.groupsId).collection('Products');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المنتجات',
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
        leading: IconButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddProducts(
                      groupsId: widget.groupsId,
                      groupsName: widget.groupsName,
                      quantityOfProductsInGroups: widget.quantityOfProductsInGroups,
                      dateOfArrivalGroup: widget.dateOfArrivalGroup,
                    )
                )
            );
          },
          icon: const Icon(
            Icons.add_shopping_cart,
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: ()
        //     {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => ModifyGroups(
        //                 groupsId: widget.groupsId,
        //                 groupsCode: widget.groupsCode,
        //                 groupsName: widget.groupsName,
        //                 groupsSection: widget.groupsSection,
        //                 groupsBrunch: widget.groupsBrunch,
        //                 quantityOfProductsInGroups: widget.quantityOfProductsInGroups,
        //                 dateOfArrivalGroup: widget.dateOfArrivalGroup,
        //               )
        //           )
        //       );
        //     },
        //     icon: const Icon(
        //       Icons.edit_note,
        //       // size: 30,
        //     ),
        //   ),
        // ],
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
                  String productsId = snapshot.data!.docs[i].id;
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
                                        builder: (context) => ModifyAProducts(
                                          productsId: productsId,
                                          productsCode: productsCode,
                                          productsName: productsName,
                                          productsSize: productsSize,
                                          productsColor: productsColor,
                                          quantityOfProducts: quantityOfProducts,
                                          productsPrice: productsPrice,
                                          groupsId: widget.groupsId,
                                          groupsName: widget.groupsName,
                                          quantityOfProductsInGroups: widget.quantityOfProductsInGroups,
                                          dateOfArrivalGroup: widget.dateOfArrivalGroup,
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
                  //         double localWidth = constrains.maxWidth;
                  //         return InkWell(
                  //           child: Row(
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
                  //                 builder: (context) => ModifyAProducts(
                  //                   productsId: productsId,
                  //                   productsCode: productsCode,
                  //                   productsName: productsName,
                  //                   productsSize: productsSize,
                  //                   productsColor: productsColor,
                  //                   quantityOfProducts: quantityOfProducts,
                  //                   productsPrice: productsPrice,
                  //                   groupsId: widget.groupsId,
                  //                   groupsName: widget.groupsName,
                  //                   quantityOfProductsInGroups: widget.quantityOfProductsInGroups,
                  //                   dateOfArrivalGroup: widget.dateOfArrivalGroup,
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
