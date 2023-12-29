import 'package:auto_size_text/auto_size_text.dart';
import 'package:el_attar_windows/screens/login.dart';
// import 'package:el_attar_windows/screens/manager/employees/employees.dart';
// import 'package:el_attar_windows/screens/manager/groups/groups.dart';
// import 'package:el_attar_windows/screens/manager/info_clients/clients.dart';
// import 'package:elattar/screens/manager/products/product.dart';
// import 'package:el_attar_windows/screens/manager/returns/returns.dart';
// import 'package:el_attar_windows/screens/manager/sales/sales.dart';
// import 'package:elattar/screens/manager/suppliers/suppliers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeManager extends StatefulWidget {
  const HomeManager({Key? key}) : super(key: key);
  static String id = 'HomeManager';

  @override
  State<HomeManager> createState() => _HomeManagerState();
}

class _HomeManagerState extends State<HomeManager> {
  @override
  Widget build(BuildContext context) {
    // var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'El Ataar',
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
        // leading: null,
        leading: IconButton(
          onPressed: () async{
            await FirebaseAuth.instance.signOut();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushNamedAndRemoveUntil(Login.id, (route) => false);
          },
          icon: const Icon(
            Icons.output,
            color: Colors.black,
          ),
        ),
      ),
      body:
      // SingleChildScrollView(
      // child:
      GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.8,
        ),
        children: <Widget>[
          const SizedBox(height: 70,),
          const SizedBox(height: 70,),
          // _widget('المنتجات', (){Navigator.pushNamed(context, Product.id);}),
          _widget('الفواتير', (){
            // Navigator.pushNamed(context, Returns.id);
          }),
          _widget('الأصناف', (){
            // Navigator.pushNamed(context, Groups.id);
          }),
          // _widget('موردين', (){Navigator.pushNamed(context, Suppliers.id);}),
          _widget('مبيعات', (){
            // Navigator.pushNamed(context, Sales.id);
          }),
          // const SizedBox(),
          _widget('موظفين', (){
            // Navigator.pushNamed(context, Employees.id);
          }),
          _widget('العملاء', (){
            // Navigator.pushNamed(context, Clients.id);
          }),

        ],
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

  _widget(String name, tap){
    var asd = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: asd * .01,
        right: asd * .01,
        top: 20,
      ),
      child: InkWell(
        onTap: tap,
        child: Container(
          // height: MediaQuery.of(context).size.height * .10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.0),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Center(
            child: AutoSizeText(
              name,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
              minFontSize: 10,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }

}
