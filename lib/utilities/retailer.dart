import 'package:user_interface/services/location.dart';

class Retailer {
  final String? name;
  final Location? location;
  final double? rating;

  Retailer({
    this.location,
    this.name,
    this.rating,
  });
}