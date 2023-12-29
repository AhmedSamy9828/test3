// import 'dart:io';
// import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
// import 'package:path/path.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key,
    required this.groupsId,
    required this.groupsName,
    required this.quantityOfProductsInGroups,
    required this.dateOfArrivalGroup,
  }) : super(key: key);

  final String groupsId;
  final String groupsName;
  final int quantityOfProductsInGroups;
  final String dateOfArrivalGroup;

  static String id = 'AddProducts';

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  late String productsCode;
  late String productsName;
  late String productsSize;
  late String productsColor;
  late int quantityOfProducts;
  late int productsPrice;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إضافه منتج',
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child:  Form(
          key: formstate,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20,),
                    Text(widget.groupsName, style: const TextStyle(fontSize: 25),),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل كود المنتج';
                          }
                          return null;
                        },
                        onSaved: (value){
                          productsCode = value!;
                        },
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'الكود',
                          labelText: 'كود المنتج',
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل إسم المنتج';
                          }
                          return null;
                        },
                        onSaved: (value){
                          productsName = value!;
                        },
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'الإسم',
                          labelText: 'إسم المنتج',
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل مقاس المنتج';
                          }
                          return null;
                        },
                        onSaved: (value){
                          productsSize = value!;
                        },
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'المقاس',
                          labelText: 'مقاس المنتج',
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل لون المنتج';
                          }
                          return null;
                        },
                        onSaved: (value){
                          productsColor = value!;
                        },
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'اللون',
                          labelText: 'لون المنتج',
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل كميه المنتج';
                          }
                          int? n = int.tryParse(value);
                          if(n == null) {
                            return '"$value" is not a valid number';
                          }
                          // if( n > widget.quantityOfProductsInGroups) {
                          //   return 'كميه المنتجات أكبر من عدد المنتجات داخل هذا الصنف';
                          // }
                          if( n <= 0) {
                            return 'لا يمكن إدخال كميه أقل من 1';
                          }
                          return null;
                        },
                        onSaved: (value){
                          quantityOfProducts = int.tryParse(value!)!;
                        },
                        // autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'الكميه',
                          labelText: 'كميه المنتجات',
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل سعر المنتج';
                          }
                          int? n = int.tryParse(value);
                          if(n == null) {
                            return '"$value" is not a valid number';
                          }
                          // if(n < 100000) {
                          //   return '"$value" is not a valid number';
                          // }
                          return null;
                        },
                        onSaved: (value){
                          productsPrice = int.tryParse(value!)!;
                        },
                        // autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'السعر',
                          labelText: 'سعر المنتج',
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
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
                                  try {
                                    var asd = await FirebaseFirestore.instance
                                        .collection('Groups').doc(widget.groupsId).get();

                                    // DocumentReference groupsReference = FirebaseFirestore.instance
                                    //     .collection('Groups').doc(widget.groupsId);
                                    // WriteBatch batch = FirebaseFirestore.instance.batch();

                                    await FirebaseFirestore.instance.collection('Groups').doc(widget.groupsId)
                                        .collection('Products').add({
                                      'groupsId' : widget.groupsId,
                                      'dateOfArrivalGroup' : widget.dateOfArrivalGroup,

                                      'productsCode' : productsCode,
                                      'productsName' : productsName,
                                      'productsSize' : productsSize,
                                      'productsColor' : productsColor,
                                      'quantityOfProducts' : quantityOfProducts,
                                      'productsPrice' : productsPrice,
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('Groups').doc(widget.groupsId).update({
                                      'quantityOfProductsInGroups' : asd['quantityOfProductsInGroups'] + quantityOfProducts,
                                    });

                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();Navigator.of(context).pop();
                                    // AwesomeDialog(
                                    //   context : this.context,
                                    //   title: 'إضافه منتج',
                                    //   animType: AnimType.rightSlide,
                                    //   body: const Text('تمت إضافه المنتج'),
                                    //   dialogType: DialogType.success,
                                    //   // btnCancelOnPress: () {},
                                    //   btnOkOnPress: () {},
                                    // ).show();
                                  }on FirebaseAuthException catch (e) {
                                    // ignore: use_build_context_synchronously
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
                              ' إضافه منتج ',
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
