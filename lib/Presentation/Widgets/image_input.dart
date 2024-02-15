import 'dart:io';

import 'package:flutter/Material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_places/Common/Resources/color_manager.dart';
import 'package:my_places/Common/Resources/values_manager.dart';
import 'package:my_places/Presentation/Widgets/my_text.dart';

class ImageInput extends StatefulWidget {
   ImageInput({super.key, required this.onImageSelected}); 
  
  final void Function(List<File> pickedImage) onImageSelected;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final imagePicker = ImagePicker(); 
  File? imageFile;
  List<File> selectedImages = []; // List of selected image


  void takePicture() async {
     final XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

      if (pickedImage == null) {
        return;
      }

      setState(() {
        imageFile = File(pickedImage.path);
      });

      selectedImages.add(imageFile!);
      widget.onImageSelected(selectedImages);
  }

  void uploadImageFromGallery() async
  {
    final pickedFile = await imagePicker.pickMultiImage(
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        setState(() {
          imageFile = File(xfilePick[i].path);
        });
        selectedImages.add(imageFile!);
      }
      print(selectedImages.length);
       widget.onImageSelected(selectedImages);
    } else {

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')));
    }
  }

  Widget content() {
    if(imageFile == null && selectedImages.isEmpty)
    {
      return _showBottomSheet();
    } 
    else 
    {
      return InkWell(
        onTap: takePicture,
          child: _buildImageItem()
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container( 
      height: AppSizes.s250,
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s16),
        border: Border.all(width: 2,color: ColorManager.newPrimary),
        //borderRadius: BorderRadius.circular(AppPadding.p16),
      ), 
      child: content(), 
    );
  }

  Widget _showBottomSheet() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: AppSizes.s120,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera),
                            title: MyText(text: 'Camera',size: AppSizes.s15,style: Theme.of(context).textTheme.labelMedium),
                            onTap: () {
                              takePicture();
                            },
                            trailing: const Icon(Icons.arrow_forward_ios_outlined),
                          ),
                          ListTile(
                            leading: const Icon(Icons.image),
                            title: MyText(text: 'Gallery',size: AppSizes.s15,style: Theme.of(context).textTheme.labelMedium),
                            onTap: () {
                              Navigator.pop(context);
                              uploadImageFromGallery();
                            },
                            trailing: const Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: const Icon(Icons.image, size: 50, )),
        TextButton(
          onPressed: () {
            takePicture();
          },
          child: MyText(text:'Add Image',style: Theme.of(context).textTheme.labelMedium),
        ),
      ],
    );
  }

  Widget _buildImageItem() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(selectedImages.length, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.s16),
                child: Image.file(
                  selectedImages[index],
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedImages.removeAt(index);
                  });
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: ColorManager.transparent,
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: ColorManager.white,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

