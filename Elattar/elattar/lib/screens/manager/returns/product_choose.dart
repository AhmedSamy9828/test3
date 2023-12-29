import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductChoose extends StatefulWidget {
  const ProductChoose({Key?key,
    required this.salesId,

    required this.moderatorName,
    required this.moderatorId,
    required this.clientName,
    required this.clientGovernorate,
    required this.clientAddress,
    required this.clientNumber,
    required this.orderDate,
    required this.dateRegistration,
    required this.status,
    required this.notice,
    required this.invoiceNumber,

    required this.clientProductsId,

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
    required this.totalProducts,
    required this.productsPrice,
    required this.newPriceProduct,
  }) : super(key: key);

  final String salesId;

  final String moderatorName;
  final String moderatorId;

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

  final String clientProductsId;

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
  final int totalProducts;
  final int productsPrice;
  final int newPriceProduct;

  static String id = 'ProductChoose';

  @override
  State<ProductChoose> createState() => _ProductChooseState();
}

class _ProductChooseState extends State<ProductChoose> {

  late int totalProducts;
  late DateTime dateRegistrationBack = DateTime.now();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // final int totalPriceProducts;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تحديد الكميه',
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
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: const Text('كود المنتج', style: TextStyle(color: Colors.black),),
                        subtitle: Text(widget.productsCode, style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: const Text('إسم المنتج', style: TextStyle(color: Colors.black),),
                        subtitle: Text(widget.productsName, style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: const Text('مقاس المنتج', style: TextStyle(color: Colors.black),),
                        subtitle: Text(widget.productsSize, style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: const Text('لون المنتج', style: TextStyle(color: Colors.black),),
                        subtitle: Text(widget.productsColor, style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: const Text('كميه المنتجات', style: TextStyle(color: Colors.black),),
                        subtitle: Text('${widget.totalProducts}', style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: const Text('سعر المنتج', style: TextStyle(color: Colors.black),),
                        subtitle: Text('${widget.productsPrice}', style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: const Text('سعر البيع', style: TextStyle(color: Colors.black),),
                        subtitle: Text('${widget.newPriceProduct}', style: const TextStyle(color: Colors.red),),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child:TextFormField(
                        // initialValue: ('${widget.totalProducts}'),
                        keyboardType: TextInputType.number,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل كميه المنتج المرتجعه';
                          }
                          int? n = int.tryParse(value);
                          if(n == null) {
                            return '"$value" is not a valid number';
                          }
                          if( n > widget.totalProducts) {
                            return 'كميه المنتجات أكبر من عدد المنتجات داخل الفاتوره ';
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
                          labelText: 'كميه المنتجات المرتجعه',
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


                                    DocumentSnapshot groupsCheck = await FirebaseFirestore.instance
                                        .collection('Groups').doc(widget.groupId).get();
                                    DocumentReference groupsReference = FirebaseFirestore.instance
                                        .collection('Groups').doc(widget.groupId);
                                    DocumentSnapshot productsCheck = await FirebaseFirestore.instance
                                        .collection('Groups').doc(widget.groupId)
                                        .collection('Products').doc(widget.productId).get();
                                    DocumentReference productsReference =  FirebaseFirestore.instance
                                        .collection('Groups').doc(widget.groupId)
                                        .collection('Products').doc(widget.productId);
                                    DocumentSnapshot returnsCheck = await FirebaseFirestore.instance
                                        .collection('Returns').doc(widget.salesId).get();
                                    DocumentReference returnsReference = FirebaseFirestore.instance
                                        .collection('Returns').doc(widget.salesId);
                                    DocumentSnapshot salesCheck = await FirebaseFirestore.instance
                                        .collection('Sales').doc(widget.salesId).get();
                                    DocumentReference salesReference = FirebaseFirestore.instance
                                        .collection('Sales').doc(widget.salesId);
                                    DocumentSnapshot clientProductsCheck = await FirebaseFirestore.instance
                                        .collection('Sales').doc(widget.salesId)
                                        .collection('ClientProducts').doc(widget.clientProductsId).get();
                                    DocumentReference clientProductsCheckReference = FirebaseFirestore.instance
                                        .collection('Sales').doc(widget.salesId)
                                        .collection('ClientProducts').doc(widget.clientProductsId);
                                    DocumentSnapshot clientProductsReturns = await FirebaseFirestore.instance
                                        .collection('Returns').doc(widget.salesId)
                                        .collection('ClientProducts').doc(widget.clientProductsId).get();
                                    DocumentReference clientProductsReturnsReference = FirebaseFirestore.instance
                                        .collection('Returns').doc(widget.salesId)
                                        .collection('ClientProducts').doc(widget.clientProductsId);

                                    /// ##################  TEST
                                    await FirebaseFirestore.instance.runTransaction((transaction) async {
                                      DocumentSnapshot groupsTransaction = await transaction.get(groupsReference);
                                      DocumentSnapshot productsTransaction = await transaction.get(productsReference);
                                      DocumentSnapshot returnsTransaction = await transaction.get(returnsReference);
                                      // DocumentSnapshot salesTransaction = await transaction.get(salesReference);
                                      // DocumentSnapshot clientProductsCheckTransaction = await transaction.get(clientProductsCheckReference);
                                      DocumentSnapshot clientProductsReturnsTransaction = await transaction.get(clientProductsReturnsReference);

                                      if(groupsTransaction.exists){
                                        if(productsTransaction.exists){
                                          transaction.update(productsReference, {
                                            'quantityOfProducts' : productsCheck['quantityOfProducts'] + totalProducts,
                                          });
                                          transaction.update(groupsReference, {
                                            'quantityOfProductsInGroups' : groupsCheck['quantityOfProductsInGroups'] + totalProducts,
                                          });
                                        }else{
                                          transaction.set(productsReference, {
                                            'groupsId' : widget.groupId,
                                            'dateOfArrivalGroup' : widget.dateOfArrivalGroup,

                                            'productsCode' : widget.productsCode,
                                            'productsName' : widget.productsName,
                                            'productsSize' : widget.productsSize,
                                            'productsColor' : widget.productsColor,
                                            'quantityOfProducts' : totalProducts,
                                            'productsPrice' : widget.productsPrice,
                                          },SetOptions(merge: true));
                                          transaction.update(groupsReference, {
                                            'quantityOfProductsInGroups' :
                                            groupsCheck['quantityOfProductsInGroups'] + totalProducts,
                                          });
                                        }
                                      } else{
                                        transaction.set(groupsReference, {
                                          'groupsCode' : widget.groupsCode,
                                          'groupsName' : widget.groupsName,
                                          'groupsSection' : widget.groupsSection,
                                          'groupsBrunch' : widget.groupsBrunch,
                                          'quantityOfProductsInGroups' : totalProducts,
                                          'dateOfArrivalGroup' : widget.dateOfArrivalGroup,
                                        },SetOptions(merge: true));
                                        transaction.set(productsReference, {
                                          'groupsId' : widget.groupId,
                                          'dateOfArrivalGroup' :widget.dateOfArrivalGroup,

                                          'productsCode' : widget.productsCode,
                                          'productsName' : widget.productsName,
                                          'productsSize' : widget.productsSize,
                                          'productsColor' : widget.productsColor,
                                          'quantityOfProducts' : totalProducts,
                                          'productsPrice' : widget.productsPrice,
                                        },SetOptions(merge: true));
                                      }

                                      if(returnsTransaction.exists){
                                        if(clientProductsReturnsTransaction.exists){
                                          transaction.update(clientProductsReturnsReference, {
                                            'totalProducts' : clientProductsReturns['totalProducts'] + totalProducts,
                                            'totalPrice' : clientProductsReturns['totalPrice']
                                                + (clientProductsReturns['productsPrice'] * totalProducts ) ,
                                          });
                                          transaction.update(returnsReference, {
                                            'productUnits' : returnsCheck['productUnits'] + totalProducts,
                                            'totalPriceProducts' : returnsCheck['totalPriceProducts']
                                                + (clientProductsReturns['productsPrice'] * totalProducts ) ,
                                          });
                                        }else{
                                          transaction.set(clientProductsReturnsReference, {
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
                                            'newPriceProduct' : widget.newPriceProduct,
                                            'totalProducts' : totalProducts,
                                            'totalPrice' : totalProducts * widget.productsPrice,
                                          },SetOptions(merge: true));
                                          transaction.update(returnsReference, {
                                            'productUnits' : returnsCheck['productUnits'] + totalProducts,
                                            'totalPriceProducts' :
                                            returnsCheck['totalPriceProducts'] + (widget.productsPrice * totalProducts ) ,
                                          });
                                        }
                                      } else{
                                        transaction.set(returnsReference, {
                                          'clientName' : widget.clientName,
                                          'clientGovernorate' : widget.clientGovernorate,
                                          'clientAddress' : widget.clientAddress,
                                          'clientNumber' : widget.clientNumber,

                                          'totalPriceProducts' : totalProducts * widget.productsPrice,
                                          'productUnits' : totalProducts,
                                          'orderDate' : widget.orderDate,
                                          'dateRegistration' : widget.dateRegistration,
                                          'dateRegistrationBack' : dateRegistrationBack,
                                          'status' : widget.status,
                                          'notice' : widget.notice,
                                          'invoiceNumber' : widget.invoiceNumber,

                                          'moderatorId' : widget.moderatorId,
                                          'moderatorName' : widget.moderatorName,
                                        },SetOptions(merge: true));
                                        transaction.set(clientProductsReturnsReference, {
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
                                          'totalProducts' : totalProducts,
                                          'totalPrice' : totalProducts * widget.productsPrice,
                                        },SetOptions(merge: true));
                                      }

                                      transaction.update(clientProductsCheckReference, {
                                        'totalProducts' : clientProductsCheck['totalProducts'] - totalProducts,
                                        'totalPrice' : clientProductsCheck['totalPrice']
                                            - (clientProductsCheck['newPriceProduct'] * totalProducts ) ,
                                      });
                                      transaction.update(salesReference, {
                                        'productUnits' : salesCheck['productUnits'] - totalProducts,
                                        'totalPriceProducts' : salesCheck['totalPriceProducts']
                                            - (clientProductsCheck['newPriceProduct'] * totalProducts ),
                                      });

                                    });
                                    /// #####################

                                    // /// ####### ADD TO GROUPS  ###############
                                    // // DocumentSnapshot groupsCheck = await FirebaseFirestore.instance
                                    // //     .collection('Groups').doc(widget.groupId).get();
                                    // if(groupsCheck.exists == true) {
                                    //   DocumentSnapshot productsCheck = await FirebaseFirestore.instance
                                    //       .collection('Groups').doc(widget.groupId)
                                    //       .collection('Products').doc(widget.productId).get();
                                    //   if(productsCheck.exists == true){
                                    //     // await FirebaseFirestore.instance
                                    //     //     .collection('Groups').doc(widget.groupId)
                                    //     //     .collection('Products').doc(widget.productId).update({
                                    //     //   'quantityOfProducts' : productsCheck['quantityOfProducts'] + totalProducts,
                                    //     // });
                                    //     // await FirebaseFirestore.instance
                                    //     //     .collection('Groups').doc(widget.groupId).update({
                                    //     //   'quantityOfProductsInGroups' : groupsCheck['quantityOfProductsInGroups'] + totalProducts,
                                    //     // });
                                    //   }
                                    //   if(productsCheck.exists == false){
                                    //     // await FirebaseFirestore.instance
                                    //     //     .collection('Groups').doc(widget.groupId)
                                    //     //     .collection('Products').doc(widget.productId).set({
                                    //     //   'groupsId' : widget.groupId,
                                    //     //   'dateOfArrivalGroup' : widget.dateOfArrivalGroup,
                                    //     //
                                    //     //   'productsCode' : widget.productsCode,
                                    //     //   'productsName' : widget.productsName,
                                    //     //   'productsSize' : widget.productsSize,
                                    //     //   'productsColor' : widget.productsColor,
                                    //     //   'quantityOfProducts' : totalProducts,
                                    //     //   'productsPrice' : widget.productsPrice,
                                    //     // },SetOptions(merge: true));
                                    //     // await FirebaseFirestore.instance
                                    //     //     .collection('Groups').doc(widget.groupId).update({
                                    //     //   'quantityOfProductsInGroups' :
                                    //     //         groupsCheck['quantityOfProductsInGroups'] + totalProducts,
                                    //     // });
                                    //   }
                                    //
                                    // }
                                    // if(groupsCheck.exists == false) {
                                    //   // await FirebaseFirestore.instance
                                    //   //     .collection('Groups').doc(widget.groupId).set({
                                    //   //   'groupsCode' : widget.groupsCode,
                                    //   //   'groupsName' : widget.groupsName,
                                    //   //   'groupsSection' : widget.groupsSection,
                                    //   //   'groupsBrunch' : widget.groupsBrunch,
                                    //   //   'quantityOfProductsInGroups' : totalProducts,
                                    //   //   'dateOfArrivalGroup' : widget.dateOfArrivalGroup,
                                    //   // },SetOptions(merge: true));
                                    //   // await FirebaseFirestore.instance
                                    //   //     .collection('Groups').doc(widget.groupId)
                                    //   //     .collection('Products').doc(widget.productId).set({
                                    //   //   'groupsId' : widget.groupId,
                                    //   //   'dateOfArrivalGroup' :widget.dateOfArrivalGroup,
                                    //   //
                                    //   //   'productsCode' : widget.productsCode,
                                    //   //   'productsName' : widget.productsName,
                                    //   //   'productsSize' : widget.productsSize,
                                    //   //   'productsColor' : widget.productsColor,
                                    //   //   'quantityOfProducts' : totalProducts,
                                    //   //   'productsPrice' : widget.productsPrice,
                                    //   // },SetOptions(merge: true));
                                    // }
                                    // /// ####### END GROUPS  ###################
                                    //
                                    // /// ########  ADD TO RETURNS ##############
                                    // if(returnsCheck.exists == true) {
                                    //   DocumentSnapshot clientProductsCheck = await FirebaseFirestore.instance
                                    //       .collection('Returns').doc(widget.salesId)
                                    //       .collection('ClientProducts').doc(widget.clientProductsId).get();
                                    //   if(clientProductsCheck.exists == true){
                                    //     // await FirebaseFirestore.instance
                                    //     //     .collection('Returns').doc(widget.salesId)
                                    //     //     .collection('ClientProducts').doc(widget.clientProductsId).update({
                                    //     //   'totalProducts' : clientProductsCheck['totalProducts'] + totalProducts,
                                    //     //   'totalPrice' : clientProductsCheck['totalPrice']
                                    //     //       + (clientProductsCheck['productsPrice'] * totalProducts ) ,
                                    //     // });
                                    //     // await FirebaseFirestore.instance
                                    //     //     .collection('Returns').doc(widget.salesId).update({
                                    //     //   'productUnits' : returnsCheck['productUnits'] + totalProducts,
                                    //     //   'totalPriceProducts' : returnsCheck['totalPriceProducts']
                                    //     //       + (clientProductsCheck['productsPrice'] * totalProducts ) ,
                                    //     // });
                                    //   }
                                    //
                                    //   if(clientProductsCheck.exists == false){
                                    //     // await FirebaseFirestore.instance
                                    //     //     .collection('Returns').doc(widget.salesId)
                                    //     //     .collection('ClientProducts').doc(widget.clientProductsId).set({
                                    //     //   'groupId' : widget.groupId,
                                    //     //   'groupsCode' : widget.groupsCode,
                                    //     //   'groupsName' : widget.groupsName,
                                    //     //   'groupsSection' : widget.groupsSection,
                                    //     //   'groupsBrunch' : widget.groupsBrunch,
                                    //     //   'quantityOfProductsInGroups' : widget.quantityOfProductsInGroups,
                                    //     //   'dateOfArrivalGroup' : widget.dateOfArrivalGroup,
                                    //     //
                                    //     //   'productId' : widget.productId,
                                    //     //   'productsCode' : widget.productsCode,
                                    //     //   'productsName' : widget.productsName,
                                    //     //   'productsSize' : widget.productsSize,
                                    //     //   'productsColor' : widget.productsColor,
                                    //     //   'productsPrice' : widget.productsPrice,
                                    //     //   'totalProducts' : totalProducts,
                                    //     //   'totalPrice' : totalProducts * widget.productsPrice,
                                    //     // },SetOptions(merge: true));
                                    //     // await FirebaseFirestore.instance
                                    //     //     .collection('Returns').doc(widget.salesId).update({
                                    //     //   'productUnits' : returnsCheck['productUnits'] + totalProducts,
                                    //     //   'totalPriceProducts' :
                                    //     //     returnsCheck['totalPriceProducts'] + (widget.productsPrice * totalProducts ) ,
                                    //     // });
                                    //   }
                                    // }
                                    // if(returnsCheck.exists == false) {
                                    //   // await FirebaseFirestore.instance
                                    //   //     .collection('Returns').doc(widget.salesId).set({
                                    //   //   'clientName' : widget.clientName,
                                    //   //   'clientGovernorate' : widget.clientGovernorate,
                                    //   //   'clientAddress' : widget.clientAddress,
                                    //   //   'clientNumber' : widget.clientNumber,
                                    //   //
                                    //   //   'totalPriceProducts' : totalProducts * widget.productsPrice,
                                    //   //   'productUnits' : totalProducts,
                                    //   //   'orderDate' : widget.orderDate,
                                    //   //
                                    //   //   'moderatorId' : widget.moderatorId,
                                    //   //   'moderatorName' : widget.moderatorName,
                                    //   //
                                    //   // },SetOptions(merge: true));
                                    //   // await FirebaseFirestore.instance
                                    //   //     .collection('Returns').doc(widget.salesId)
                                    //   //     .collection('ClientProducts').doc(widget.clientProductsId).set({
                                    //   //   'groupId' : widget.groupId,
                                    //   //   'groupsCode' : widget.groupsCode,
                                    //   //   'groupsName' : widget.groupsName,
                                    //   //   'groupsSection' : widget.groupsSection,
                                    //   //   'groupsBrunch' : widget.groupsBrunch,
                                    //   //   'quantityOfProductsInGroups' : widget.quantityOfProductsInGroups,
                                    //   //   'dateOfArrivalGroup' : widget.dateOfArrivalGroup,
                                    //   //
                                    //   //   'productId' : widget.productId,
                                    //   //   'productsCode' : widget.productsCode,
                                    //   //   'productsName' : widget.productsName,
                                    //   //   'productsSize' : widget.productsSize,
                                    //   //   'productsColor' : widget.productsColor,
                                    //   //   'productsPrice' : widget.productsPrice,
                                    //   //   'totalProducts' : totalProducts,
                                    //   //   'totalPrice' : totalProducts * widget.productsPrice,
                                    //   // },SetOptions(merge: true));
                                    // }
                                    // /// ######## END RETURNS ################
                                    //
                                    // /// ######## REMOVE TO CHECK ############
                                    // // DocumentSnapshot salesCheck = await FirebaseFirestore.instance
                                    // //     .collection('Sales').doc(widget.salesId).get();
                                    // //   DocumentSnapshot clientProductsCheck = await FirebaseFirestore.instance
                                    // //       .collection('Sales').doc(widget.salesId)
                                    // //       .collection('ClientProducts').doc(widget.clientProductsId).get();
                                    //     await FirebaseFirestore.instance
                                    //         .collection('Sales').doc(widget.salesId)
                                    //         .collection('ClientProducts').doc(widget.clientProductsId).update({
                                    //       'totalProducts' : clientProductsCheck['totalProducts'] - totalProducts,
                                    //       'totalPrice' : clientProductsCheck['totalPrice']
                                    //           - (clientProductsCheck['productsPrice'] * totalProducts ) ,
                                    //     });
                                    //     await FirebaseFirestore.instance
                                    //         .collection('Sales').doc(widget.salesId).update({
                                    //       'productUnits' : salesCheck['productUnits'] - totalProducts,
                                    //       'totalPriceProducts' : salesCheck['totalPriceProducts']
                                    //           - (clientProductsCheck['productsPrice'] * totalProducts ),
                                    //     });
                                    // /// ######## END CHECK  #################

                                    ///   OLD
                                    // var zxc = await FirebaseFirestore.instance
                                    //     .collection('Groups').doc(widget.groupId)
                                    //     .collection('Products').doc(widget.productId).get();
                                    //
                                    // var asd = await FirebaseFirestore.instance
                                    //     .collection('Groups').doc(widget.groupId).get();
                                    //
                                    // // ignore: avoid_print
                                    // if(zxc['quantityOfProducts'] <= 0){print('error');}
                                    //
                                    // if(zxc['quantityOfProducts'] > 0){
                                    //   // ignore: avoid_print
                                    //   print('correct');
                                    //
                                    //   if(zxc['quantityOfProducts'] - totalProducts > 0){
                                    //
                                    //     await FirebaseFirestore.instance
                                    //         .collection('Groups').doc(widget.groupId)
                                    //         .collection('Products').doc(widget.productId).update({
                                    //       'quantityOfProducts' : zxc['quantityOfProducts'] - totalProducts,
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
                                    //       (totalProducts * widget.productsPrice) + widget.totalPriceProducts ,
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
                                    //   if(zxc['quantityOfProducts'] - totalProducts == 0) {
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
                                    //       (totalProducts * widget.productsPrice) + widget.totalPriceProducts ,
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
                                    // }



                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();Navigator.of(context).pop();Navigator.of(context).pop();

                                  } else {}
                                },
                                // color: Colors.blue,
                                child: const Text(
                                  'إضافه إلي المرتجعات',
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
