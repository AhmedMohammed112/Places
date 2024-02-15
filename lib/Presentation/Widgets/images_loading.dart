import 'package:flutter/Material.dart';
import 'package:my_places/Presentation/Widgets/places_loading.dart';

class ImagesLoading extends StatelessWidget {
  const ImagesLoading({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(6, (index) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Skeleton(
            height: 200,
          ),
        );
      }),
    );
  }
}

