import 'dart:convert';
import 'package:flutter/Material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_places/Common/Resources/color_manager.dart';
import 'package:my_places/Common/Resources/values_manager.dart';
import 'package:my_places/Models/autocomplete_predection_model.dart';
import 'package:my_places/Models/place_autoccomplete_response_model.dart';
import 'package:my_places/Presentation/Widgets/location_list_tile.dart';
import 'package:my_places/Presentation/Widgets/my_text.dart';
import 'package:my_places/Presentation/Widgets/my_text_field.dart';
import '../../Utilies/Shared/constants.dart';
import '../../Utilies/Shared/network_helber.dart';
import '../../Utilies/Shared/shared_widgets.dart';
import '../Widgets/line.dart';


class SelectOnMapScreen extends StatefulWidget {
  const SelectOnMapScreen({Key? key}) : super(key: key);

  @override
  State<SelectOnMapScreen> createState() => _SelectOnMapScreenState();
}

class _SelectOnMapScreenState extends State<SelectOnMapScreen> { 

  bool isSearching = true;
  List<AutocompletePredection> predictions = [];
  TextEditingController placeController = TextEditingController();

  void placeAutocomplete({required String query}) async
  {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": apiKey,
      }
    );

    final response = await NetworkUtilities.fetchUrl(uri);
    if(response != null)
      {
        PlaceAutocompleteResponse placeAutocompleteResponse = PlaceAutocompleteResponse.parseAutocompleteResponse(response)!;
        if(placeAutocompleteResponse.predictions != null)
          {
            setState(() {
              predictions = placeAutocompleteResponse.predictions!;
              print("PREDECTIONS ${predictions.length}");
            });
          }
      }


  }

  void getLatLng({required String placeID}) async
  {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        'maps/api/place/details/json',
      {
        "place_id": placeID,
        "key": apiKey,
      }
    );

     final result = await NetworkUtilities.fetchUrl(uri);

     if(result != null)
     {
       //print only lat and lng
        final parsed = await json.decode(result).cast<String, dynamic>();
        final geometry = parsed['result']['geometry'];

        final lat = geometry['location']['lat'];
        final lng = geometry['location']['lng'];

        setState(() {
          pickedLocation = LatLng(lat,lng); 
          defaultLatLng = LatLng(lat,lng); 
          placeController.text = parsed['result']['formatted_address'];
          isSearching = false;
        });
     }


  }

  LatLng? defaultLatLng = const LatLng(0,0);
  LatLng? pickedLocation;

@override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(pickedLocation);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: MyText(text: "Select on map",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MyTextFormField(
              controller: placeController,
              myOnChanged: (value) {
                placeAutocomplete(query: value);
              },
              onTap: () {
                setState(() {
                  isSearching = true;
                });
              },
              myOnFieldSubmitted: (value) {
                setState(() {
                  isSearching = false;
                });
              },
                hintText: "Search your location",
                prefixIcon: const Icon(Icons.location_pin,color: ColorManager.white,),
                suffixIcon: isSearching == true ? const Icon(Icons.search,color: ColorManager.white,) : IconButton(
                  onPressed: () {
                    setState(() {
                      placeController.clear();
                      isSearching = true;
                    });
                  },
                  icon: const Icon(Icons.clear,color: ColorManager.white,),
                ),
                border: true,
            ),
            const Line(),
            isSearching == true ? Expanded(
              child: ListView.builder(

                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return LocationListTile(
                    location: predictions[index].description!,
                    descreption: predictions[index].structuredFormatting!.secondaryText ?? '',
                    onPress: () {
                      getLatLng(placeID: predictions[index].placeId!);
                    },
                  );
                },
              ),
            ) :
            Expanded(
              child: GoogleMap(
                  onTap: (latLng) {
                    setState(() {
                      pickedLocation = latLng;
                    });
                  },

                  trafficEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: defaultLatLng!,
                    zoom: 14.4746,
                  ),
                  markers: {
                    Marker(
                        markerId: const MarkerId('m1'),
                        position: pickedLocation ?? defaultLatLng!
                    )
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
