import 'package:user_interface/constants.dart';
import 'package:user_interface/screens/login_screen.dart';
import 'package:user_interface/services/api_constants.dart';
import 'package:user_interface/services/network_helper.dart';
import 'package:user_interface/utilities/medicine_requests.dart';

class BackendHelper {

  static Future<LoginResponse> login(String email, String pass) async {
    try {
      String url = '${ApiConstants.backend.baseUrl}customer/login/';
      var networkResponse = await NetworkHelper(url).postData(
          <String, String>{
            'username': email,
            'password': pass,
          }
      );
      if (networkResponse == null) {
        return LoginResponse.failed;
      }
      print(networkResponse);
      return LoginResponse.passed;
    } catch (e) {
      print(e);
      return LoginResponse.failed;
    }
  }

  static Future<RegistrationResponse> register({
    required String email,
    required String pass,
    required String phone,
    required String firstName,
    required String lastName,
  }) async {
    try {
      String url = '${ApiConstants.backend.baseUrl}customer/register/';
      var networkResponse = await NetworkHelper(url).postData(
          <String, String>{
            'first_name': firstName,
            'last_name': lastName,
            'email': email,
            'password': pass,
            'phoneNum': phone,
          }
      );
      if (networkResponse == "Successfully registered") {
        return RegistrationResponse.passed;
      }
      else if (networkResponse == "this email already exists"){
        return RegistrationResponse.alreadyRegistered;
      }
      else {
        return RegistrationResponse.failed;
      }
    } catch (e) {
      print(e);
      return RegistrationResponse.failed;
    }
  }

  static Future<Map<String,dynamic>> loginDetails(String email) async {
    try {
      String url = '${ApiConstants.backend.baseUrl}customer/logindetails/';
      var networkResponse = await NetworkHelper(url).postData(
          <String, String>{
            'username': email,
          }
      );
      if (networkResponse == null) {
        return <String,String>{
          'Passed' : 'false'
        };
      }
      print(networkResponse);
      networkResponse['Passed'] = 'true';
      return networkResponse;
    } catch (e) {
      print(e);
      return <String,String>{
        'Passed' : 'false'
      };
    }
  }

  // static Future<Map<String,String>> getMedicineList() async {
  //   try {
  //     String url = '${ApiConstants.backend.baseUrl}customer/getmedlist/';
  //     var networkResponse = await NetworkHelper(url).getData();
  //     if (networkResponse == null) {
  //       return <String,String>{
  //         'Failed' : 'Error fetching medicine list.'
  //       };
  //     }
  //     Map<String,String> medicineMap = <String,String>{};
  //     for(var medicine in networkResponse) {
  //       for(String medicineName in medicine.keys){
  //         medicineMap[medicine[medicineName]] = medicineName;
  //       }
  //     }
  //     print('Loaded ${medicineMap.length} medicines.');
  //     return medicineMap;
  //   } catch (e) {
  //     print(e);
  //     return <String,String>{
  //       'Failed' : 'Error fetching medicine list.'
  //     };
  //   }
  // }

  static Future<Map<String,String>> getMedicineList() async {
    try {
      String url = '${ApiConstants.backend.baseUrl}customer/getmedlist/';
      var networkResponse = await NetworkHelper(url).getData();
      if (networkResponse == null) {
        return <String,String>{
          'Failed' : 'Error fetching medicine list.'
        };
      }
      Map<String,String> medicineMap = <String,String>{};
      for(var medicine in networkResponse) {
        medicineMap[medicine['id'].toString()]=medicine['name'];
      }
      print('Loaded ${medicineMap.length} medicines.');
      return medicineMap;
    } catch (e) {
      print(e);
      return <String,String>{
        'Failed' : 'Error fetching medicine list.'
      };
    }
  }

  static Future<RequestResponse> newRequest({
    required String medicineID,
    required String quantity,
    required String email,
    required String latitude,
    required String longitude,
  }) async {
    try {
      String url = '${ApiConstants.backend.baseUrl}customer/create-request/';
      var networkResponse = await NetworkHelper(url).postData(
          <String, String>{
            "medName" : medicineID,
            "medQnty": quantity,
            "email": email,
            "latitude": latitude,
            "longitude": longitude,
          }
      );
      if (networkResponse == "Request generated") {
        return RequestResponse.successful;
      }
      else if (networkResponse == "Order already exists"){
        return RequestResponse.alreadyRequested;
      }
      else {
        return RequestResponse.failed;
      }
    } catch (e) {
      print(e);
      return RequestResponse.failed;
    }
  }

  static Future<dynamic> medicineSearch({
    required String medicineID,
    required String quantity,
    required String email,
    required String latitude,
    required String longitude,
  }) async {
    try {
      String url = '${ApiConstants.backend.baseUrl}customer/search-meds/';
      var networkResponse = await NetworkHelper(url).postData(
          <String, String>{
            "medName" : medicineID,
            "medQnty": quantity,
            "email": email,
            "latitude": latitude,
            "longitude": longitude,
          }
      );
      print('$medicineID  $quantity  $email');
      if (networkResponse == "Medicine is not available" || networkResponse == "$medicineID is not available in the desired quantity") {
        print('Medicine not available.');
        return SearchResponse.notFulfilled;
      }
      else if (networkResponse == null){
        return SearchResponse.failed;
      }
      else {
        return networkResponse;
      }
    } catch (e) {
      print(e);
      return SearchResponse.failed;
    }
  }

  static Future<List<MedicineRequest>> getMedicineRequests(String email) async {
    try {
      String url = '${ApiConstants.backend.baseUrl}customer/list/';
      var networkResponse = await NetworkHelper(url).postData(
          <String, String>{
            "email" : email,
          }
      );
      if (networkResponse == null) {
        return <MedicineRequest>[];
      }

      List<MedicineRequest> medicineRequestList = <MedicineRequest>[];
      for(var request in networkResponse) {
        medicineRequestList.add(
          MedicineRequest(
            medicineID: request['medName']['name'],
            quantity: request['medQnty'].toString(),
            status: request['completed'] ? RequestStatus.completed : RequestStatus.pending,
          )
        );
      }

      print('Loaded ${medicineRequestList.length} requests.');
      return medicineRequestList;

    } catch (e) {
      print(e);
      return <MedicineRequest>[];
    }
  }
}