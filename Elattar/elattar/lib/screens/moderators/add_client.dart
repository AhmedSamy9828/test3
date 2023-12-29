import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elattar/screens/moderators/prepare_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);
  static String id = 'AddClient';

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {

  late String moderatorName = '';
  String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random r = Random();

  ver() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot infoModerators = await FirebaseFirestore.instance.collection('Moderators').doc(user!.uid).get();
    setState(() {
      moderatorName= infoModerators['name'];
    });
  }

  @override
  void initState() {
    ver();
    super.initState();
  }

  late String clientName;
  late String clientGovernorate;
  late String clientAddress;
  late String clientNumber;
  late String orderDate; // تاريخ الطلبيه
  late String notice = '';
  late DateTime dateRegistration = DateTime.now();
  late String status = 'عادي';
  late String invoiceNumber;
  late int totalPriceProducts = 0;
  late int productUnits = 0;
  String phone = '';
  final TextEditingController _date = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  // Future<String> generateRandomString(int len) async{
  //   var cv = await FirebaseFirestore.instance.collection('Info').doc('Random').get();
  //   var r = Random();
  //   const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  //   print( '${cv['ranking'] + 1 }' '-' ' ${List.generate(len, (index) => chars[r.nextInt(chars.length)]).join()}');
  //   return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  // }
  @override
  Widget build(BuildContext context) {
    CollectionReference refFireStore = FirebaseFirestore.instance.collection('Clients');
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'بحث عن عميل'
              ),
              onChanged: (val){
                setState(() {
                  phone = val;
                });
              }
          ),
        ),
        // title: const Text(
        //   'إضافه عميل',
        //   style: TextStyle(
        //     fontFamily: 'Pacifico',
        //     fontSize: 40,
        //     color: Colors.black,
        //   ),
        // ),
        centerTitle: true,
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Colors.blue,
        elevation: 5,
        automaticallyImplyLeading: false,
      ),
      body: (phone == '') ?
        SizedBox(
        height: MediaQuery.of(context).size.height,
        child:  Form(
          key: formstate,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Column(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل أسم العميل';
                          }
                          return null;
                        },
                        onSaved: (value){
                          clientName = value!;
                        },
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'الإسم',
                          labelText: 'اسم العميل',
                          prefixIcon: Icon(Icons.abc),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل محافظه العميل';
                          }
                          return null;
                        },
                        onSaved: (value){
                          clientGovernorate = value!;
                        },
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'محافظه العميل',
                          labelText: 'المحافظه',
                          prefixIcon: Icon(Icons.gps_fixed_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل عنوان العميل';
                          }
                          return null;
                        },
                        onSaved: (value){
                          clientAddress = value!;
                        },
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'موقع العميل',
                          labelText: 'العنوان',
                          prefixIcon: Icon(Icons.warehouse_rounded),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل رقم العميل';
                          }
                          return null;
                        },
                        onSaved: (value){
                          clientNumber = value!;
                        },
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'رقم الهاتف',
                          labelText: 'الرقم',
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child: TextFormField(
                        controller: _date,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل تاريخ';
                          }
                          return null;
                        },
                        onSaved: (value){
                          orderDate = value!;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today_rounded,
                            textDirection: ui.TextDirection.ltr,
                          ),
                          labelText: 'تاريخ الطلبيه',
                        ),
                        onTap: () async {
                          // String asd = D;
                          DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if( pickeddate != null ){
                            setState(() {
                              _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                              orderDate = DateFormat('yyyy-MM-dd').format(pickeddate);
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Directionality(
                        textDirection: ui.TextDirection.rtl,
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
                            items: ['عادي', 'مؤجل', 'عاجل'].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: 8,
                        onSaved: (value){
                          notice = value!;
                        },
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'الملاحظات',
                          labelText: 'ملاحظات',
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120),
                        child: Builder(
                          // ignore: deprecated_member_use
                          builder: (context) => ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: getColor(Colors.blue, Colors.red)
                            ),
                            onPressed: () async {
                              if (formstate.currentState!.validate())
                              {
                                formstate.currentState!.save();
                                showLoading(context);
                                User? user = FirebaseAuth.instance.currentUser;
                                try {

                                  DocumentReference ranking = FirebaseFirestore.instance.collection('Info').doc('Random');
                                  DocumentSnapshot rankingNumber =
                                        await FirebaseFirestore.instance.collection('Info').doc('Random').get();

                                  await FirebaseFirestore.instance.runTransaction((transaction) async {
                                    DocumentSnapshot rankingTransaction = await transaction.get(ranking);

                                    if(rankingTransaction.exists){
                                      transaction.update(ranking, {
                                        'ranking' : rankingNumber['ranking'] + 1 ,
                                      });

                                      await FirebaseFirestore.instance
                                          .collection('Clients').limit(1).get().then((value) async {
                                        if(value.size ==  0){
                                          await FirebaseFirestore.instance
                                              .collection('Clients').add({
                                            'clientName' : clientName,
                                            'clientGovernorate' : clientGovernorate,
                                            'clientAddress' : clientAddress,
                                            'clientNumber' : clientNumber,
                                          });
                                          await FirebaseFirestore.instance
                                              .collection('Sales').add({
                                            'clientName' : clientName,
                                            'clientGovernorate' : clientGovernorate,
                                            'clientAddress' : clientAddress,
                                            'clientNumber' : clientNumber,

                                            'totalPriceProducts' : totalPriceProducts,
                                            'productUnits' : productUnits,
                                            'orderDate' : orderDate,
                                            'dateRegistration' : dateRegistration,
                                            'status' : status,
                                            'notice' : notice,
                                            'invoiceNumber' :
                                            '${rankingNumber['ranking'] + 1}'
                                                '-'
                                                ' ${List.generate(7, (index) => chars[r.nextInt(chars.length)]).join()}',

                                            'moderatorId' : user!.uid,
                                            'moderatorName' : moderatorName,

                                            'preparation' : 'true', // تحضير الطلبيه لإرسالها إلي المدير
                                            'waiting' : 'false', // إنتظار الطلبيه إلي أن يتم طباعه الفاتوره
                                            'sold' : 'false', // تم بيع الطلبيه
                                            'throwback' : 'false', // تمت عوده الطلبيه إلي المخزن

                                          });
                                        }
                                        else{
                                          await FirebaseFirestore.instance
                                              .collection('Clients')
                                              .where('clientNumber', isEqualTo: clientNumber)
                                              .get().then((value) async {
                                            if(value.size == 0){
                                              // ignore: avoid_print
                                              await FirebaseFirestore.instance
                                                  .collection('Clients').add({
                                                'clientName' : clientName,
                                                'clientGovernorate' : clientGovernorate,
                                                'clientAddress' : clientAddress,
                                                'clientNumber' : clientNumber,
                                              });

                                              await FirebaseFirestore.instance
                                                  .collection('Sales').add({
                                                'clientName' : clientName,
                                                'clientGovernorate' : clientGovernorate,
                                                'clientAddress' : clientAddress,
                                                'clientNumber' : clientNumber,

                                                'totalPriceProducts' : totalPriceProducts,
                                                'productUnits' : productUnits,
                                                'orderDate' : orderDate,
                                                'dateRegistration' : dateRegistration,
                                                'status' : status,
                                                'notice' : notice,
                                                'invoiceNumber' :
                                                '${rankingNumber['ranking'] + 1}'
                                                    '-'
                                                    ' ${List.generate(7, (index) => chars[r.nextInt(chars.length)]).join()}',

                                                'moderatorId' : user!.uid,
                                                'moderatorName' : moderatorName,

                                                'preparation' : 'true', // تحضير الطلبيه لإرسالها إلي المدير
                                                'waiting' : 'false', // إنتظار الطلبيه إلي أن يتم طباعه الفاتوره
                                                'sold' : 'false', // تم بيع الطلبيه
                                                'throwback' : 'false', // تمت عوده الطلبيه إلي المخزن

                                              });
                                            }
                                            else{
                                              // ignore: avoid_print
                                              await FirebaseFirestore.instance
                                                  .collection('Sales').add({
                                                'clientName' : clientName,
                                                'clientGovernorate' : clientGovernorate,
                                                'clientAddress' : clientAddress,
                                                'clientNumber' : clientNumber,

                                                'totalPriceProducts' : totalPriceProducts,
                                                'productUnits' : productUnits,
                                                'orderDate' : orderDate,
                                                'dateRegistration' : dateRegistration,
                                                'status' : status,
                                                'notice' : notice,
                                                'invoiceNumber' :
                                                '${rankingNumber['ranking'] + 1}'
                                                    '-'
                                                    ' ${List.generate(7, (index) => chars[r.nextInt(chars.length)]).join()}',

                                                'moderatorId' : user!.uid,
                                                'moderatorName' : moderatorName,

                                                'preparation' : 'true', // تحضير الطلبيه لإرسالها إلي المدير
                                                'waiting' : 'false', // إنتظار الطلبيه إلي أن يتم طباعه الفاتوره
                                                'sold' : 'false', // تم بيع الطلبيه
                                                'throwback' : 'false', // تمت عوده الطلبيه إلي المخزن
                                              });
                                            }
                                          });
                                        }
                                      });
                                    }
                                  });



                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                  AwesomeDialog(
                                    context : this.context,
                                    title: 'إضافه عميل',
                                    animType: AnimType.rightSlide,
                                    body: const Text('تمت إضافه العميل'),
                                    dialogType: DialogType.success,
                                    // btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  ).show();
                                }on FirebaseAuthException catch (e) {
                                  Navigator.of(context).pop();
                                  AwesomeDialog(
                                      context : this.context,
                                      title: 'الحاله',
                                      body:  e.message != null ? Text(e.code)
                                      // : e.code != null ? Text(e.code)
                                          : const Text('حدث خطأ ما: بالرجاء المحاوله لاحقاً'),
                                      dialogType: DialogType.warning)
                                      .show();
                                }
                              } else {}
                            },
                            // color: Colors.blue,
                            child: const Text(
                              ' تسجيل العميل ',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                    ),
                    const SizedBox(height: 30),
                  ]
              ),
            ),
          ),
        ),
      ) :
        StreamBuilder<QuerySnapshot>(
          stream: refFireStore
              .where('clientNumber', isEqualTo: phone)
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
                  String clientName = snapshot.data!.docs[i]['clientName'];
                  String clientGovernorate = snapshot.data!.docs[i]['clientGovernorate'];
                  String clientAddress = snapshot.data!.docs[i]['clientAddress'];
                  String clientNumber = snapshot.data!.docs[i]['clientNumber'];
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
                                              builder: (context) => PrepareClient(
                                                clientId: snapshot.data!.docs[i].id,
                                                clientName: clientName,
                                                clientGovernorate: clientGovernorate,
                                                clientAddress: clientAddress,
                                                clientNumber: clientNumber,
                                                moderatorName: moderatorName,
                                              )
                                          )
                                      );
                                    },
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          AutoSizeText(
                                            clientName,
                                            textDirection: ui.TextDirection.rtl,
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
                                            textDirection: ui.TextDirection.rtl,
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
                                            textDirection: ui.TextDirection.rtl,
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
                                            textDirection: ui.TextDirection.rtl,
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
