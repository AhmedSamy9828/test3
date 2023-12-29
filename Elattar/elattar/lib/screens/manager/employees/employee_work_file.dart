import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elattar/screens/manager/employees/show_check.dart';
import 'package:elattar/screens/manager/employees/show_throwback.dart';
import 'package:elattar/screens/manager/employees/table/employee_table_check.dart';
import 'package:elattar/screens/manager/employees/table/employee_table_throwback.dart';
import 'package:elattar/screens/manager/returns/info_bill_back.dart';
import 'package:elattar/screens/manager/sales/info_bille.dart';
import 'package:flutter/material.dart';

class EmployeeWorkFile extends StatefulWidget {
  const EmployeeWorkFile({Key? key,
    required this.moderatorId,
    }) : super(key: key);
  final String moderatorId;
  static String id = 'EmployeeWorkFile';

  @override
  State<EmployeeWorkFile> createState() => _EmployeeWorkFileState();
}

class _EmployeeWorkFileState extends State<EmployeeWorkFile> {

  late String factory = '';
  late String address = '';
  late String number1 = '';
  late String number2 = '';

  ver() async {
    DocumentSnapshot infoModerators = await FirebaseFirestore.instance
        .collection('Info').doc('zRFWZKNxdKtBKS8tKEfD').get();
    setState(() {
      factory= infoModerators['factory'];
      address= infoModerators['address'];
      number1= infoModerators['number1'];
      number2= infoModerators['number2'];
    });
  }

  num salesProductUnits = 0;
  num salesTotalPriceProducts = 0;
  num returnsProductUnits = 0;
  num returnsTotalPriceProducts = 0;
  calculate() async {
    await FirebaseFirestore.instance.collection('Sales')
        .where('moderatorId', isEqualTo: widget.moderatorId).where('sold', isEqualTo: "true")
        .get().then((QuerySnapshot querySnapshot)  {
      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach((element)  {
        setState((){salesProductUnits = salesProductUnits +  element['productUnits'];});
      });
    });
    await FirebaseFirestore.instance.collection('Sales')
        .where('moderatorId', isEqualTo: widget.moderatorId).where('sold', isEqualTo: "true")
        .get().then((QuerySnapshot querySnapshot)  {
      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach((element)  {
        setState((){salesTotalPriceProducts = salesTotalPriceProducts +  element['totalPriceProducts'];});
      });
    });
    await FirebaseFirestore.instance.collection('Returns')
        .where('moderatorId', isEqualTo: widget.moderatorId)
        .get().then((QuerySnapshot querySnapshot)  {
      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach((element)  {
        setState((){returnsProductUnits = returnsProductUnits +  element['productUnits'];});
      });
    });
    await FirebaseFirestore.instance.collection('Returns')
        .where('moderatorId', isEqualTo: widget.moderatorId)
        .get().then((QuerySnapshot querySnapshot)  {
      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach((element)  {
        setState((){returnsTotalPriceProducts = returnsTotalPriceProducts +  element['totalPriceProducts'];});
      });
    });
  }

  @override
  void initState() {
    ver();
    super.initState();
    calculate();
  }

  int tapBarIndex=0;
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'الفواتير',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
                  centerTitle: true,
                  // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  backgroundColor: Colors.blue,
                  elevation: 5,
                  // automaticallyImplyLeading: false,
                  bottom: TabBar(
                    indicatorColor: Colors.red,
                    onTap: (value)
                    {
                      setState(() {
                        tapBarIndex = value;
                      });
                    },
                    tabs: <Widget>[
                      Text(
                        'مبيعات'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'مرتجعات'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                drawer: Drawer(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: const Center( child: Text('تحليل الفواتير'),),
                        onTap: (){
                        },
                      ),
                      const Divider(
                        color: Colors.red,
                        height: 50,
                        thickness: 2,
                      ),
                      const Divider(
                        color: Colors.white,
                        height: 20,
                        thickness: 5,
                      ),
                      ListTile(
                        title: const Center(
                          child: Text('المبيعات',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EmployeeTableCheck(
                                        moderatorId : widget.moderatorId,
                                      )
                                  )
                              );
                        },
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '$salesProductUnits',
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(width: 10,),
                            const Text('الكميه',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        onTap: (){
                        },
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '$salesTotalPriceProducts',
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(width: 10,),
                            const Text('الإجمالي',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        onTap: (){
                        },
                      ),
                      const Divider(
                        color: Colors.white,
                        height: 20,
                        thickness: 5,
                      ),
                      ListTile(
                        title: const Center(
                          child: Text('المرتجعات',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmployeeTableThrowBack(
                                    moderatorId : widget.moderatorId,
                                  )
                              )
                          );
                        },
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '$returnsProductUnits',
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(width: 10,),
                            const Text('الكميه',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        onTap: (){
                        },
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '$returnsTotalPriceProducts',
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(width: 10,),
                            const Text('الإجمالي',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        onTap: (){
                        },
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    sold(),
                    returns(),
                  ],
                ),
              )
          )
        ]
    );
  }
  sold(){
    var refFireStore = FirebaseFirestore.instance.collection('Sales');
    return StreamBuilder<QuerySnapshot>(
        stream: refFireStore
            .where('sold', isEqualTo: 'true')
            .where('moderatorId', isEqualTo: widget.moderatorId)
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
                return SingleChildScrollView(
                  child: InkWell(
                    onTap: (){},
                    child:SizedBox(
                      height: 150,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              // onTap: tapWork,
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowCheck(
                                          salesId : snapshot.data!.docs[i].id,
                                          moderatorId : snapshot.data!.docs[i]['moderatorId'],
                                          moderatorName : snapshot.data!.docs[i]['moderatorName'],
                                          totalPriceProducts : snapshot.data!.docs[i]['totalPriceProducts'],
                                          productUnits : snapshot.data!.docs[i]['productUnits'],
                                          clientName: snapshot.data!.docs[i]['clientName'],
                                          clientGovernorate: snapshot.data!.docs[i]['clientGovernorate'],
                                          clientAddress: snapshot.data!.docs[i]['clientAddress'],
                                          clientNumber: snapshot.data!.docs[i]['clientNumber'],
                                          orderDate: snapshot.data!.docs[i]['orderDate'],
                                          factory: factory,
                                          address: address,
                                          number1: number1,
                                          number2: number2,
                                        )
                                    )
                                );
                              },
                              child: Column(
                                children: <Widget>[
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SizedBox(
                                      // height: 90,
                                      // width:  200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: AutoSizeText(
                                          '{${snapshot.data!.docs[i]['moderatorName']}}',
                                          // 'إسم',
                                          // name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SizedBox(
                                      // height: 90,
                                      // width:  200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: AutoSizeText(
                                          '-${snapshot.data!.docs[i]['clientName']}',
                                          // 'إسم',
                                          // name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SizedBox(
                                      // height: 90,
                                      // width:  200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: AutoSizeText(
                                          // '-${snapshot.data!.docs[i]['clientGovernorate']}=>${snapshot.data!.docs[i]['clientAddress']}',
                                          '-${snapshot.data!.docs[i]['clientGovernorate']}',
                                          // 'إسم',
                                          // name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SizedBox(
                                      // height: 90,
                                      // width:  200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: AutoSizeText(
                                          // '- ${snapshot.data!.docs[i]['clientNumber']} || ${snapshot.data!.docs[i]['orderDate']}',
                                          '${snapshot.data!.docs[i]['orderDate']}',
                                          // 'إسم',
                                          // name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: (){
                                          // print(snapshot.data!.docs[i]['dateRegistration'].toDate());
                                          // print((DateTime.tryParse(snapshot.data!.docs[i]['dateRegistration'].toDate().toString())).toString());
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => InfoBill(
                                                    invoiceNumber: snapshot.data!.docs[i]['invoiceNumber'],
                                                    moderatorName : snapshot.data!.docs[i]['moderatorName'],

                                                    clientName: snapshot.data!.docs[i]['clientName'],
                                                    clientGovernorate: snapshot.data!.docs[i]['clientGovernorate'],
                                                    clientAddress: snapshot.data!.docs[i]['clientAddress'],
                                                    clientNumber: snapshot.data!.docs[i]['clientNumber'],

                                                    dateRegistration: snapshot.data!.docs[i]['dateRegistration'],
                                                    orderDate: snapshot.data!.docs[i]['orderDate'],
                                                    notice: snapshot.data!.docs[i]['notice'],
                                                    status: snapshot.data!.docs[i]['status'],
                                                    totalPriceProducts : snapshot.data!.docs[i]['totalPriceProducts'],
                                                    productUnits : snapshot.data!.docs[i]['productUnits'],

                                                  )
                                              )
                                          );
                                        },
                                        child: const Icon(Icons.info_outline,color: Colors.red,size: 25,),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );

              }
          );
        }
    );
  }
  returns(){
    var refFireStore = FirebaseFirestore.instance.collection('Returns');
    return StreamBuilder<QuerySnapshot>(
        stream: refFireStore
            .where('moderatorId', isEqualTo: widget.moderatorId)
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
                return SingleChildScrollView(
                  child: InkWell(
                    onTap: (){},
                    child:SizedBox(
                      height: 150,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              // onTap: tapWork,
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowThrowback(
                                          salesId : snapshot.data!.docs[i].id,
                                          moderatorId : snapshot.data!.docs[i]['moderatorId'],
                                          moderatorName : snapshot.data!.docs[i]['moderatorName'],
                                          totalPriceProducts : snapshot.data!.docs[i]['totalPriceProducts'],
                                          productUnits : snapshot.data!.docs[i]['productUnits'],
                                          clientName: snapshot.data!.docs[i]['clientName'],
                                          clientGovernorate: snapshot.data!.docs[i]['clientGovernorate'],
                                          clientAddress: snapshot.data!.docs[i]['clientAddress'],
                                          clientNumber: snapshot.data!.docs[i]['clientNumber'],
                                          orderDate: snapshot.data!.docs[i]['orderDate'],
                                          factory: factory,
                                          address: address,
                                          number1: number1,
                                          number2: number2,
                                        )
                                    )
                                );
                              },
                              child: Column(
                                children: <Widget>[
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SizedBox(
                                      // height: 90,
                                      // width:  200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: AutoSizeText(
                                          '{${snapshot.data!.docs[i]['moderatorName']}}',
                                          // 'إسم',
                                          // name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SizedBox(
                                      // height: 90,
                                      // width:  200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: AutoSizeText(
                                          '-${snapshot.data!.docs[i]['clientName']}',
                                          // 'إسم',
                                          // name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SizedBox(
                                      // height: 90,
                                      // width:  200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: AutoSizeText(
                                          // '-${snapshot.data!.docs[i]['clientGovernorate']}=>${snapshot.data!.docs[i]['clientAddress']}',
                                          '-${snapshot.data!.docs[i]['clientGovernorate']}',
                                          // 'إسم',
                                          // name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SizedBox(
                                      // height: 90,
                                      // width:  200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: AutoSizeText(
                                          // '- ${snapshot.data!.docs[i]['clientNumber']} || ${snapshot.data!.docs[i]['orderDate']}',
                                          '${snapshot.data!.docs[i]['orderDate']}',
                                          // 'إسم',
                                          // name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: (){
                                          // print(snapshot.data!.docs[i]['dateRegistration'].toDate());
                                          // print((DateTime.tryParse(snapshot.data!.docs[i]['dateRegistration'].toDate().toString())).toString());
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => InfoBillBack(
                                                    invoiceNumber: snapshot.data!.docs[i]['invoiceNumber'],
                                                    moderatorName : snapshot.data!.docs[i]['moderatorName'],

                                                    clientName: snapshot.data!.docs[i]['clientName'],
                                                    clientGovernorate: snapshot.data!.docs[i]['clientGovernorate'],
                                                    clientAddress: snapshot.data!.docs[i]['clientAddress'],
                                                    clientNumber: snapshot.data!.docs[i]['clientNumber'],

                                                    dateRegistration: snapshot.data!.docs[i]['dateRegistration'],
                                                    dateRegistrationBack: snapshot.data!.docs[i]['dateRegistrationBack'],
                                                    orderDate: snapshot.data!.docs[i]['orderDate'],
                                                    notice: snapshot.data!.docs[i]['notice'],
                                                    status: snapshot.data!.docs[i]['status'],
                                                    totalPriceProducts : snapshot.data!.docs[i]['totalPriceProducts'],
                                                    productUnits : snapshot.data!.docs[i]['productUnits'],

                                                  )
                                              )
                                          );
                                        },
                                        child: const Icon(Icons.info_outline,color: Colors.red,size: 25,),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          );
        }
    );
  }
}
