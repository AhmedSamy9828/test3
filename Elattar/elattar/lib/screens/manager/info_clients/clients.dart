import 'package:elattar/pdf/test/employee.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Clients extends StatefulWidget {
  const Clients({Key? key}) : super(key: key);
  static String id = 'Clients';

  @override
  ClientsState createState() => ClientsState();
}

class ClientsState extends State<Clients> {
  late EmployeeDataSource employeeDataSource;
  List<Employee> employeeData = [];

  final getDataFromFireStore = FirebaseFirestore.instance.collection('Clients').snapshots();

  Widget _buildDataGrid() {
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
                    columnName: 'clientGovernorate', value: data.doc['clientGovernorate']),
                DataGridCell<String>(
                    columnName: 'clientAddress', value: data.doc['clientAddress']),
                DataGridCell<String>(
                    columnName: 'clientNumber', value: data.doc['clientNumber'].toString()),
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
                  Employee(
                    clientName: data['clientName'],
                    clientAddress: data['clientAddress'],
                    clientNumber: data['clientNumber'].toString(),
                    clientGovernorate: data['clientGovernorate'],

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
        title: const Text('العملاء'),
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
  List<Employee> employeeData;

  void _buildDataRow() {
    dataGridRows = employeeData
      .map<DataGridRow>((e) => DataGridRow(
        cells: [
          // DataGridCell<String>(columnName: 'salesId', value: e.id),

          DataGridCell<String>(columnName: 'clientAddress', value: e.clientAddress),
          DataGridCell<String>(columnName: 'clientNumber', value: e.clientNumber),
          DataGridCell<String>(columnName: 'clientGovernorate', value: e.clientGovernorate),
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
        columnName: 'clientAddress',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'العنوان',
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        columnName: 'clientNumber',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('الرقم'))),
    GridColumn(
        columnName: 'clientGovernorate',
        label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text('المحافظه'))),
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