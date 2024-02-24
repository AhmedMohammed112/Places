import 'package:flutter/Material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:my_places/Common/Resources/color_manager.dart';
import 'package:my_places/Common/Resources/router_manager.dart';
import 'package:my_places/Common/Resources/values_manager.dart';
import 'package:my_places/Models/place_model.dart';
import 'package:my_places/Presentation/Widgets/my_text.dart';

import '../../Utilies/Shared/location_helper.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key, required this.getLocation}) : super(key: key);

  final void Function(PlaceLocation location) getLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? pickedLocation;
  bool isGettingLocation = false;


  Future<void> savePlace({required double latitude,required double longitude}) async
  {
    final formattedAddress = await getFormattedAddress(latitude, longitude);

    setState(() {
      pickedLocation =
          PlaceLocation(latitude: latitude, longitude: longitude, address: formattedAddress);
      isGettingLocation = false;
    });

    widget.getLocation(pickedLocation ?? const PlaceLocation(latitude: 0.0, longitude: 0.0, address: ''));
  }

  void selectOnMap() async
  {
    final LatLng? pickedLocation = await Navigator.pushNamed<LatLng>(context, AppRoutes.selectOnMap);
    if(pickedLocation == null) return;

    savePlace(latitude: pickedLocation.latitude, longitude: pickedLocation.longitude);
  }

  void getCurrentLocation() async {
    Location location = await getCLocation();
    LocationData locationData;

    setState(() {
      isGettingLocation = true;
    });

    locationData = await location.getLocation();

    await savePlace(latitude: locationData.latitude ?? 0.0, longitude: locationData.longitude ?? 0.0);
  }


  @override
  Widget build(BuildContext context) {
    Widget previewContent = Center(child: MyText(text: 'No Location Selected',style: Theme.of(context).textTheme.labelMedium));

    if (pickedLocation != null) {
      previewContent = ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.s16),
        child: Image.network(
          locationImage(pickedLocation),
          fit: BoxFit.cover,
        ),
      );
    }
    if (isGettingLocation) {
      previewContent = const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Container(
            height: AppSizes.s160,
            width: double.infinity,
            decoration: BoxDecoration( 
              borderRadius: BorderRadius.circular(AppSizes.s16),
              border: Border.all(width: 2,color: ColorManager.newPrimary),
            ),
            child: previewContent),
        const SizedBox(
          height: AppSizes.s12,
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: getCurrentLocation,
                    icon: const Icon(Icons.location_on, )),
                MyText(text: 'Get Current Location',style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: selectOnMap,
                    icon: const Icon(Icons.map, )),
                MyText(text: 'Select on Map',style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ],
        ),
      ],
    );
  }
}


