import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elattar/pdf/api/api_pdf.dart';
import 'package:elattar/pdf/model/boll.dart';
import 'package:elattar/screens/manager/returns/product_choose.dart';
import 'package:elattar/screens/manager/sales/test_pdf.dart';
import 'package:flutter/material.dart';

class Check extends StatefulWidget {
  const Check({Key? key,
    required this.clientName,
    required this.clientGovernorate,
    required this.clientAddress,
    required this.clientNumber,
    required this.orderDate,
    required this.dateRegistration,
    required this.status,
    required this.notice,
    required this.invoiceNumber,
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
  // ignore: prefer_typing_uninitialized_variables
  final  dateRegistration;
  final String status;
  final String notice;
  final String invoiceNumber;
  final String factory;
  final String address;
  final String number1;
  final String number2;

  final String salesId;
  final String moderatorName;
  final String moderatorId;
  final int productUnits;
  final int totalPriceProducts;

  static String id = 'Check';

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {

  @override
  void initState() {
    super.initState();
    // PdfInvoiceApi.initA();
    // PdfBillApi.initA();
    TestPdf.initA();
  }

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    var refFireStore = FirebaseFirestore.instance
        .collection('Sales').doc(widget.salesId)
        .collection('ClientProducts');
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
        actions: [
          // IconButton(
          //   onPressed: ()
          //   async {
          //     showLoading(context);
          //
          //     await FirebaseFirestore.instance
          //         .collection('Sales').doc(widget.salesId).update({
          //       'sold' : 'false',
          //       'throwback' : 'true',
          //     });
          //      /// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          //     // await FirebaseFirestore.instance.collection('Sales')
          //     //     .doc(widget.salesId)
          //     //     .collection('ClientProducts').get()
          //     //     .then((QuerySnapshot querySnapshot) async {
          //     //   // ignore: avoid_function_literals_in_foreach_calls
          //     //   querySnapshot.docs.forEach((element) async {
          //     //     await FirebaseFirestore.instance.collection('Sales').doc(widget.salesId)
          //     //         .collection('ClientProducts').doc(element.id).get()
          //     //         .then((value) async {
          //     //       DocumentSnapshot asd = await FirebaseFirestore.instance
          //     //           .collection('Groups').doc(value['groupId'])
          //     //           .collection('Products').doc(value['productId']).get();
          //     //
          //     //       if (asd.data() != null) {
          //     //         DocumentSnapshot qwe = await FirebaseFirestore.instance
          //     //             .collection('Groups').doc(value['groupId']).get();
          //     //         int quantityOfProducts = await asd['quantityOfProducts'];
          //     //         int quantityOfProductsInGroups = await qwe['quantityOfProductsInGroups'];
          //     //         await FirebaseFirestore.instance
          //     //             .collection('Groups').doc(value['groupId'])
          //     //             .collection('Products').doc(value['productId']).update({
          //     //           'quantityOfProducts' : quantityOfProducts + value['totalProducts'],
          //     //         });
          //     //         await FirebaseFirestore.instance
          //     //             .collection('Groups').doc(value['groupId']).update({
          //     //           'quantityOfProductsInGroups' :  quantityOfProductsInGroups + value['totalProducts'] ,
          //     //         });
          //     //       }
          //     //       if (asd.data() == null) {
          //     //         var qwe = await FirebaseFirestore.instance
          //     //             .collection('Groups').doc(value['groupId']).get();
          //     //         if (qwe.data() != null) {
          //     //           await FirebaseFirestore.instance
          //     //               .collection('Groups').doc(value['groupId'])
          //     //               .collection('Products').doc(value['productId']).set({
          //     //             'groupsId' : value['groupId'],
          //     //             'dateOfArrivalGroup' : value['dateOfArrivalGroup'],
          //     //
          //     //             'productsCode' : value['productsCode'],
          //     //             'productsName' : value['productsName'],
          //     //             'productsSize' : value['productsSize'],
          //     //             'productsColor' : value['productsColor'],
          //     //             'quantityOfProducts' : value['totalProducts'],
          //     //             'productsPrice' : value['productsPrice'],
          //     //           });
          //     //           await FirebaseFirestore.instance
          //     //               .collection('Groups').doc(value['groupId']).update({
          //     //             'quantityOfProductsInGroups' : qwe['quantityOfProductsInGroups'] + value['totalProducts'],
          //     //           });
          //     //         }
          //     //         if (qwe.data() == null) {
          //     //           await FirebaseFirestore.instance
          //     //               .collection('Groups').doc(value['groupId']).set({
          //     //             'groupsCode' : value['groupsCode'],
          //     //             'groupsName' : value['groupsName'],
          //     //             'groupsSection' : value['groupsSection'],
          //     //             'groupsBrunch' : value['groupsBrunch'],
          //     //             'quantityOfProductsInGroups' : value['quantityOfProductsInGroups'],
          //     //             'dateOfArrivalGroup' : value['dateOfArrivalGroup'],
          //     //           });
          //     //           await FirebaseFirestore.instance
          //     //               .collection('Groups').doc(value['groupId'])
          //     //               .collection('Products').doc(value['productId']).set({
          //     //             'groupsId' : value['groupId'],
          //     //             'dateOfArrivalGroup' : value['dateOfArrivalGroup'],
          //     //
          //     //             'productsCode' : value['productsCode'],
          //     //             'productsName' : value['productsName'],
          //     //             'productsSize' : value['productsSize'],
          //     //             'productsColor' : value['productsColor'],
          //     //             'quantityOfProducts' : value['totalProducts'],
          //     //             'productsPrice' : value['productsPrice'],
          //     //           });
          //     //         }
          //     //       }
          //     //     });
          //     //   });
          //     // });
          //
          //     /// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          //     // ignore: use_build_context_synchronously
          //     Navigator.of(context).pop();Navigator.of(context).pop();
          //   },
          //   icon: const Icon(
          //       Icons.settings_backup_restore,
          //     // size: 30,
          //   ),
          // ),
          IconButton(
            onPressed: ()
            async {
              showLoading(context);
              ///  delete collection  ###########################
              var ref = FirebaseFirestore.instance.collection('Sales').doc(widget.salesId).collection('ClientProducts');
              var snap = await ref.get();
              for ( var doc in snap.docs ){await doc.reference.delete();}
              await FirebaseFirestore.instance.collection('Sales').doc(widget.salesId).delete();
              /// #####################################
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();Navigator.of(context).pop();
              },
            icon: const Icon(
              Icons.delete_forever,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () async {
            List<List<dynamic>> xc = [];
            FirebaseFirestore.instance.collection('Sales').doc(widget.salesId)
                .collection('ClientProducts').get()
                .then((QuerySnapshot querySnapshot) async {
              // ignore: avoid_function_literals_in_foreach_calls
              querySnapshot.docs.forEach((element) async {
                xc.add(
                    [
                      element['totalPrice'],
                      // element['productsPrice'],
                      element['newPriceProduct'],
                      element['totalProducts'],
                      element['productsName'],
                      element['productsCode'],
                    ]
                );
              });
              final pdfFile = await TestPdf.generatePdf(
                  Boll(
                      asd: xc,
                      info: BollInfo(
                        moderatorName: widget.moderatorName,
                        clientName: widget.clientName,
                        clientGovernorate: widget.clientGovernorate,
                        clientAddress: widget.clientAddress,
                        clientNumber: widget.clientNumber,
                        orderDate: widget.orderDate,
                        invoiceNumber: widget.invoiceNumber,
                        productUnits: widget.productUnits,
                        totalPriceProducts: widget.totalPriceProducts,
                        factory: widget.factory,
                        address: widget.address,
                        number1: widget.number1,
                        number2: widget.number2,
                      )
                  )
              );
              ApiPdf.openFile(pdfFile);
            });
          },
          icon: const Icon(
            Icons.print,
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
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ProductChoose(
                                                  salesId: widget.salesId,

                                                  moderatorName: widget.moderatorName,
                                                  moderatorId: widget.moderatorId,

                                                  clientName: widget.clientName,
                                                  clientGovernorate: widget.clientGovernorate,
                                                  clientAddress: widget.clientAddress,
                                                  clientNumber: widget.clientNumber,
                                                  orderDate: widget.orderDate,

                                                  clientProductsId: snapshot.data!.docs[i].id,

                                                  groupId: snapshot.data!.docs[i]['groupId'],
                                                  groupsName: snapshot.data!.docs[i]['groupsName'],
                                                  groupsCode: snapshot.data!.docs[i]['groupsCode'],
                                                  groupsSection: snapshot.data!.docs[i]['groupsSection'],
                                                  groupsBrunch: snapshot.data!.docs[i]['groupsBrunch'],
                                                  quantityOfProductsInGroups: snapshot.data!.docs[i]['quantityOfProductsInGroups'],
                                                  dateOfArrivalGroup: snapshot.data!.docs[i]['dateOfArrivalGroup'],

                                                  productId: snapshot.data!.docs[i]['productId'],
                                                  productsCode: snapshot.data!.docs[i]['productsCode'],
                                                  productsName: snapshot.data!.docs[i]['productsName'],
                                                  productsSize: snapshot.data!.docs[i]['productsSize'],
                                                  productsColor: snapshot.data!.docs[i]['productsColor'],
                                                  totalProducts: snapshot.data!.docs[i]['totalProducts'],
                                                  productsPrice: snapshot.data!.docs[i]['productsPrice'],
                                                  newPriceProduct: snapshot.data!.docs[i]['newPriceProduct'],

                                                  dateRegistration: widget.dateRegistration,
                                                  status: widget.status,
                                                  notice: widget.notice,
                                                  invoiceNumber: widget.invoiceNumber,
                                                )
                                            )
                                        );
                                      },
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
