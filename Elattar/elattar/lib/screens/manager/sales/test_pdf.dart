import 'dart:io';
import 'package:elattar/pdf/api/api_pdf.dart';
import 'package:elattar/pdf/model/boll.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class TestPdf{
  static late Font arFont;
  static initA() async {
    arFont = Font.ttf((await rootBundle.load('fonts/Hacen Tunisia.ttf')));
  }

  static Future<File> generatePdf(Boll boll) async {
    final pdf = Document();

    // ################
    pdf.addPage(
      MultiPage(
          textDirection: TextDirection.rtl,
          theme: ThemeData.withFont(
            base: arFont,
          ),
          build: (context) => [
            buildHeader(boll),

            SizedBox(height: 50),

            // buildInvoice(boll),

            buildInvoiceABC(boll),


            SizedBox(height: 5),

            buildTotalPrice(boll),
            // SizedBox(height: 200),
            // buildFooter(boll),
          ],
        footer: (context) => buildFooter(boll),
      )
    );

    return ApiPdf.saveDocument(name: '${DateTime.now()}.pdf', pdf: pdf);
  }

  static Widget buildHeader(Boll boll) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Text(
          boll.info.factory,
          style: const TextStyle(fontSize: 40),
        ),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(boll.info.moderatorName,),
                      Text(boll.info.orderDate),
                      Text(boll.info.invoiceNumber),
                    ]
                  ),
                ]
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(boll.info.clientName),
                      Text(boll.info.clientGovernorate),
                      Text(boll.info.clientAddress),
                      Text(boll.info.clientNumber),
                    ]
                  ),
                ]
              ),
            ],
          ),
        ],
      ),
    ],
  );

  // static Widget buildInvoice(Boll boll) {
  //   final headers = ['إجمالي السعر','سعر المنتج','الكميه من المنتج','إسم المنتج','كود المنتج',];
  //   final data = boll.items.map((item) {
  //     return [
  //       item.totalPrice,
  //       item.price,
  //       item.num,
  //       item.name,
  //       item.code,
  //     ];
  //   }).toList();
  //
  //   return Table.fromTextArray(
  //     headers: headers,
  //     data: data,
  //     border: TableBorder.all(),
  //     // headerStyle: TextStyle.defaultStyle(),
  //     headerDecoration: const BoxDecoration(color: PdfColors.grey300),
  //     cellHeight: 30,
  //     cellAlignments: {
  //       0: Alignment.centerLeft,
  //       1: Alignment.centerRight,
  //       2: Alignment.centerRight,
  //       3: Alignment.centerRight,
  //       4: Alignment.centerRight,
  //       5: Alignment.centerRight,
  //     },
  //   );
  // }

  // %%%%%%%%%%%%% TEST

  //
  // List<List<dynamic>> qwe= [
  //
  // ];
  // var asd = FirebaseFirestore.instance.collection('Sales').doc('widget.salesId')
  //     .collection('buyerProducts').get()
  //     .then((QuerySnapshot querySnapshot) async {
  //   // ignore: avoid_function_literals_in_foreach_calls
  //   querySnapshot.docs.forEach((element) async {
  //     qwe.add(element.get()).toList();
  //   });
  // });
  //
  // final data  = qwe;
  // = boll.userModel.toJson()((item) {
  //   return [
  //     item.code,
  //     item.name,
  //     item.num,
  //     item.price,
  //     item.totalPrice,
  //   ];
  // }).toList();


  //

  static Widget buildInvoiceABC(Boll boll) {
    // List list;
    // FirebaseFirestore.instance.collection('Sales').doc('u09Atjv1OWokuVHrNbaB')
    //     .collection('buyerProducts').get()
    //     .then((QuerySnapshot querySnapshot) async {
      // ignore: avoid_function_literals_in_foreach_calls
      // querySnapshot.docs.forEach((element) async {
        // setState((
        //
        // ));
        // List list= [
        //   element['productCode'],
        //   element['productName'],
        //   element['productsQuantity'],
        //   element['productPrice'],
        //   element['totalPrice'],
        // ];
        // print(element.data());
        // print(asd);
      // });
    // });

    // List productCode;
    // List productName;
    // List productsQuantity;
    // List productPrice;
    // List totalPrice;

    // List zxc = [];

    // List<List<dynamic>> qwe = [
    //   [['qwe',zxc], ['kjkl', ' iojjljn']],
    //   zxc,
    //   ['789'],
    //   ['qwe'],
    //   ['asd'],
    //   [['adfdsdafvsdfasf'],['sdfasdfsdfsdf'],['asdfaasdfsdafsdf'],['asfaasdfadfasdfsdf'],['asdfasdf']],
    // ];

    final headers = ['الإجمالي','السعر','الكميه','الإسم','الكود',];
    // final data = boll.userModel.toJson().map((item) {
    //   return [
    //     item.code,
    //     item.name,
    //     item.num,
    //     item.price,
    //     item.totalPrice,
    //   ];
    // }).toList();

    // final date = [];

    final date = boll.asd;
    return Table.fromTextArray(
      headers: headers,
      data: date,
      // [
      //   ['1','2','3''4','5'],
      //   ['1','2','3''4','5'],
      //   ['1','2','3''4','5'],
      //   ['1','2','3''4','5'],
      // ],
      border: TableBorder.all(),
      // headerStyle: TextStyle.defaultStyle(),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }



  // %%%%%%%%%%%%% TEST


  // %%%%%%%%%%%%%

  static Widget buildTotalPrice(Boll boll) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('',),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Text('  عدد المنتجات  {${boll.info.productUnits} } '),
                        Text(' إجمالي الفاتوره {${boll.info.totalPriceProducts}}'),
                      ]
                    )
                  ]
              ),
              // Directionality(textDirection: TextDirection.rtl,
              //     child:
              // ),


            ],
          ),
        ],
      ),
    ],
  );

  static Widget buildFooter(Boll boll) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(boll.info.address),
                Text(' ${boll.info.number1} - ${boll.info.number2} '),
              ],
        ),
      ),

    ],
  );

  // #############

  static createPdf() async {
    String path = ( await getApplicationDocumentsDirectory()).path;
    File file = File('${path}billed.pdf');

   Document pdf = Document();
   pdf.addPage(_createPage());

   Uint8List bytes = await pdf.save();
   await file.writeAsBytes(bytes);
   await OpenFile.open(file.path);

  }

  static Page _createPage(){
    TableRow buildRow(List<String> cells,) =>
        TableRow (
      children: cells.map((cell) {
        return Padding(
          padding: const EdgeInsets.all(5),
          child: Center(
            child: Text(
              cell,
            ),
          ),
        );
        }).toList(),
    );
    return Page(
      pageFormat: PdfPageFormat.a4,
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(
          base: arFont,
        ),
        build: (context){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'مصنع MK',style: const TextStyle(fontSize: 40),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('إسم المسوق',),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('إسم العميل'),
                          Text('عنوان العميل ',),
                          Text('رقم العميل'),
                          Text('تاريخ الطلبيه',),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Table(
                    border: TableBorder.all(),
                    children:
                    [
                      buildRow(['كود المنتج','إسم المنتج','الكميه','السعر','إجمالي'],), // isHeader: true
                      buildRow(['123123','بدله','25','500','10000']),
                      buildRow(['1234','shirt','16','500','10000']),
                      buildRow(['324','بنطالون','100','500','10000']),
                      buildRow(['2342345','جاكت','19','500','10000']),
                    ],
                  ),

                ],
              ),
            ],
          );
    });
  }
}