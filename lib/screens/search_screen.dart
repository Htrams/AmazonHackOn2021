import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_interface/components/form_text_field_2.dart';
import 'package:user_interface/components/my_app_bar.dart';
import 'package:user_interface/components/rounded_button.dart';
import 'package:user_interface/components/side_menu_drawer.dart';
import 'package:user_interface/screens/medicine_location_screen.dart';
import 'package:user_interface/services/backend_helper.dart';
import 'package:user_interface/utilities/medicine_requests.dart';
import 'package:user_interface/utilities/retailer.dart';
import 'package:user_interface/utilities/userInfo.dart';
import 'package:user_interface/constants.dart';
import 'package:user_interface/screens/request_screen.dart';
import 'package:user_interface/screens/search_failed_screen.dart';
import 'package:user_interface/services/location.dart';
const Color kTextColor = Color(0xFF350561);

class SearchScreen extends StatefulWidget {
  static String screenID = 'search_screen';
  final UserInfo userInfo;

  SearchScreen({required this.userInfo});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  Map<String,String> medicineMap = <String,String>{};
  //   '1' : 'Croctrin',
  //   '2' : 'Aspirin',
  //   '3' : 'Paracetamol',
  //   '4' : 'Amoxycillin',
  //   '5' : 'Dolomite',
  //   '6' : 'Covishield'
  // };

  List<Retailer> retailers = <Retailer>[];
  //   Retailer(location: Location(latitude: 37.3905,longitude: -122.0984), name: "ABD", rating: 4.6),
  //   Retailer(location: Location(latitude: 38.3905,longitude: -121.0984), name: "EFG", rating: 3.5),
  //   Retailer(location: Location(latitude: 39.3905,longitude: -120.0984), name: "HIJ", rating: 3.2)
  // ];

  late List<String> medicineList;

  String? medicineName;
  int? quantity;
  late UserInfo userInfo;
  Location? coords;
  bool locationLoading = false;
  bool screenLoading = false;
  TextEditingController locationTextController = TextEditingController();
  String alertMsg = '';

  Future<void> updateLocation() async{
    print('fetching location');
    setState(() {
      locationLoading = true;
    });
    coords = await Location.getCurrentLocation();
    print('Latitude=${coords!.latitude}  Longitude=${coords!.longitude}');

    // Update location variable
    locationTextController.text = await coords!.getNameFromLocation();
    print(locationTextController.text);
    FocusScope.of(context).unfocus();
    setState(() {
      locationLoading = false;
    });

  }

  Future<void> getMedicineList() async{
    setState(() {
      screenLoading = true;
    });
    medicineMap = await BackendHelper.getMedicineList();
    medicineList = medicineMap.values.toList();
    setState(() {
      screenLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    userInfo = widget.userInfo;
    updateLocation();
    getMedicineList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9F4FE),
      appBar: MyAppBar(
        title: 'MediSearch',
        textColor: kTextColor,
      ),
      drawer: SideMenuDrawer(
        userInfo: userInfo,
        medicineMap: medicineMap,
      ),
      body: screenLoading ? Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Autocomplete<String>(
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted
                  ) {
                return FormTextField2(
                  prefixIcon: FontAwesomeIcons.pills,
                  hintText: 'Medicine Name',
                  controller: textEditingController,
                  focusNode: focusNode,
                  iconColor: Colors.blueGrey,
                  onSubmitted: (String value) {
                    onFieldSubmitted();
                  },
                  onChanged: (String value) {},
                );
              },
              optionsBuilder: (TextEditingValue textEditingValue) {
                return medicineList.where((String option) {
                  return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                medicineName = selection;
              },
            ),
            FormTextField2(
              prefixIcon: FontAwesomeIcons.cartPlus,
              hintText: 'Quantity',
              keyboardType: TextInputType.number,
              iconColor: Colors.blueGrey,
              onChanged: (String value) {
                if(value != '') {
                  quantity = int.parse(value);
                }
              },
            ),
            FormTextField2(
              prefixIcon: FontAwesomeIcons.locationArrow,
              suffixIcon: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  updateLocation();
                },
                child: locationLoading ? Center(child: SizedBox(child: CircularProgressIndicator(),height: 20.0,width: 20.0,)) :Icon(
                  Icons.replay_rounded,
                  color: Colors.blueGrey,
                ),
              ),
              hintText: 'Location',
              controller: locationTextController,
              iconColor: Colors.blueGrey,
              onChanged: (String value) {
                coords=null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 15.0,
                right: 15.0,
              ),
              child: RoundedButton(
                text: 'Search',
                textColor: kTextColor,
                onPressed: () async {
                  setState(() {
                    screenLoading = true;
                  });
                  if(quantity==null || medicineName==null || locationTextController.text=='') {
                    setState(() {
                      screenLoading = false;
                    });
                    return;
                  }
                  if(coords == null) {
                    coords = await Location.getLocationFromName(locationTextController.text);
                  }
                  print('Searching for $quantity units of $medicineName near ${locationTextController.text}');
                  // String chosenMedicineID = medicineMap.keys.firstWhere((k) => medicineMap[k] == medicineName, orElse: () => '');
                  // MedicineRequest newRequest = MedicineRequest(medicineID: chosenMedicineID, quantity: quantity!.toString());
                  // Create a MedicineRequest Object and pass to API search function.
                  var searchResponse = await BackendHelper.medicineSearch(
                    medicineID: medicineName!,
                    quantity: quantity.toString(),
                    email: userInfo.email!,
                    latitude: coords!.latitude.toString(),
                    longitude: coords!.longitude.toString()
                  );

                  if (searchResponse == SearchResponse.failed) {
                    setState(() {
                      alertMsg = 'Search Failed. Turn on Internet and GPS.';
                      screenLoading = false;
                    });
                    return;
                  }
                  screenLoading = false;
                  alertMsg='';
                  if (searchResponse == SearchResponse.notFulfilled) {
                    var response = await Navigator.push(context, MaterialPageRoute(builder: (context) => SearchFailedScreen()));

                    if(response == SearchFailedResponse.dropRequest) {
                      // Call API to store request and push request screen when response is okay.
                      var requestResponse = await BackendHelper.newRequest(
                        medicineID: medicineName!,
                        quantity: quantity.toString(),
                        email: userInfo.email!,
                        latitude: coords!.latitude.toString(),
                        longitude: coords!.longitude.toString()
                      );
                      if (requestResponse == RequestResponse.failed) {
                        setState(() {
                          alertMsg = 'Medicine Request Failed.';
                          screenLoading = false;
                        });
                        return;
                      }
                      else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RequestScreen(
                          medicineMap: medicineMap,
                          userInfo: userInfo,
                        )));
                      }
                    } else if(response == SearchFailedResponse.increaseRange) {
                    }
                  }
                  else {
                    // Get retailer information from response.
                    print('Opening Map');
                    retailers = <Retailer>[];
                    for(var retailer in searchResponse) {
                      print(retailer);
                      retailers.add(
                          Retailer(
                            location: Location(latitude: double.parse(retailer['latitude']), longitude: double.parse(retailer['longitude'])),
                            name: retailer['user']['first_name'].toString(),
                            rating: double.parse(retailer['rating']) ,
                          )
                      );
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineLocationScreen(retailers:retailers,initLocation: coords!)));
                  }

                },
                fontSize: 19,
              ),
            ),
            Text(
              alertMsg,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.red,
                fontSize: 15.0,
              ),

            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    locationTextController.dispose();
  }
}