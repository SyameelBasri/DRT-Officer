class Operation {
  final int op_id;
  final String op_dt;
  final String location;
  List<String> officers;

  Operation({this.op_id, this.op_dt, this.location, this.officers});
}

List<Operation> dummyData = [];
List<Operation> createdDummy = [
  new Operation(
    op_id: 1,
    op_dt: '10/9/2020',
    location: 'Cyberjaya',
    officers: ['officer 1', 'officer 2', 'officer 3', 'officer 4', 'officer 5']
  )
];