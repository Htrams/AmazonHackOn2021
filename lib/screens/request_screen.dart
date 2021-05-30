import 'package:flutter/material.dart';
import 'package:user_interface/components/my_app_bar.dart';
import 'package:user_interface/services/backend_helper.dart';
import 'package:user_interface/utilities/medicine_requests.dart';
import 'package:user_interface/utilities/userInfo.dart';
import 'package:user_interface/constants.dart';

class RequestScreen extends StatefulWidget {

  final Map<String,String> medicineMap;
  final UserInfo userInfo;

  RequestScreen({
    required this.medicineMap,
    required this.userInfo,
});

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {

  List<MedicineRequest> requests = <MedicineRequest>[];
    // MedicineRequest(medicineID: '1', status: RequestStatus.pending, quantity: '5'),
    // MedicineRequest(medicineID: '2', status: RequestStatus.completed, quantity: '10'),
    // MedicineRequest(medicineID: '3', status: RequestStatus.completed, quantity: '12'),
    // MedicineRequest(medicineID: '4', status: RequestStatus.timedOut, quantity: '15'),
  // ];

  late final Map<String,String> medicineMap;
  late UserInfo userInfo;
  bool screenLoading = false;

  Future<void> getMedicineRequests() async{
    setState(() {
      screenLoading = true;
    });
    requests = await BackendHelper.getMedicineRequests(userInfo.email!);
    setState(() {
      screenLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    medicineMap = widget.medicineMap;
    userInfo = widget.userInfo;
    getMedicineRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9F4FE),
      appBar: MyAppBar(
        title: 'Request History',
        textSize: 25,
      ),
      body: screenLoading ? Center(child: CircularProgressIndicator()) : ListView.separated(
        padding: EdgeInsets.all(20.0),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              '${requests[index].medicineID}',
              style: TextStyle(
                fontSize: 20.0
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${requests[index].quantity} Units',
                style: TextStyle(
                  fontSize: 16.0
                ),
              ),
            ),
            trailing: requests[index].getStatusAsText(),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: requests.length,
      ),
    );
  }
}
