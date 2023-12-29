import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elattar/screens/login.dart';
import 'package:elattar/screens/manager/employees/employee_work_file.dart';
import 'package:elattar/screens/moderators/Send_The_Order.dart';
import 'package:elattar/screens/moderators/add_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeModerators extends StatefulWidget {
  const HomeModerators({Key? key}) : super(key: key);
  static String id = 'HomeModerators';

  @override
  State<HomeModerators> createState() => _HomeModeratorsState();
}

class _HomeModeratorsState extends State<HomeModerators> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var moderatorId = user!.uid;
    var refFireStore = FirebaseFirestore.instance.collection('Sales');
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'العملاء',
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
        actions: [
          IconButton(
            onPressed: ()
            {
              Navigator.of(context).pushNamed(AddClient.id);
            },
            icon: const Icon(
              Icons.accessibility,
              // size: 30,
            ),
          ),
        ],
        // leading: IconButton(
        //   onPressed: () async {
        //     // Navigator.of(context).pushNamed(ModeratorsProfile.id);
        //     await FirebaseAuth.instance.signOut();
        //     // ignore: use_build_context_synchronously
        //     Navigator.of(context).pushNamedAndRemoveUntil(Login.id, (route) => false);
        //   },
        //   icon: const Icon(
        //     // Icons.settings,
        //     Icons.output,
        //     // color: Colors.white,
        //   ),
        // ),
      ),
      drawer: Drawer(
        // backgroundColor: Colors.black,
        child: Column(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage('assets/login.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              currentAccountPicture: null,
              accountName: null,
              accountEmail: null,
            ),
            ListTile(
              title: const Text('المبيعات'),
              leading: const Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.blue,
              ),
              onTap: () async{
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmployeeWorkFile(
                          moderatorId: moderatorId,
                          // moderatorName: moderatorName,
                          // moderatorPhone: moderatorPhone,
                          // moderatorNationId: moderatorNationId,
                          // moderatorEmail: moderatorEmail,
                          // moderatorPassword: moderatorPassword,
                        )
                    )
                );
              },
            ),
            const Divider(
              color: Colors.red,
              height: 50,
              thickness: 2,
            ),
            ListTile(
              title: const Text('تسجيل خروج'),
              leading: const Icon(Icons.logout, color: Colors.blue,),
              onTap: () async{
                // Navigator.of(context).pushNamed(ModeratorsProfile.id);
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushNamedAndRemoveUntil(Login.id, (route) => false);
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: refFireStore
              .where('moderatorId', isEqualTo: user.uid)
              .where('preparation', isEqualTo: 'true')
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
                  String salesId = snapshot.data!.docs[i].id;
                  String clientName = snapshot.data!.docs[i]['clientName'];
                  String clientGovernorate = snapshot.data!.docs[i]['clientGovernorate'];
                  String clientAddress = snapshot.data!.docs[i]['clientAddress'];
                  String clientNumber = snapshot.data!.docs[i]['clientNumber'];
                  int productUnits = snapshot.data!.docs[i]['productUnits'];
                  int totalPriceProducts = snapshot.data!.docs[i]['totalPriceProducts'];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 155,
                        width: mediaQueryWidth * .95,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SendTheOrder(
                                                salesId: salesId,
                                                clientName: clientName,
                                                clientGovernorate: clientGovernorate,
                                                clientAddress: clientAddress,
                                                clientNumber: clientNumber,
                                                productUnits: productUnits,
                                                totalPriceProducts: totalPriceProducts,
                                              )
                                          )
                                      );
                                    },
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          AutoSizeText(
                                            clientName,
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
                                            clientGovernorate,
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
                                            clientAddress,
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
                                            clientNumber,
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
      ),
    );
  }
}
