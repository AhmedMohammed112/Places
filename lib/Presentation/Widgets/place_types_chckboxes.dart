import 'package:flutter/Material.dart';
import 'package:my_places/Common/Resources/color_manager.dart';
import 'package:my_places/Presentation/Widgets/line.dart';
import 'package:my_places/Presentation/Widgets/my_text.dart';

import '../../Utilies/Shared/constants.dart';

class PlacesTypesCheckBoxes extends StatefulWidget {
  const PlacesTypesCheckBoxes({super.key, required this.getTypes});

  final void Function(List<String> types) getTypes;


  @override
  State<PlacesTypesCheckBoxes> createState() => _PlacesTypesCheckBoxesState();
}

class _PlacesTypesCheckBoxesState extends State<PlacesTypesCheckBoxes> {
  List<String> selectedPlaceTypes = []; 
  List<CheckboxListTile> tiles = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ 
        MyText(text: "Categorization",style: Theme.of(context).textTheme.displayLarge),
        const Line(), 
         // create a list of checkboxes for each place type in places types ENUM and add each selected item in selectedPlacesList and make the checkbox deeb purple if it is selected otherwise make it light purple note that place type is an ENUM make it show only if i pressed on a button 
        for (var placeType in placeTypes!)
          CheckboxListTile(
            visualDensity: VisualDensity.compact,
            dense: true,
            selectedTileColor: ColorManager.newPrimary,
            title: MyText(text: placeType.toString().split('.').last,style: Theme.of(context).textTheme.displayLarge),
            value: selectedPlaceTypes.contains(placeType.toString().split('.').last),
            secondary: const Icon(Icons.place_outlined),
            onChanged: (value) {
              setState(() { 
                if (value!) { 
                  selectedPlaceTypes.add(placeType.toString().split('.').last);
                } else { 
                  selectedPlaceTypes.remove(placeType.toString().split('.').last);
                } 
              });
              widget.getTypes(selectedPlaceTypes);
            }, 
          ),
     ], 
    );
  }
}
