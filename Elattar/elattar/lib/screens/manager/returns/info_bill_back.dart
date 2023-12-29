import 'package:flutter/material.dart';

class InfoBillBack extends StatefulWidget {
  const InfoBillBack({Key?key,
    required this.clientName,
    required this.clientGovernorate,
    required this.clientAddress,
    required this.clientNumber,
    required this.orderDate,

    required this.invoiceNumber,
    required this.notice,
    required this.status,
    required this.dateRegistration,
    required this.dateRegistrationBack,
    required this.moderatorName,
    required this.productUnits,
    required this.totalPriceProducts,
  }) : super(key: key);

  final String clientName;
  final String clientGovernorate;
  final String clientAddress;
  final String clientNumber;
  final String orderDate;

  final String invoiceNumber;
  final String notice;
  final String status;
  // ignore: prefer_typing_uninitialized_variables
  final  dateRegistration;
  // ignore: prefer_typing_uninitialized_variables
  final  dateRegistrationBack;
  final String moderatorName;
  final int productUnits;
  final int totalPriceProducts;

  static String id = 'InfoBillBack';

  @override
  State<InfoBillBack> createState() => _InfoBillBackState();
}

class _InfoBillBackState extends State<InfoBillBack> {

  @override
  Widget build(BuildContext context) {
    // final int totalPriceProducts;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تفاصيل الطلبيه',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 20,
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
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  const SizedBox(height: 5,),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      title: const Text('كود الفاتوره', style: TextStyle(color: Colors.black),),
                      subtitle: Text(widget.invoiceNumber, style: const TextStyle(color: Colors.red),),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      title: const Text('إسم العميل', style: TextStyle(color: Colors.black),),
                      subtitle: Text(widget.clientName, style: const TextStyle(color: Colors.red),),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      title: const Text('المحافظه', style: TextStyle(color: Colors.black),),
                      subtitle: Text(widget.clientGovernorate, style: const TextStyle(color: Colors.red),),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      title: const Text('العنوان', style: TextStyle(color: Colors.black),),
                      subtitle: Text(widget.clientAddress, style: const TextStyle(color: Colors.red),),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      title: const Text('رقم التليفون', style: TextStyle(color: Colors.black),),
                      subtitle: Text(widget.clientNumber, style: const TextStyle(color: Colors.red),),
                    ),
                  ),
                  // const SizedBox(height: 5,),
                  // Directionality(
                  //   textDirection: TextDirection.rtl,
                  //   child: ListTile(
                  //     title: const Text('تاريخ تسجيل الطلبيه', style: TextStyle(color: Colors.black),),
                  //     subtitle: Text(
                  //       timeago.format(DateTime.tryParse(widget.dateRegistration.toDate().toString())).toString(),
                  //       // '${widget.dateRegistration}',
                  //       style: const TextStyle(color: Colors.red),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 5,),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      title: const Text('تاريخ تسجيل الطلبيه', style: TextStyle(color: Colors.black),),
                      subtitle: Text(
                        '${widget.dateRegistration.toDate() }',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      title: const Text('تاريخ التسليم', style: TextStyle(color: Colors.black),),
                      subtitle: Text(widget.orderDate, style: const TextStyle(color: Colors.red),),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      title: const Text('تاريخ عوده الطلبيه', style: TextStyle(color: Colors.black),),
                      subtitle: Text(
                        '${widget.dateRegistrationBack.toDate() }',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      title: const Text('حاله الطلب', style: TextStyle(color: Colors.black),),
                      subtitle: Text(widget.status, style: const TextStyle(color: Colors.red),),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      title: const Text('الملاحظات', style: TextStyle(color: Colors.black),),
                      subtitle: Text(widget.notice, style: const TextStyle(color: Colors.red),),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      title: const Text('كميه المنتجات', style: TextStyle(color: Colors.black),),
                      subtitle: Text(
                        '${widget.productUnits}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      title: const Text('إجمالي السعر', style: TextStyle(color: Colors.black),),
                      subtitle: Text(
                        '${widget.totalPriceProducts}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ]
            ),
          ),
        ),

      ),
    );
  }
}
