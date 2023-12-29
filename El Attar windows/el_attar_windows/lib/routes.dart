// import 'package:elattar/pdf/test/testA.dart';
// import 'package:elattar/screens/login.dart';
// import 'package:elattar/screens/manager/employees/add_an_employee.dart';
// import 'package:elattar/screens/manager/employees/employee_profile.dart';
// import 'package:elattar/screens/manager/employees/employee_work_file.dart';
// import 'package:elattar/screens/manager/employees/employees.dart';
// import 'package:elattar/screens/manager/employees/sales_clint.dart';
// import 'package:elattar/screens/manager/groups/add_groups.dart';
// import 'package:elattar/screens/manager/groups/groups.dart';
// import 'package:elattar/screens/manager/groups/modify_groups.dart';
// import 'package:elattar/screens/manager/groups/products/add_products.dart';
// import 'package:elattar/screens/manager/groups/products/modify_a_products.dart';
// import 'package:elattar/screens/manager/groups/products/products.dart';
// import 'package:elattar/screens/manager/home_manager.dart';
// import 'package:elattar/screens/manager/returns/modify_return_product.dart';
// import 'package:elattar/screens/manager/sales/pdf_test.dart';
// import 'package:elattar/screens/manager/products/add_a_product.dart';
// import 'package:elattar/screens/manager/suppliers/modify_a_product.dart';
// import 'package:elattar/screens/manager/returns/product_return.dart';
// import 'package:elattar/screens/manager/products/product.dart';
// import 'package:elattar/screens/manager/returns/product_culling.dart';
// import 'package:elattar/screens/manager/returns/returns.dart';
// import 'package:elattar/screens/manager/sales/billed.dart';
// import 'package:elattar/screens/manager/sales/sales.dart';
// import 'package:elattar/screens/manager/sales/sold.dart';
// import 'package:elattar/screens/manager/suppliers/add_product.dart';
// import 'package:elattar/screens/manager/suppliers/add_group.dart';
// import 'package:elattar/screens/manager/suppliers/add_suppliers.dart';
// import 'package:elattar/screens/manager/suppliers/modify_boxes.dart';
// import 'package:elattar/screens/manager/suppliers/modify_group.dart';
// import 'package:elattar/screens/manager/suppliers/modify_supplier_data.dart';
// import 'package:elattar/screens/manager/suppliers/products.dart';
// import 'package:elattar/screens/manager/suppliers/group.dart';
// import 'package:elattar/screens/manager/suppliers/suppliers.dart';
// import 'package:elattar/screens/moderators/Send_The_Order.dart';
// import 'package:elattar/screens/moderators/add_client.dart';
// import 'package:elattar/screens/moderators/client.dart';
// import 'package:elattar/screens/moderators/home_moderators.dart';
// import 'package:elattar/screens/moderators/moderators_profile.dart';
// import 'package:elattar/screens/moderators/prepare_group.dart';
// import 'package:elattar/screens/moderators/prepare_product.dart';
// import 'package:elattar/screens/moderators/prepare_supplier.dart';
// import 'package:elattar/screens/moderators/product_selection.dart';
import 'package:el_attar_windows/screens/login.dart';
import 'package:el_attar_windows/screens/manager/home_manager.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>
{
  // HomeManager.id :(context) => const HomeManager(),
  Login.id :(context) => const Login(),
  HomeManager.id :(context) => const HomeManager(),

  // Suppliers.id :(context) => const Suppliers(),
  // AddSuppliers.id :(context) => const AddSuppliers(),
  // Group.id :(context) =>  const Group(suppliersId: '',supplierName: '',),
  // ModifySupplierData.id :(context) =>  const ModifySupplierData(suppliersId: ''),
  // AddGroup.id :(context) => const AddGroup(supplierName: '', suppliersId: '',),
  // ModifyBox.id :(context) => const ModifyBox(),
  // ModifyGroup.id :(context) => const ModifyGroup(
  //   supplierName: '', suppliersId: '',
  //   groupId: '', groupCode: '', groupName: '',
  //   groupSection: '', groupBrunch: '',
  //   numberOfProducts: 0,dateOfArrivalGroup: '',
  // ),
  // AddProduct.id :(context) => const AddProduct(
  //   suppliersId: '', supplierName: '', groupId: '', groupName: '',
  //   numberOfProducts: 0, dateOfArrivalGroup: '',
  // ),
  // // Products.id :(context) => const Products(
  // //   suppliersId: '', supplierName: '',
  // //   groupId: '', groupCode: '', groupName: '',
  // //   groupSection: '', groupBrunch: '',
  // //   numberOfProducts: 0,dateOfArrivalGroup: '',
  // // ),
  //
  // SalesClint.id :(context) => const SalesClint(salesId: '', moderatorsName: '', moderatorsId: '', totalPriceProducts: 0,),
  //
  //
  //
  // Employees.id :(context) => const Employees(),
  // AddAnEmployee.id :(context) => const AddAnEmployee(),
  // EmployeeProfile.id :(context) => const EmployeeProfile(
  //   moderatorId: '', moderatorName: '', moderatorPhone: '',
  //   moderatorNationId: '', moderatorEmail: '', moderatorPassword: '',
  // ),
  // EmployeeWorkFile.id :(context) => const EmployeeWorkFile(moderatorId: '',),
  //
  // ModifyReturnProduct.id :(context) => const ModifyReturnProduct(
  //   productId: '', productCode: '', productName: '', productSize: '', productColor: '',
  //   numberOfUnits: 0, productPrice: 0, image1: '', image2: '', image3: '',
  // ),
  //
  // // Product.id :(context) => const Product(),
  // // AddAProduct.id :(context) => const AddAProduct(),
  // ModifyAProduct.id :(context) => const ModifyAProduct(
  //   suppliersId: '',supplierName: '',groupId: '', groupName: '', numberOfProducts: 0,dateOfArrivalGroup: '',
  //   productId: '', productCode: '', productName: '', productSize: '', productColor: '',
  //   numberOfUnits: 0, productPrice: 0, image1: '', image2: '', image3: '',
  // ),
  //
  // PdfTest.id :(context) => const PdfTest(),
  // SfDataGridDemo.id :(context) => const SfDataGridDemo(),
  // Sales.id :(context) => const Sales(),
  // Billed.id :(context) => const Billed(salesId: '', moderatorsName: '', moderatorsId: '', totalPriceProducts: 0,),
  // // Sold.id :(context) => const Sold(),
  //
  // Returns.id :(context) => const Returns(),
  // ProductReturn.id :(context) => const ProductReturn(),
  // ProductCulling.id :(context) => const ProductCulling(),
  //
  // PrepareSupplier.id :(context) => const PrepareSupplier(
  //   clintId: '', clintName: '', clintAddress: '', clintNumber: '', totalPriceProducts: 0,
  // ),
  // PrepareGroup.id :(context) => const PrepareGroup(
  //   clintId: '', clintName: '', clintAddress: '',totalPriceProducts: 0,
  //   clintNumber: '', suppliersId: '', supplierName: '',
  // ),
  // PrepareProduct.id :(context) => const PrepareProduct(
  //   clintId: '', clintName: '', clintAddress: '',totalPriceProducts: 0,
  //   clintNumber: '', suppliersId: '', supplierName: '',
  //   groupId: '', groupCode: '', groupName: '', groupSection: '', groupBrunch: '',
  //   numberOfProducts: 0, dateOfArrivalGroup: '',
  // ),
  // ProductSelection.id :(context) => const ProductSelection(
  //   clintId: '', clintName: '', clintAddress: '',totalPriceProducts: 0,
  //   clintNumber: '', suppliersId: '', supplierName: '',
  //   groupId: '', groupCode: '', groupName: '', groupSection: '', groupBrunch: '',
  //   numberOfProducts: 0, dateOfArrivalGroup: '',
  //   productId: '', productCode: '', productName: '', productSize: '', productColor: '',
  //   numberOfUnits: 0, productPrice: 0, image1: '', image2: '', image3: '',
  //
  // ),
  //
  //
  // HomeModerators.id :(context) => const HomeModerators(),
  // ModeratorsProfile.id :(context) => const ModeratorsProfile(),
  // // Client.id :(context) => const Client(),
  // AddClient.id :(context) => const AddClient(),
  // SendTheOrder.id :(context) => const SendTheOrder(
  //   clintId: '', clintName: '', clintAddress: '', clintNumber: '',totalPriceProducts: 0,
  // ),
  //
  //
  // // ################
  //
  // Groups.id :(context) => const Groups(),
  // AddGroups.id :(context) => const AddGroups(),
  // ModifyGroups.id :(context) => const ModifyGroups(
  //   groupsId: '', groupsCode: '', groupsName: '', groupsSection: '', groupsBrunch: '',
  //   quantityOfProductsInGroups: 0, dateOfArrivalGroup: '',
  // ),
  //
  // Products.id :(context) => const Products(
  //   groupsId: '', groupsCode: '', groupsName: '',
  //   groupsSection: '', groupsBrunch: '',
  //   quantityOfProductsInGroups: 0,dateOfArrivalGroup: '',
  // ),
  // AddProducts.id :(context) => const AddProducts(
  //   groupsId: '', groupsName: '',
  //   quantityOfProductsInGroups: 0, dateOfArrivalGroup: '',
  // ),
  // ModifyAProducts.id :(context) => const ModifyAProducts(
  //   groupsId: '', groupsName: '', quantityOfProductsInGroups: 0,dateOfArrivalGroup: '',
  //   productsId: '', productsCode: '', productsName: '', productsSize: '', productsColor: '',
  //   quantityOfProducts: 0, productsPrice: 0,
  // ),

};