///
/// AVANCED EXAMPLE:
/// Screen with map and search box on top. When the user selects a place through autocompletion,
/// the screen is moved to the selected location, a path that demonstrates the route is created, and a "start route"
/// box slides in to the screen.
///

import 'dart:async';

import 'package:active_ecommerce_flutter/custom/btn.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/other_config.dart';
import 'package:active_ecommerce_flutter/repositories/address_repository.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb_v2/google_maps_place_picker.dart';
import 'package:geolocator/geolocator.dart';

/*class MapLocation extends StatefulWidget {
  MapLocation({Key? key, this.address}) : super(key: key);
  var address;

  @override
  State<MapLocation> createState() => MapLocationState();
}

class MapLocationState extends State<MapLocation>
    with SingleTickerProviderStateMixin {
  PickResult? selectedPlace;
  static LatLng kInitialPosition = LatLng(
      51.52034098371205, -0.12637399200000668); // London , arbitary value

  GoogleMapController? _controller;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    // String value = await DefaultAssetBundle.of(context)
    //     .loadString('assets/map_style.json');
    // _controller.setMapStyle(value);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.address.location_available) {
      setInitialLocation();
    } else {
      setDummyInitialLocation();
    }
  }

  setInitialLocation() {
    kInitialPosition = LatLng(widget.address.lat, widget.address.lang);
    setState(() {});
  }

  setDummyInitialLocation() {
    kInitialPosition = LatLng(
        51.52034098371205, -0.12637399200000668); // London , arbitary value
    setState(() {});
  }

  onTapPickHere(selectedPlace) async {
    var addressUpdateLocationResponse = await AddressRepository()
        .getAddressUpdateLocationResponse(
            widget.address.id,
            selectedPlace.geometry.location.lat,
            selectedPlace.geometry.location.lng);

    if (addressUpdateLocationResponse.result == false) {
      ToastComponent.showDialog(
        addressUpdateLocationResponse.message,
      );
      return;
    }

    ToastComponent.showDialog(
      addressUpdateLocationResponse.message,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      hintText: AppLocalizations.of(context)!.your_delivery_location,
      apiKey: OtherConfig.GOOGLE_MAP_API_KEY,
      initialPosition: kInitialPosition,
      useCurrentLocation: false,
      //selectInitialPosition: true,
      //onMapCreated: _onMapCreated, // this causes error , do not open this
      //initialMapType: MapType.terrain,

      //usePlaceDetailSearch: true,
      onPlacePicked: (result) {
        selectedPlace = result;

        // print("onPlacePicked..."+result.toString());
        // Navigator.of(context).pop();
        setState(() {});
      },
      //forceSearchOnZoomChanged: true,
      //automaticallyImplyAppBarLeading: false,
      //autocompleteLanguage: "ko",
      //region: 'au',
      //selectInitialPosition: true,
      selectedPlaceWidgetBuilder:
          (_, selectedPlace, state, isSearchBarFocused) {
        //print("state: $state, isSearchBarFocused: $isSearchBarFocused");
        //print(selectedPlace.toString());
        //print("-------------");
        /*
        if(!isSearchBarFocused && state != SearchingState.Searching){
          ToastComponent.showDialog("Hello", context,
              gravity: Toast.center, duration: Toast.lengthLong);
        }*/
        return isSearchBarFocused
            ? Container()
            : FloatingCard(
                height: 50,
                bottomPosition: 120.0,
                // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                leftPosition: 0.0,
                rightPosition: 0.0,
                width: 500,
                borderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(8.0),
                  bottomLeft: const Radius.circular(8.0),
                  topRight: const Radius.circular(8.0),
                  bottomRight: const Radius.circular(8.0),
                ),
                child: state == SearchingState.Searching
                    ? Center(
                        child: Text(
                        AppLocalizations.of(context)!.calculating,
                        style: TextStyle(color: MyTheme.font_grey),
                      ))
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 2.0, right: 2.0),
                                    child: Text(
                                      selectedPlace!.formattedAddress!,
                                      maxLines: 2,
                                      style:
                                          TextStyle(color: MyTheme.medium_grey),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Btn.basic(
                                color: MyTheme.accent_color,
                                shape: RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.only(
                                  topLeft: const Radius.circular(4.0),
                                  bottomLeft: const Radius.circular(4.0),
                                  topRight: const Radius.circular(4.0),
                                  bottomRight: const Radius.circular(4.0),
                                )),
                                child: Text(
                                  AppLocalizations.of(context)!.pick_here,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                                  //            this will override default 'Select here' Button.
                                  /*print("do something with [selectedPlace] data");
                                  print(selectedPlace.formattedAddress);
                                  print(selectedPlace.geometry.location.lat);
                                  print(selectedPlace.geometry.location.lng);*/

                                  onTapPickHere(selectedPlace);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              );
      },
      pinBuilder: (context, state) {
        if (state == PinState.Idle) {
          return Image.asset(
            'assets/delivery_map_icon.png',
            height: 60,
          );
        } else {
          return Image.asset(
            'assets/delivery_map_icon.png',
            height: 80,
          );
        }
      },
    );
  }
}*/

class MapLocation extends StatefulWidget {
  final dynamic address; // Expecting address object with lat, lang, id, location_available

  const MapLocation({Key? key, this.address}) : super(key: key);

  @override
  State<MapLocation> createState() => MapLocationState();
}

class MapLocationState extends State<MapLocation>
    with SingleTickerProviderStateMixin {
  PickResult? selectedPlace;

  // Default fallback (Kampala)
  LatLng kInitialPosition = const LatLng(0.3476, 32.5825);

  @override
  void initState() {
    super.initState();
    _setInitialLocation();
  }

  /// Determine initial map position
  Future<void> _setInitialLocation() async {
    try {
      // ✅ 1. Try to get device's current location first
      Position? position = await _determinePosition();

      if (position != null) {
        kInitialPosition = LatLng(position.latitude, position.longitude);
      }
      // ✅ 2. If GPS not available, try saved address coordinates
      else if (widget.address != null &&
          widget.address.location_available == true &&
          widget.address.lat != null &&
          widget.address.lang != null) {
        kInitialPosition = LatLng(
          double.tryParse(widget.address.lat.toString()) ?? 0.0,
          double.tryParse(widget.address.lang.toString()) ?? 0.0,
        );
      }
      // ✅ 3. Otherwise, default Kampala already set
    } catch (e) {
      debugPrint("Error setting initial location: $e");
    }

    // Refresh map UI
    if (mounted) setState(() {});
  }

  /// Request device location
  Future<Position?> _determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return null;
        }
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      debugPrint("Error getting location: $e");
      return null;
    }
  }

  /// Update selected location in repository
  Future<void> onTapPickHere(PickResult? place) async {
    if (place == null) return;

    final response = await AddressRepository().getAddressUpdateLocationResponse(
      widget.address?.id,
      place.geometry?.location.lat ?? 0.0,
      place.geometry?.location.lng ?? 0.0,
    );

    ToastComponent.showDialog(response.message);
  }

  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      hintText: AppLocalizations.of(context)!.your_delivery_location,
      apiKey: OtherConfig.GOOGLE_MAP_API_KEY,
      initialPosition: kInitialPosition,
      useCurrentLocation: false, // We'll handle location manually
      onPlacePicked: (result) {
        selectedPlace = result;
        setState(() {});
      },
      selectedPlaceWidgetBuilder:
          (_, selectedPlace, state, isSearchBarFocused) {
        return isSearchBarFocused
            ? const SizedBox.shrink()
            : FloatingCard(
                height: 50,
                bottomPosition: 120.0,
                leftPosition: 0.0,
                rightPosition: 0.0,
                width: 500,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: state == SearchingState.Searching
                    ? Center(
                        child: Text(
                          AppLocalizations.of(context)!.calculating,
                          style: TextStyle(color: MyTheme.font_grey),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Text(
                                    selectedPlace?.formattedAddress ?? '',
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: MyTheme.medium_grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Btn.basic(
                                color: MyTheme.accent_color,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.pick_here,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onPressed: () => onTapPickHere(selectedPlace),
                              ),
                            ),
                          ],
                        ),
                      ),
              );
      },
      pinBuilder: (context, state) {
        return Image.asset(
          'assets/delivery_map_icon.png',
          height: state == PinState.Idle ? 60 : 80,
        );
      },
    );
  }
}