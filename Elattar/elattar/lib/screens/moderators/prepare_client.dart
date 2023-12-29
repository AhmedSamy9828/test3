import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class PrepareClient extends StatefulWidget {
  static String id = 'PrepareClient';
  const PrepareClient({Key? key,
    required this.clientId,
    required this.clientName,
    required this.clientGovernorate,
    required this.clientAddress,
    required this.clientNumber,
    required this.moderatorName,
  }) : super(key: key);

  final String clientId;
  final String clientName;
  final String clientGovernorate;
  final String clientAddress;
  final String clientNumber;
  final String moderatorName;


  @override
  State<PrepareClient> createState() => _PrepareClientState();
}

class _PrepareClientState extends State<PrepareClient> {

  String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random r = Random();

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تسجيل طلبيه',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Colors.blue,
        elevation: 5,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
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
                      child: ListTile(
                        title: const Text('إسم العميل', style: TextStyle(color: Colors.black),),
                        subtitle: Text(widget.clientName, style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child: ListTile(
                        title: const Text('محافظه العميل', style: TextStyle(color: Colors.black),),
                        subtitle: Text(widget.clientGovernorate, style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child: ListTile(
                        title: const Text('عنوان العميل', style: TextStyle(color: Colors.black),),
                        subtitle: Text(widget.clientAddress, style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child: ListTile(
                        title: const Text('رقم العميل', style: TextStyle(color: Colors.black),),
                        subtitle: Text(widget.clientNumber, style: const TextStyle(color: Colors.red),),
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
                                  DocumentReference client = FirebaseFirestore.instance.collection('Clients').doc(widget.clientId);
                                  DocumentSnapshot rankingNumber =
                                  await FirebaseFirestore.instance.collection('Info').doc('Random').get();

                                  await FirebaseFirestore.instance.runTransaction((transaction) async {
                                    DocumentSnapshot rankingTransaction = await transaction.get(ranking);
                                    DocumentSnapshot clientTransaction = await transaction.get(client);

                                    if(rankingTransaction.exists){
                                      transaction.update(ranking, {
                                        'ranking' : rankingNumber['ranking'] + 1 ,
                                      });
                                      if(clientTransaction.exists){
                                        await FirebaseFirestore.instance
                                            .collection('Sales').add({
                                          'clientName' : widget.clientName,
                                          'clientGovernorate' : widget.clientGovernorate,
                                          'clientAddress' : widget.clientAddress,
                                          'clientNumber' : widget.clientNumber,

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
                                          'moderatorName' : widget.moderatorName,

                                          'preparation' : 'true', // تحضير الطلبيه لإرسالها إلي المدير
                                          'waiting' : 'false', // إنتظار الطلبيه إلي أن يتم طباعه الفاتوره
                                          'sold' : 'false', // تم بيع الطلبيه
                                          'throwback' : 'false', // تمت عوده الطلبيه إلي المخزن
                                        });
                                      }
                                    }
                                  });



                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                  AwesomeDialog(
                                    context : this.context,
                                    title: 'إضافه طليه',
                                    animType: AnimType.rightSlide,
                                    body: const Text('تمت إضافه الطلبيه'),
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
