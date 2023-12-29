import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class ModifyGroups extends StatefulWidget {
  const ModifyGroups({Key? key,
    required this.groupsId,
    required this.groupsCode,
    required this.groupsName,
    required this.groupsSection,
    required this.groupsBrunch,
    required this.quantityOfProductsInGroups,
    required this.dateOfArrivalGroup,

  }) : super(key: key);

  final String groupsId;
  final String groupsCode;
  final String groupsName;
  final String groupsSection;
  final String groupsBrunch;
  final int quantityOfProductsInGroups;
  final String dateOfArrivalGroup;

  static String id = 'ModifyGroups';

  @override
  State<ModifyGroups> createState() => _ModifyGroupsState();
}

class _ModifyGroupsState extends State<ModifyGroups> {

  getInfoGroup(){
    setState(() {
      groupsCode = widget.groupsCode;
      groupsName = widget.groupsName;
      groupsSection = widget.groupsSection;
      groupsBrunch = widget.groupsBrunch;
      quantityOfProductsInGroups = widget.quantityOfProductsInGroups;
      dateOfArrivalGroup = widget.dateOfArrivalGroup;
    });
  }
  @override
  void initState() {
    getInfoGroup();
    super.initState();
  }

  late String groupsCode;
  late String groupsName;
  late String groupsSection;
  late String groupsBrunch;
  late int quantityOfProductsInGroups;
  late String dateOfArrivalGroup;
  final TextEditingController _date = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'التعديل علي صنف',
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
                    Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child:TextFormField(
                        initialValue: widget.groupsCode,
                        keyboardType: TextInputType.name,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل كود الصنف';
                          }
                          return null;
                        },
                        onSaved: (value){
                          groupsCode = value!;
                        },
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'الكود',
                          labelText: 'كود الصنف',
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child:TextFormField(
                        initialValue: widget.groupsName,
                        keyboardType: TextInputType.name,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل أسم الصنف';
                          }
                          return null;
                        },
                        onSaved: (value){
                          groupsName = value!;
                        },
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'الإسم',
                          labelText: 'إسم الصنف',
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child:TextFormField(
                        initialValue: widget.groupsSection,
                        keyboardType: TextInputType.name,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل أسم القسم';
                          }
                          return null;
                        },
                        onSaved: (value){
                          groupsSection = value!;
                        },
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'القسم',
                          labelText: 'قسم الصنف',
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: ui.TextDirection.rtl,
                      child:TextFormField(
                        initialValue: widget.groupsBrunch,
                        keyboardType: TextInputType.name,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل أسم الفرع';
                          }
                          return null;
                        },
                        onSaved: (value){
                          groupsBrunch = value!;
                        },
                        autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'الفرع',
                          labelText: 'فرع الصنف',
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('تاريخ وصول الصنف${widget.dateOfArrivalGroup}'),
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
                          dateOfArrivalGroup = value!;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today_rounded,
                            textDirection: ui.TextDirection.ltr,
                          ),
                          labelText: 'تاريخ الوصول',
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
                              dateOfArrivalGroup = DateFormat('yyyy-MM-dd').format(pickeddate);
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Builder(
                              // ignore: deprecated_member_use
                              builder: (context) => ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: getColor(Colors.blue, Colors.red)
                                ),
                                onPressed: () async {
                                  showLoading(context);

                                  await FirebaseFirestore.instance
                                      .collection('Groups').doc(widget.groupsId)
                                      .collection('Products')
                                      .limit(1).get().then((value) async {
                                    if(value.size ==  0){
                                      await FirebaseFirestore.instance
                                          .collection('Groups').doc(widget.groupsId).delete();
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pop();Navigator.of(context).pop();
                                    }else{
                                      Navigator.of(context).pop();
                                      AwesomeDialog(
                                        context : this.context,
                                        title: 'حذف الصنف',
                                        animType: AnimType.rightSlide,
                                        body: const Text('هناك منتجات داخل هذا الصنف من فضلك قم بحذفها أولاً'),
                                        dialogType: DialogType.success,
                                        // btnCancelOnPress: () {},
                                        btnOkOnPress: () {},
                                      ).show();
                                    }
                                  });
                                  //
                                  // // ignore: use_build_context_synchronously
                                  // Navigator.of(context).pop();
                                  // // ignore: use_build_context_synchronously
                                  // Navigator.of(context).pop();
                                },
                                // color: Colors.blue,
                                child: const Text(
                                  ' حذف الصنف ',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            )
                        ),
                        const SizedBox(height: 30),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                      await FirebaseFirestore.instance
                                          .collection('Groups').doc(widget.groupsId).update({
                                        'groupsCode' : groupsCode,
                                        'groupsName' : groupsName,
                                        'groupsSection' : groupsSection,
                                        'groupsBrunch' : groupsBrunch,
                                        'dateOfArrivalGroup' : dateOfArrivalGroup,
                                      });
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pop();
                                      AwesomeDialog(
                                        context : this.context,
                                        title: 'تعديل صنف',
                                        animType: AnimType.rightSlide,
                                        body: const Text('تمت التعديل علي الصنف'),
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
                                  ' تعديل الصنف ',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            )
                        ),
                      ],
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
