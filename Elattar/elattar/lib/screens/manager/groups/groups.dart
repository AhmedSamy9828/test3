import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elattar/screens/manager/groups/add_groups.dart';
import 'package:elattar/screens/manager/groups/modify_groups.dart';
import 'package:elattar/screens/manager/groups/products/products.dart';
// import 'package:elattar/screens/manager/suppliers/modify_supplier_data.dart';
// import 'package:elattar/screens/manager/suppliers/group.dart';
import 'package:flutter/material.dart';

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);
  static String id = 'Groups';

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    var refFireStore = FirebaseFirestore.instance.collection('Groups');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الأصناف',
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
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddGroups.id);
          },
          icon: const Icon(
            Icons.add_business,
            // color: Colors.white,
          ),
        ),
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
                  String groupsId = snapshot.data!.docs[i].id;
                  String groupsCode = snapshot.data!.docs[i]['groupsCode'];
                  String groupsName = snapshot.data!.docs[i]['groupsName'];
                  String groupsSection = snapshot.data!.docs[i]['groupsSection'];
                  String groupsBrunch = snapshot.data!.docs[i]['groupsBrunch'];
                  int quantityOfProductsInGroups = snapshot.data!.docs[i]['quantityOfProductsInGroups'];
                  String dateOfArrivalGroup = snapshot.data!.docs[i]['dateOfArrivalGroup'];
                  return SingleChildScrollView(
                    child: Row(
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
                                              builder: (context) => Products(
                                                groupsId: groupsId,
                                                groupsCode: groupsCode,
                                                groupsName: groupsName,
                                                groupsSection: groupsSection,
                                                groupsBrunch: groupsBrunch,
                                                quantityOfProductsInGroups: quantityOfProductsInGroups,
                                                dateOfArrivalGroup: dateOfArrivalGroup,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ModifyGroups(
                                                    groupsId: groupsId,
                                                    groupsCode: groupsCode,
                                                    groupsName: groupsName,
                                                    groupsSection: groupsSection,
                                                    groupsBrunch: groupsBrunch,
                                                    quantityOfProductsInGroups: quantityOfProductsInGroups,
                                                    dateOfArrivalGroup: dateOfArrivalGroup,
                                                  )
                                              )
                                          );
                                        },
                                        child: const Icon(Icons.edit,),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // ),
                              // ),
                            ),
                          ),
                        ),
                      ],
                      // ),
                    ),
                  );
                }
            );
          }
      ),
    );
  }

  widgetInkWell({name, address, number, onTap, onTapEdite}){
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
                        ]
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: onTapEdite,
                        child: const Icon(Icons.edit,),
                      ),

                    ],
                  ),

                ],
              ),
              // ),
            ),
          ),
        ),
      ],
    );

  }

}
