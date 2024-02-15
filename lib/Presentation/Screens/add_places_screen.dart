import 'dart:io';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_places/Common/Resources/values_manager.dart';
import 'package:my_places/Presentation/Widgets/back_arrow.dart';
import 'package:my_places/Presentation/Widgets/place_types_chckboxes.dart';
import '../../Controller/places_provider.dart';
import '../../Models/place_model.dart';
import '../../Utilies/Shared/shared_widgets.dart';
import '../Widgets/image_input.dart';
import '../Widgets/line.dart';
import '../Widgets/location_input.dart';
import '../Widgets/my_elevation_button.dart';
import '../Widgets/my_text.dart';
import '../Widgets/my_text_field.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  PlaceLocation? myPickedLocation;
  List<File> images = [];
  List<String> placeTypes = [];




  void _savePlace() { 
    final title = titleController.text;
    final description = descriptionController.text;
    final location = myPickedLocation ??const PlaceLocation(latitude: 0, longitude: 0, address: '');
    final place = Place(
        name: title,
        description: description,
        image: images,
        location: location,
        isFavourite: false,
        types: placeTypes,
    );

    if(images.isEmpty || location.address.isEmpty || placeTypes.isEmpty) {
        customShowDialog(
            context: context,
            title: "Please fill all fields",
            content: MyText(text: "Please fill all fields",style: Theme.of(context).textTheme.labelMedium,),
            actions: [
                TextButton(onPressed: () {
                      Navigator.pop(context);
                  },
                    child: MyText(text: "Ok",style: Theme.of(context).textTheme.labelMedium)),
            ]
        );
        return;
    }
    ref.read(userPlaceProvider.notifier).addPlace(place);

    Navigator.pop(context, place);
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackArrow(),
        title: MyText(text:'Add Place',size: AppSizes.s20,style: Theme.of(context).textTheme.labelMedium),
        centerTitle: true,
      ),


      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyText(text: 'Add a new place',size: AppSizes.s32,style: Theme.of(context).textTheme.displayLarge),
                const Line(),
                MyTextFormField(controller: titleController,
                  labelText: 'Title',
                  validator: (String title) {
                  if (title.isEmpty) {
                    return 'Please enter a title';
                  }
                 },
                border: true,
                ),
                 const SizedBox(height: AppSizes.s12,),
                MyTextFormField(
                  controller: descriptionController,
                  labelText: 'Description',
                  validator: (String description) {
                  if (description.isEmpty) {
                    return 'Please enter a description';
                  }
                 },
                border: true,
                ),
                  const SizedBox(height: AppSizes.s12,),
                ImageInput(onImageSelected: (List<File> pickedImage) {
                  images = pickedImage;
                 },),
                  const SizedBox(height: AppSizes.s20,),
                LocationInput(getLocation: (PlaceLocation pickedLocation) {
                      myPickedLocation = pickedLocation;
                 },),
                const Line(),
                // create check boxes for the places type to be added
                PlacesTypesCheckBoxes(getTypes: (List<String> returnedPlaceTypes) {
                  placeTypes = returnedPlaceTypes;
                },),
                const SizedBox(height: AppSizes.s20,),
                MyElevationButton(
                  widthButton: AppSizes.s300,
                  radius: AppSizes.s40,
                  fun: () {
                      if (formKey.currentState!.validate()) {
                        _savePlace();
                      }
                   }, textButton: 'Add Place',
                ),
                 const SizedBox(height: AppSizes.s100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

