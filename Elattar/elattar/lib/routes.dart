import 'package:elattar/screens/login.dart';
import 'package:elattar/screens/manager/employees/add_an_employee.dart';
import 'package:elattar/screens/manager/employees/employee_profile.dart';
import 'package:elattar/screens/manager/employees/employee_work_file.dart';
import 'package:elattar/screens/manager/employees/employees.dart';
import 'package:elattar/screens/manager/employees/show_check.dart';
import 'package:elattar/screens/manager/employees/show_throwback.dart';
import 'package:elattar/screens/manager/employees/table/employee_table_check.dart';
import 'package:elattar/screens/manager/employees/table/employee_table_throwback.dart';
import 'package:elattar/screens/manager/groups/add_groups.dart';
import 'package:elattar/screens/manager/groups/groups.dart';
import 'package:elattar/screens/manager/groups/modify_groups.dart';
import 'package:elattar/screens/manager/groups/products/add_products.dart';
import 'package:elattar/screens/manager/groups/products/modify_a_products.dart';
import 'package:elattar/screens/manager/groups/products/products.dart';
import 'package:elattar/screens/manager/home_manager.dart';
import 'package:elattar/screens/manager/info_clients/clients.dart';
import 'package:elattar/screens/manager/returns/check.dart';
import 'package:elattar/screens/manager/returns/product_choose.dart';
import 'package:elattar/screens/manager/returns/table_all/table_check_all.dart';
import 'package:elattar/screens/manager/returns/table_all/table_throwback_all.dart';
import 'package:elattar/screens/manager/returns/throwback.dart';
import 'package:elattar/screens/manager/returns/returns.dart';
import 'package:elattar/screens/manager/sales/billed.dart';
import 'package:elattar/screens/manager/sales/info_bille.dart';
import 'package:elattar/screens/manager/sales/sales.dart';
import 'package:elattar/screens/moderators/Send_The_Order.dart';
import 'package:elattar/screens/moderators/add_client.dart';
import 'package:elattar/screens/moderators/home_moderators.dart';
import 'package:elattar/screens/moderators/prepare_client.dart';
import 'package:elattar/screens/moderators/prepare_group.dart';
import 'package:elattar/screens/moderators/prepare_product.dart';
import 'package:elattar/screens/moderators/product_selection.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>
{
  HomeManager.id :(context) => const HomeManager(),
  Login.id :(context) => const Login(),




  Employees.id :(context) => const Employees(),
  AddAnEmployee.id :(context) => const AddAnEmployee(),
  EmployeeProfile.id :(context) => const EmployeeProfile(
    moderatorId: '', moderatorName: '', moderatorPhone: '',
    moderatorNationId: '', moderatorEmail: '', moderatorPassword: '',
  ),
  EmployeeWorkFile.id :(context) => const EmployeeWorkFile(moderatorId: '',),

  Sales.id :(context) => const Sales(),
  InfoBill.id :(context) => const InfoBill(
     moderatorName: '',totalPriceProducts: 0, productUnits: 0,
    clientName: '', clientGovernorate: '', clientAddress: '', clientNumber: '', orderDate: '',
    invoiceNumber: '', notice: '', status: '', dateRegistration: '',
  ),
  Billed.id :(context) => const Billed(
    salesId: '', moderatorName: '', moderatorId: '', totalPriceProducts: 0, productUnits: 0,
    clientName: '', clientGovernorate: '', clientAddress: '', clientNumber: '', orderDate: '',
    address: '', number1: '', number2: '', factory: '',
    invoiceNumber: '', notice: '', status: '', dateRegistration: '',
  ),

  Returns.id :(context) => const Returns(),

  PrepareGroup.id :(context) => const PrepareGroup(
    totalPriceProducts: 0,
     salesId: '', productUnits: 0,
  ),
  PrepareProduct.id :(context) =>  const PrepareProduct(
     salesId: '', totalPriceProducts: 0, productUnits: 0,
    groupId: '', groupsCode: '', groupsName: '', groupsSection: '', groupsBrunch: '',
    quantityOfProductsInGroups: 0, dateOfArrivalGroup: '',
  ),
  ProductSelection.id :(context) => const ProductSelection(
    totalPriceProducts: 0,
    groupId: '', groupsCode: '', groupsName: '', groupsSection: '', groupsBrunch: '',
    quantityOfProductsInGroups: 0, dateOfArrivalGroup: '',
    productId: '', productsCode: '', productsName: '', productsSize: '', productsColor: '',
    quantityOfProducts: 0, productsPrice: 0, salesId: '', productUnits: 0,

  ),


  HomeModerators.id :(context) => const HomeModerators(),
  AddClient.id :(context) => const AddClient(),
  PrepareClient.id :(context) => const PrepareClient(
    clientId: '', clientName: '', clientGovernorate: '', clientAddress: '', clientNumber: '', moderatorName: '',
  ),
  SendTheOrder.id :(context) => const SendTheOrder(
    salesId: '', clientName: '', clientAddress: '', clientNumber: '',totalPriceProducts: 0, clientGovernorate: '',
    productUnits: 0,
  ),


  // ################

  Clients.id :(context) => const Clients(),

  EmployeeTableCheck.id :(context) => const EmployeeTableCheck(moderatorId: '',),
  EmployeeTableThrowBack.id :(context) => const EmployeeTableThrowBack(moderatorId: '',),

  TableCheckAll.id :(context) => const TableCheckAll(),
  ThrowBackAll.id :(context) => const ThrowBackAll(),
  ProductChoose.id :(context) => const ProductChoose(
    salesId: '', moderatorName: '', moderatorId: '',
    clientName: '', clientGovernorate: '', clientAddress: '', clientNumber: '', orderDate: '', clientProductsId: '',
    productsCode: '', productsName: '', productsSize: '', productsColor: '',
    groupId: '', groupsName: '', groupsCode: '', groupsSection: '', groupsBrunch: '',
    quantityOfProductsInGroups: 0, dateOfArrivalGroup: '',
    productId: '', totalProducts: 0, productsPrice: 0, newPriceProduct: 0,
    dateRegistration: '', status: '', notice: '', invoiceNumber: '',
  ),

  Groups.id :(context) => const Groups(),

  AddGroups.id :(context) => const AddGroups(),
  ModifyGroups.id :(context) => const ModifyGroups(
    groupsId: '', groupsCode: '', groupsName: '', groupsSection: '', groupsBrunch: '',
    quantityOfProductsInGroups: 0, dateOfArrivalGroup: '',
  ),

  Products.id :(context) => const Products(
    groupsId: '', groupsCode: '', groupsName: '',
    groupsSection: '', groupsBrunch: '',
    quantityOfProductsInGroups: 0,dateOfArrivalGroup: '',
  ),
  AddProducts.id :(context) => const AddProducts(
    groupsId: '', groupsName: '',
    quantityOfProductsInGroups: 0, dateOfArrivalGroup: '',
  ),
  ModifyAProducts.id :(context) => const ModifyAProducts(
    groupsId: '', groupsName: '', quantityOfProductsInGroups: 0,dateOfArrivalGroup: '',
    productsId: '', productsCode: '', productsName: '', productsSize: '', productsColor: '',
    quantityOfProducts: 0, productsPrice: 0,
  ),

  Check.id :(context) => const Check(
    salesId: '', moderatorName: '', moderatorId: '', totalPriceProducts: 0, productUnits: 0,
    clientName: '', clientGovernorate: '', clientAddress: '', clientNumber: '', orderDate: '', invoiceNumber: '',
    address: '', number1: '', number2: '', factory: '', dateRegistration: '', status: '', notice: '',
  ),
  ShowCheck.id :(context) => const ShowCheck(
    salesId: '', moderatorName: '', moderatorId: '', totalPriceProducts: 0, productUnits: 0,
    clientName: '', clientGovernorate: '', clientAddress: '', clientNumber: '', orderDate: '',
    address: '', number1: '', number2: '', factory: '',
  ),
  Throwback.id :(context) => const Throwback(
    salesId: '', moderatorName: '', moderatorId: '', totalPriceProducts: 0, productUnits: 0,
    clientName: '', clientGovernorate: '', clientAddress: '', clientNumber: '', orderDate: '',
    address: '', number1: '', number2: '', factory: '',
    dateRegistration: '', dateRegistrationBack: '', status: '', notice: '', invoiceNumber: '',
  ),
  ShowThrowback.id :(context) => const ShowThrowback(
    salesId: '', moderatorName: '', moderatorId: '', totalPriceProducts: 0, productUnits: 0,
    clientName: '', clientGovernorate: '', clientAddress: '', clientNumber: '', orderDate: '',
    address: '', number1: '', number2: '', factory: '',
  ),

};