import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductSelection extends StatefulWidget {
  const ProductSelection({Key?key,
    required this.salesId,
    required this.productUnits,
    required this.totalPriceProducts,

    required this.groupId,
    required this.groupsName,
    required this.groupsCode,
    required this.groupsSection,
    required this.groupsBrunch,
    required this.quantityOfProductsInGroups,
    required this.dateOfArrivalGroup,

    required this.productId,
    required this.productsCode,
    required this.productsName,
    required this.productsSize,
    required this.productsColor,
    required this.quantityOfProducts,
    required this.productsPrice,
  }) : super(key: key);

  final String salesId;
  final int productUnits;
  final int totalPriceProducts;

  final String groupId;
  final String groupsName;
  final String groupsCode;
  final String groupsSection;
  final String groupsBrunch;
  final int quantityOfProductsInGroups;
  final String dateOfArrivalGroup;

  final String productId;
  final String productsCode;
  final String productsName;
  final String productsSize;
  final String productsColor;
  final int quantityOfProducts;
  final int productsPrice;

  static String id = 'ProductSelection';

  @override
  State<ProductSelection> createState() => _ProductSelectionState();
}

class _ProductSelectionState extends State<ProductSelection> {

  late int totalProducts;
  late int newPriceProduct;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // final int totalPriceProducts;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إختيار المنتج',
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
                    const SizedBox(height: 5,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: const Text('كود المنتج', style: TextStyle(color: Colors.black),),
                        subtitle: Text(widget.productsCode, style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: const Text('إسم المنتج', style: TextStyle(color: Colors.black),),
                        subtitle: Text(widget.productsName, style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: const Text('مقاس المنتج', style: TextStyle(color: Colors.black),),
                        subtitle: Text(widget.productsSize, style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: const Text('لون المنتج', style: TextStyle(color: Colors.black),),
                        subtitle: Text(widget.productsColor, style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: const Text('كميه المنتجات', style: TextStyle(color: Colors.black),),
                        subtitle: Text('${widget.quantityOfProducts}', style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: const Text('سعر المنتج', style: TextStyle(color: Colors.black),),
                        subtitle: Text('${widget.productsPrice}', style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child:TextFormField(
                        // initialValue: ('${widget.quantityOfProducts}'),
                        keyboardType: TextInputType.number,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل كميه المنتج المطلوبه';
                          }
                          int? n = int.tryParse(value);
                          if(n == null) {
                            return '"$value" is not a valid number';
                          }
                          if( n > widget.quantityOfProducts) {
                            return 'كميه المنتجات أكبر من عدد المنتجات داخل هذا الصنف';
                          }
                          if( n <= 0) {
                            return 'لا يمكن إدخال كميه أقل من 1';
                          }
                          return null;
                        },
                        onSaved: (value){
                          totalProducts = int.tryParse(value!)!;
                        },
                        // autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'الكميه',
                          labelText: 'كميه المنتجات المطلوبه',
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child:TextFormField(
                        // initialValue: ('${widget.quantityOfProducts}'),
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
                          if( n < widget.productsPrice) {
                            return 'السعر أقل من الحد الأدني';
                          }
                          return null;
                        },
                        onSaved: (value){
                          newPriceProduct = int.tryParse(value!)!;
                        },
                        // autofillHints: const [AutofillHints.newUsername],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'السعر',
                          labelText: 'سعر البيع',
                          prefixIcon: Icon(Icons.note),
                        ),
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
                                  if (formstate.currentState!.validate())
                                  {
                                    formstate.currentState!.save();
                                    showLoading(context);
                                    // User? user = FirebaseAuth.instance.currentUser;

                                    // int calculator = widget.quantityOfProducts - totalProducts;


                                    // DocumentSnapshot productSnap = await FirebaseFirestore.instance
                                    //     .collection('Groups').doc(widget.groupId)
                                    //     .collection('Products').doc(widget.productId).get();
                                    DocumentReference productReference = FirebaseFirestore.instance
                                        .collection('Groups').doc(widget.groupId)
                                        .collection('Products').doc(widget.productId);

                                    // DocumentSnapshot groupsSnap = await FirebaseFirestore.instance
                                    //     .collection('Groups').doc(widget.groupId).get();
                                    DocumentReference groupsReference = FirebaseFirestore.instance
                                        .collection('Groups').doc(widget.groupId);

                                    // DocumentSnapshot salesSnap = await FirebaseFirestore.instance
                                    //     .collection('Sales').doc(widget.salesId).get();
                                    DocumentReference salesReference = FirebaseFirestore.instance
                                        .collection('Sales').doc(widget.salesId);

                                    /// ##################  TEST
                                    await FirebaseFirestore.instance.runTransaction((transaction) async {
                                      DocumentSnapshot productTransaction = await transaction.get(productReference);
                                      DocumentSnapshot groupsTransaction = await transaction.get(groupsReference);
                                      // DocumentSnapshot salesTransaction = await transaction.get(groupsReference);

                                      if(productTransaction.exists){
                                        if( productTransaction['quantityOfProducts'] <= 0 ){
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context).pop();
                                          AwesomeDialog(
                                            context : this.context,
                                            title: 'خطأ1',
                                            animType: AnimType.rightSlide,
                                            body: const Text('يبدو بأن هناك شئ خاطئ1(داخل مخزن المنتجات)'),
                                            dialogType: DialogType.error,
                                            // btnCancelOnPress: () {},
                                            btnOkOnPress: () {},
                                          ).show();
                                        }

                                        if( productTransaction['quantityOfProducts'] > 0 ){

                                          if(productTransaction['quantityOfProducts'] - totalProducts > 0){

                                            transaction.update(productReference,
                                                {
                                              'quantityOfProducts': productTransaction['quantityOfProducts'] - totalProducts,
                                                });

                                            transaction.update(groupsReference,
                                                {
                                                  'quantityOfProductsInGroups': groupsTransaction['quantityOfProductsInGroups'] - totalProducts,
                                                });

                                            transaction.update(salesReference,
                                                {
                                                  'totalPriceProducts':
                                                    (totalProducts * newPriceProduct) + widget.totalPriceProducts ,
                                                  'productUnits' : totalProducts + widget.productUnits ,
                                                });

                                            await FirebaseFirestore.instance.collection('Sales').doc(widget.salesId)
                                                .collection('ClientProducts').add({

                                              'groupId' : widget.groupId,
                                              'groupsCode' : widget.groupsCode,
                                              'groupsName' : widget.groupsName,
                                              'groupsSection' : widget.groupsSection,
                                              'groupsBrunch' : widget.groupsBrunch,
                                              'quantityOfProductsInGroups' : widget.quantityOfProductsInGroups,
                                              'dateOfArrivalGroup' : widget.dateOfArrivalGroup,

                                              'productId' : widget.productId,
                                              'productsCode' : widget.productsCode,
                                              'productsName' : widget.productsName,
                                              'productsSize' : widget.productsSize,
                                              'productsColor' : widget.productsColor,
                                              'productsPrice' : widget.productsPrice,
                                              'newPriceProduct' : newPriceProduct,
                                              'totalProducts' : totalProducts,
                                              'totalPrice' : totalProducts * newPriceProduct,

                                            });

                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                          }

                                          if(productTransaction['quantityOfProducts'] - totalProducts == 0) {

                                            transaction.delete(productReference,);

                                            transaction.update(groupsReference,{
                                              'quantityOfProductsInGroups' : groupsTransaction['quantityOfProductsInGroups'] - totalProducts,
                                            });

                                            transaction.update(salesReference,{
                                              'totalPriceProducts' :
                                              (totalProducts * newPriceProduct) + widget.totalPriceProducts ,
                                              'productUnits' : totalProducts + widget.productUnits ,
                                            });

                                            await FirebaseFirestore.instance
                                                .collection('Sales').doc(widget.salesId)
                                                .collection('ClientProducts').add({
                                              'groupId' : widget.groupId,
                                              'groupsCode' : widget.groupsCode,
                                              'groupsName' : widget.groupsName,
                                              'groupsSection' : widget.groupsSection,
                                              'groupsBrunch' : widget.groupsBrunch,
                                              'quantityOfProductsInGroups' : widget.quantityOfProductsInGroups,
                                              'dateOfArrivalGroup' : widget.dateOfArrivalGroup,

                                              'productId' : widget.productId,
                                              'productsCode' : widget.productsCode,
                                              'productsName' : widget.productsName,
                                              'productsSize' : widget.productsSize,
                                              'productsColor' : widget.productsColor,
                                              'productsPrice' : widget.productsPrice,
                                              'newPriceProduct' : newPriceProduct,
                                              'totalProducts' : totalProducts,
                                              'totalPrice' : totalProducts * newPriceProduct,

                                            });

                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
                                          }

                                        }
                                      } else{
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pop();
                                        AwesomeDialog(
                                          context : this.context,
                                          title: 'كميه المنتج',
                                          animType: AnimType.rightSlide,
                                          body: const Text('يبدو بأن كميه المنتج قد نفذت'),
                                          dialogType: DialogType.warning,
                                          // btnCancelOnPress: () {},
                                          btnOkOnPress: () {},
                                        ).show();
                                      }

                                    });
                                    /// #####################


                                    /// @@@@@@@@@@@@    OLD CODE
                                    // // ignore: avoid_print
                                    // if(productSnap['quantityOfProducts'] <= 0){print('error');}
                                    //
                                    // if(productSnap['quantityOfProducts'] > 0){
                                    //   // ignore: avoid_print
                                    //   print('correct');
                                    //
                                    //   if(productSnap['quantityOfProducts'] - totalProducts > 0){
                                    //
                                    //     await FirebaseFirestore.instance
                                    //         .collection('Groups').doc(widget.groupId)
                                    //         .collection('Products').doc(widget.productId).update({
                                    //       'quantityOfProducts' : productSnap['quantityOfProducts'] - totalProducts,
                                    //     });
                                    //
                                    //     await FirebaseFirestore.instance
                                    //         .collection('Groups').doc(widget.groupId).update({
                                    //       'quantityOfProductsInGroups' : asd['quantityOfProductsInGroups'] - totalProducts,
                                    //     });
                                    //
                                    //     await FirebaseFirestore.instance
                                    //         .collection('Sales').doc(widget.salesId).update({
                                    //       'totalPriceProducts' :
                                    //             (totalProducts * widget.productsPrice) + widget.totalPriceProducts ,
                                    //       'productUnits' : totalProducts + widget.productUnits ,
                                    //     });
                                    //
                                    //     await FirebaseFirestore.instance
                                    //         .collection('Sales').doc(widget.salesId)
                                    //         .collection('ClientProducts').add({
                                    //
                                    //       'groupId' : widget.groupId,
                                    //       'groupsCode' : widget.groupsCode,
                                    //       'groupsName' : widget.groupsName,
                                    //       'groupsSection' : widget.groupsSection,
                                    //       'groupsBrunch' : widget.groupsBrunch,
                                    //       'quantityOfProductsInGroups' : widget.quantityOfProductsInGroups,
                                    //       'dateOfArrivalGroup' : widget.dateOfArrivalGroup,
                                    //
                                    //       'productId' : widget.productId,
                                    //       'productsCode' : widget.productsCode,
                                    //       'productsName' : widget.productsName,
                                    //       'productsSize' : widget.productsSize,
                                    //       'productsColor' : widget.productsColor,
                                    //       'productsPrice' : widget.productsPrice,
                                    //       'totalProducts' : totalProducts,
                                    //       'totalPrice' : totalProducts * widget.productsPrice,
                                    //
                                    //     });
                                    //   }
                                    //
                                    //   if(productSnap['quantityOfProducts'] - totalProducts == 0) {
                                    //
                                    //     await FirebaseFirestore.instance
                                    //         .collection('Groups').doc(widget.groupId)
                                    //         .collection('Products').doc(widget.productId).delete();
                                    //
                                    //     await FirebaseFirestore.instance
                                    //         .collection('Groups').doc(widget.groupId).update({
                                    //       'quantityOfProductsInGroups' : asd['quantityOfProductsInGroups'] - totalProducts,
                                    //     });
                                    //
                                    //     await FirebaseFirestore.instance
                                    //         .collection('Sales').doc(widget.salesId).update({
                                    //       'totalPriceProducts' :
                                    //           (totalProducts * widget.productsPrice) + widget.totalPriceProducts ,
                                    //       'productUnits' : totalProducts + widget.productUnits ,
                                    //     });
                                    //
                                    //     await FirebaseFirestore.instance
                                    //         .collection('Sales').doc(widget.salesId)
                                    //         .collection('ClientProducts').add({
                                    //       'groupId' : widget.groupId,
                                    //       'groupsCode' : widget.groupsCode,
                                    //       'groupsName' : widget.groupsName,
                                    //       'groupsSection' : widget.groupsSection,
                                    //       'groupsBrunch' : widget.groupsBrunch,
                                    //       'quantityOfProductsInGroups' : widget.quantityOfProductsInGroups,
                                    //       'dateOfArrivalGroup' : widget.dateOfArrivalGroup,
                                    //
                                    //       'productId' : widget.productId,
                                    //       'productsCode' : widget.productsCode,
                                    //       'productsName' : widget.productsName,
                                    //       'productsSize' : widget.productsSize,
                                    //       'productsColor' : widget.productsColor,
                                    //       'productsPrice' : widget.productsPrice,
                                    //       'totalProducts' : totalProducts,
                                    //       'totalPrice' : totalProducts * widget.productsPrice,
                                    //
                                    //     });
                                    //   }
                                    // }
                                    /// @@@@@@@@@@@@@


                                  } else {
                                    // // ignore: use_build_context_synchronously
                                    // Navigator.of(context).pop();
                                    AwesomeDialog(
                                      context : this.context,
                                      title: 'خطأ3',
                                      animType: AnimType.rightSlide,
                                      body: const Text('يبدو بأن هناك شئ خاطئ3(أثناء تحديد الكميه أو سعر المنتج)'),
                                      dialogType: DialogType.error,
                                      // btnCancelOnPress: () {},
                                      btnOkOnPress: () {},
                                    ).show();
                                  }
                                },
                                // color: Colors.blue,
                                child: const Text(
                                  'إضافه إلي العميل',
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
