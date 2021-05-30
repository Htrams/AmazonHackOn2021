import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_interface/services/location.dart';
import 'package:user_interface/utilities/retailer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MedicineLocationScreen extends StatefulWidget {
  final List<Retailer> retailers;
  final Location initLocation;

  MedicineLocationScreen({required this.retailers,required this.initLocation});

  @override
  _MedicineLocationScreenState createState() => _MedicineLocationScreenState();
}

class _MedicineLocationScreenState extends State<MedicineLocationScreen> {

  late GoogleMapController mapController;
  // final LatLng _center = const LatLng(45.521563, -122.677433);

  late final List<Retailer> retailers;
  late final Location initLocation;

  @override
  void initState() {
    super.initState();
    this.retailers = widget.retailers;
    this.initLocation = widget.initLocation;
  }

  Set<Marker> getMarkersFromRetailers() {
    Set<Marker> markers = <Marker>{};
    for(Retailer retailer in retailers) {
      Location current = retailer.location!;
      markers.add(
        Marker(
          markerId: MarkerId('${current.longitude}&${current.latitude}'),
          position: LatLng(current.latitude!,current.longitude!),
          infoWindow: InfoWindow(
            title: '${retailer.name}',
            snippet: '${retailer.rating} Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        )
      );
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(initLocation.latitude!,initLocation.longitude!),
              zoom: 11.0,
            ),
            markers: getMarkersFromRetailers(),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.20,
            minChildSize: 0.20,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),topRight: Radius.circular(25.0)),
                  color: Colors.white,
                ),
                child:
                    ListView.separated(
                      controller: scrollController,
                      itemCount: retailers.length,
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            '${retailers[index].name}',
                            style: TextStyle(
                                fontSize: 20.0
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Available Here',
                              style: TextStyle(
                                  fontSize: 16.0
                              ),
                            ),
                          ),
                          trailing: RatingBarIndicator(
                            rating: retailers[index].rating!,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 25.0,
                          ),
                        );
                      },
                    ),
              );
            },
          ),
        ],
      )
    );
  }
}