import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ip_pharmacy_admin/feature/authentication/view/widgets/custom_text_form.dart';
import 'package:ip_pharmacy_admin/shared/utils/image_helper/image_helper.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final TextEditingController textEditingController = TextEditingController();
  List<XFile?>? images;
  CroppedFile? croppedImage;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(microseconds: 270));
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController);

    animationController.forward();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 270),
      scale: animation.value,
      child: AlertDialog(
        title: const Text('Add a category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: InkWell(
              onTap: () async {
                images = await ImageHelper().pickImage();
                croppedImage = await ImageHelper().crop(file: images!.first!, cropStyle: CropStyle.circle);
                setState(() {});
              },
              child: FittedBox(
                child: CircleAvatar(
                  maxRadius: 80,
                  foregroundImage: FileImage(File(
                    croppedImage == null
                        ? images != null
                            ? images!.first!.path
                            : ''
                        : croppedImage!.path,
                  )),
                ),
              ),
            )),
            CustomTextForm(
              controller: textEditingController,
              obscure: false,
              labelText: 'Category Name',
              hintText: 'Category Name',
              keyboardType: TextInputType.name,
              validationText: '',
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          MaterialButton(
            textColor: Colors.red,
            onPressed: () async {
              await animationController.reverse().then((value) {
                Navigator.pop(context);
              });
            },
            child: const Text('Cancel'),
          ),
          MaterialButton(
            textColor: Colors.green,
            onPressed: () {},
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
