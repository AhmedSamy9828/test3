// ignore_for_file: file_names

import 'package:elattar/pdf/test/employee.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class TableCheckAll extends StatefulWidget {
  const TableCheckAll({Key? key,}) : super(key: key);
  static String id = 'TableCheckAll';

  @override
  TableCheckAllState createState() => TableCheckAllState();
}

class TableCheckAllState extends State<TableCheckAll> {
  late EmployeeDataSource employeeDataSource;
  List<TableCheck> employeeData = [];



  Widget _buildDataGrid() {
    final getDataFromFireStore = FirebaseFirestore.instance.collection('Sales')
        .where('sold', isEqualTo: 'true').orderBy('orderDate')
        .snapshots();
    return StreamBuilder(
      stream: getDataFromFireStore,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (employeeData.isNotEmpty) {
            // to update the value changed at runtime
            getDataGridRowFromDataBase(DocumentChange<Object?> data) {
              return DataGridRow(cells: [
                DataGridCell<String>(
                    columnName: 'clientName', value: data.doc['clientName']),
                DataGridCell<String>(
                    columnName: 'orderDate', value: data.doc['orderDate']),
                DataGridCell<String>(
                    columnName: 'productUnits', value: '${data.doc['productUnits']}'),
                DataGridCell<String>(
                  // columnName: 'clientNumber', value: data.doc['clientNumber'].toString()),
                    columnName: 'totalPriceProducts', value: '${data.doc['totalPriceProducts']}'),
              ]);
            }

            for (var data in snapshot.data!.docChanges) {
              if (data.type == DocumentChangeType.modified) {
                if (data.oldIndex == data.newIndex) {
                  employeeDataSource.dataGridRows[data.oldIndex] = getDataGridRowFromDataBase(data);
                }
                employeeDataSource.updateDataGridSource();
              } else if (data.type == DocumentChangeType.added) {
                employeeDataSource.dataGridRows.add(getDataGridRowFromDataBase(data));
                employeeDataSource.updateDataGridSource();
              } else if (data.type == DocumentChangeType.removed) {
                employeeDataSource.dataGridRows.removeAt(data.oldIndex);
                employeeDataSource.updateDataGridSource();
              }
            }
          } else {
            for (var data in snapshot.data!.docs) {
              employeeData.add(
                  TableCheck(
                    clientName: data['clientName'],
                    orderDate: data['orderDate'],
                    productUnits: data['productUnits'].toString(),
                    totalPriceProducts: data['totalPriceProducts'].toString(),

                  )
              );
            }
            employeeDataSource = EmployeeDataSource(employeeData);
          }

          return SfDataGrid(
            source: employeeDataSource,
            columns: getColumns,
            columnWidthMode: ColumnWidthMode.fitByCellValue,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('الفواتير المباعه'),
      ),
      body: _buildDataGrid(),
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(this.employeeData) {
    _buildDataRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<TableCheck> employeeData;

  void _buildDataRow() {
    dataGridRows = employeeData
        .map<DataGridRow>((e) => DataGridRow(
        cells: [
          // DataGridCell<String>(columnName: 'salesId', value: e.id),

          DataGridCell<String>(columnName: 'totalPriceProducts', value: e.totalPriceProducts),
          DataGridCell<String>(columnName: 'productUnits', value: e.productUnits),
          DataGridCell<String>(columnName: 'orderDate', value: e.orderDate),
          DataGridCell<String>(columnName: 'clientName', value: e.clientName),
        ]
    )).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(
      DataGridRow row,
      ) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(1.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}

List<GridColumn> get getColumns {
  return <GridColumn>[
    GridColumn(
        columnName: 'totalPriceProducts',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'الإجمالي',
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'productUnits',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('الكميه'))),
    GridColumn(
        columnName: 'orderDate',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('التاريخ'))),
    GridColumn(
        columnName: 'clientName',
        label: Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: const Text(
              'الإسم',
            ))),
  ];
}