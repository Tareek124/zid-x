import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/colors.dart';
import '../../data/account_model.dart';
import '../../logic/cubit/account_info_cubit/account_info_cubit.dart';
import '../../logic/cubit/post_ad_cubit/post_ad_cubit.dart';
import '../../logic/utils/functions/custom_size.dart';
import '../../logic/utils/widgets/custom_button.dart';
import '../../logic/utils/widgets/post_ad_listener.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import '../../logic/utils/functions/color_mode.dart';

import '../../logic/utils/functions/pick_image.dart';
import '../../logic/utils/functions/send_notification.dart';
import '../../logic/utils/functions/storage_function.dart';
import '../../logic/utils/widgets/custom_text_form_field.dart';

class PostAdScreen extends StatefulWidget {
  const PostAdScreen({Key? key}) : super(key: key);

  @override
  State<PostAdScreen> createState() => _PostAdScreenState();
}

class _PostAdScreenState extends State<PostAdScreen> {
  Uint8List? imageFile;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  AccountModel? accountModel;
  String? imageUrl;

  selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: colorMode(context),
          title: const Text(
            'Create a Post',
            style: TextStyle(),
          ),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo', style: TextStyle()),
                onPressed: () async {
                  Navigator.pop(context);
                  var permissions = await Permission.camera.request();
                  if (permissions.isGranted) {
                    Uint8List file = await pickImage(ImageSource.camera);
                    setState(() {
                      imageFile = file;
                    });
                    imageUrl = await StorageMethods()
                        .uploadImageToStorage("postPic", imageFile!, true);
                  } else {
                    print("Denied");
                  }
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: Text('Choose from Gallery',
                    style: TextStyle(
                      color: colorModeReversed(context),
                    )),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var permissions = await Permission.storage.request();
                  if (permissions.isGranted) {
                    Uint8List file = await pickImage(ImageSource.gallery);
                    setState(() {
                      imageFile = file;
                    });
                    imageUrl = await StorageMethods()
                        .uploadImageToStorage("postPic", imageFile!, true);
                  } else {
                    print("Denied");
                  }
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel", style: TextStyle()),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    BlocProvider.of<AccountInfoCubit>(context)
        .getUserInfos()
        .then((value) => accountModel = value);
    super.initState();
  }

  void clear() {
    setState(() {
      imageFile = null;
      descriptionController.clear();
      titleController.clear();
      priceController.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
    titleController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CustomSize.defaultSize! * 1.5,
          ),
          child: Column(
            children: [
              PostAdListener(accountContext: context),
              SizedBox(
                height: CustomSize.defaultSize! * 10,
              ),
              InkWell(
                onTap: () async {
                  await selectImage(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: green,
                      width: 2,
                    ),
                  ),
                  width: double.infinity,
                  height: CustomSize.defaultSize! * 17,
                  child: imageFile == null
                      ? Icon(
                          Icons.add_a_photo,
                          size: CustomSize.defaultSize! * 15,
                          color: Colors.black.withOpacity(0.5),
                        )
                      : Image.memory(imageFile!, fit: BoxFit.contain),
                ),
              ),
              SizedBox(
                height: CustomSize.defaultSize! * 4,
              ),
              CustomTextFieldOutline(
                controller: titleController,
                maxLines: 1,
                label: "Title",
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: CustomSize.defaultSize! * 4,
              ),
              CustomTextFieldOutline(
                controller: descriptionController,
                maxLines: 4,
                label: "Description",
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: CustomSize.defaultSize! * 4,
              ),
              CustomTextFieldOutline(
                controller: priceController,
                maxLines: 1,
                label: "Price",
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: CustomSize.defaultSize! * 4,
              ),
              CustomButton(
                text: "Post Your Ad",
                function: () {
                  BlocProvider.of<PostAdCubit>(context)
                      .postAPost(
                          price: priceController.text,
                          description: descriptionController.text,
                          imageUrl: imageUrl!,
                          uid: accountModel!.uid,
                          name: accountModel!.userName,
                          phoneNumber: accountModel!.phoneNumber,
                          title: titleController.text)
                      .whenComplete(() {
                    clear();
                  });
                  callOnFcmApiSendPushNotifications(
                      title: titleController.text,
                      imageUrl: imageUrl!,
                      phoneNumber: accountModel!.phoneNumber,
                      uid: accountModel!.uid,
                      name: accountModel!.userName,
                      description: descriptionController.text,
                      price: priceController.text);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
