import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elattar/screens/manager/sales/billed.dart';
import 'package:elattar/screens/manager/sales/info_bille.dart';
import 'package:flutter/material.dart';

class Sales extends StatefulWidget {
  const Sales({Key? key}) : super(key: key);
  static String id = 'Sales';

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {

  late String factory = '';
  late String address = '';
  late String number1 = '';
  late String number2 = '';
  late String status = 'الكل';

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

  @override
  void initState() {
    ver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var refFireStore = FirebaseFirestore.instance.collection('Sales');
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المبيعات',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Colors.blue,
        elevation: 5,
        // automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Center( child: Text('حدد نوع الفاتوره'),),
              onTap: (){
              },
            ),
            const Divider(
              color: Colors.red,
              height: 50,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: DropdownButtonFormField<String>(
                    onSaved: (value) {
                      status = value!;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'نوع الفاتوره',
                      contentPadding: const EdgeInsets.all(15),
                      filled: true,
                      fillColor: Colors.grey,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Colors.redAccent
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Colors.greenAccent
                          )
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Colors.white
                          )
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        status = value!;
                      });
                    },
                    value: status,
                    items: [ 'الكل', 'عادي', 'مؤجل', 'عاجل'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02,),
          ],
        ),
      ),
      body: (status == 'الكل') ?
      StreamBuilder<QuerySnapshot>(
          stream: refFireStore
              .where('waiting', isEqualTo: 'true')
              .orderBy('orderDate').snapshots(),
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
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 160,
                        width: mediaQueryWidth * .95,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Billed(
                                                salesId : snapshot.data!.docs[i].id,
                                                invoiceNumber : snapshot.data!.docs[i]['invoiceNumber'],

                                                moderatorId : snapshot.data!.docs[i]['moderatorId'],
                                                moderatorName : snapshot.data!.docs[i]['moderatorName'],
                                                totalPriceProducts : snapshot.data!.docs[i]['totalPriceProducts'],
                                                productUnits : snapshot.data!.docs[i]['productUnits'],
                                                clientName: snapshot.data!.docs[i]['clientName'],
                                                clientGovernorate: snapshot.data!.docs[i]['clientGovernorate'],
                                                clientAddress: snapshot.data!.docs[i]['clientAddress'],
                                                clientNumber: snapshot.data!.docs[i]['clientNumber'],
                                                notice: snapshot.data!.docs[i]['notice'],
                                                status: snapshot.data!.docs[i]['status'],
                                                orderDate: snapshot.data!.docs[i]['orderDate'],
                                                dateRegistration: snapshot.data!.docs[i]['dateRegistration'],
                                                factory: factory,
                                                address: address,
                                                number1: number1,
                                                number2: number2,
                                              )
                                          )
                                      );
                                    },
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          AutoSizeText(
                                            '{${snapshot.data!.docs[i]['moderatorName']}}',
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
                                            '-${snapshot.data!.docs[i]['clientName']}',
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
                                            // '-${snapshot.data!.docs[i]['clientGovernorate']}=>${snapshot.data!.docs[i]['clientAddress']}',
                                            '-${snapshot.data!.docs[i]['clientGovernorate']}',
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
                                            // '- ${snapshot.data!.docs[i]['clientNumber']} || ${snapshot.data!.docs[i]['orderDate']}',
                                            '${snapshot.data!.docs[i]['orderDate']}',
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                            minFontSize: 10,
                                            maxLines: 3,
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
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
            );
          }
      ) :
      StreamBuilder<QuerySnapshot>(
          stream: refFireStore
              .where('waiting', isEqualTo: 'true')
              .where('status', isEqualTo: status)
              .orderBy('orderDate').snapshots(),
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
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 160,
                        width: mediaQueryWidth * .95,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Billed(
                                                salesId : snapshot.data!.docs[i].id,
                                                invoiceNumber : snapshot.data!.docs[i]['invoiceNumber'],

                                                moderatorId : snapshot.data!.docs[i]['moderatorId'],
                                                moderatorName : snapshot.data!.docs[i]['moderatorName'],
                                                totalPriceProducts : snapshot.data!.docs[i]['totalPriceProducts'],
                                                productUnits : snapshot.data!.docs[i]['productUnits'],
                                                clientName: snapshot.data!.docs[i]['clientName'],
                                                clientGovernorate: snapshot.data!.docs[i]['clientGovernorate'],
                                                clientAddress: snapshot.data!.docs[i]['clientAddress'],
                                                clientNumber: snapshot.data!.docs[i]['clientNumber'],
                                                notice: snapshot.data!.docs[i]['notice'],
                                                status: snapshot.data!.docs[i]['status'],
                                                orderDate: snapshot.data!.docs[i]['orderDate'],
                                                dateRegistration: snapshot.data!.docs[i]['dateRegistration'],
                                                factory: factory,
                                                address: address,
                                                number1: number1,
                                                number2: number2,
                                              )
                                          )
                                      );
                                    },
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          AutoSizeText(
                                            ' { ${snapshot.data!.docs[i]['moderatorName']} } ',
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
                                            ' - ${snapshot.data!.docs[i]['clientName']}    ',
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
                                            // '-${snapshot.data!.docs[i]['clientGovernorate']}=>${snapshot.data!.docs[i]['clientAddress']}',
                                            '-${snapshot.data!.docs[i]['clientGovernorate']}',
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
                                            // '- ${snapshot.data!.docs[i]['clientNumber']} || ${snapshot.data!.docs[i]['orderDate']}',
                                            '${snapshot.data!.docs[i]['orderDate']}',
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                            minFontSize: 10,
                                            maxLines: 3,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              InkWell(
                                                onTap: (){
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
                                        ]
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
            );
          }
      ) ,
    );
  }
}
