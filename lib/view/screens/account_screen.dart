import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constants/colors.dart';
import '../../logic/cubit/account_cubit/account_cubit.dart';
import '../../logic/utils/functions/color_mode.dart';
import '../../logic/utils/functions/custom_size.dart';
import '../../logic/utils/functions/pick_image.dart';
import '../../logic/utils/functions/storage_function.dart';
import '../../logic/utils/widgets/account_listener.dart';
import '../../logic/utils/widgets/custom_button.dart';
import '../../logic/utils/widgets/custom_text_form_field.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController aboutContoller = TextEditingController();
  Uint8List? _image;
  String? profileImage;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    aboutContoller.dispose();
    super.dispose();
  }

  _pickImage() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
      Uint8List im = await pickImage(ImageSource.gallery);
      setState(() {
        _image = im;
      });
    } else {
      print("Is Denied");
    }

    profileImage = await StorageMethods()
        .uploadImageToStorage("profileimage", _image!, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CustomSize.defaultSize! * 1.5),
          child: Column(
            children: [
              AccountListtener(
                accountContext: context,
              ),
              Padding(
                padding: EdgeInsets.only(top: CustomSize.defaultSize! * 4),
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 40,
                      backgroundImage: _image != null
                          ? MemoryImage(_image!)
                          : const AssetImage("assets/images/avatar.png")
                              as ImageProvider,
                    ),
                    Positioned(
                        bottom: -15,
                        right: -1,
                        child: IconButton(
                            onPressed: _pickImage,
                            icon: Icon(
                              Icons.add_a_photo,
                              color: colorMode(context),
                            )))
                  ],
                ),
              ),
              SizedBox(
                height: CustomSize.defaultSize! * 5,
              ),
              const Text(
                "Name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: green,
                  fontSize: 22,
                ),
              ),
              CustomTextFieldOutline(
                textInputType: TextInputType.text,
                maxLines: 1,
                controller: nameController,
              ),
              SizedBox(
                height: CustomSize.defaultSize! * 5,
              ),
              const Text(
                "Phone Number",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: green,
                  fontSize: 22,
                ),
              ),
              CustomTextFieldOutline(
                textInputType: TextInputType.phone,
                maxLines: 1,
                controller: phoneController,
              ),
              SizedBox(
                height: CustomSize.defaultSize! * 5,
              ),
              const Text(
                "About You",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: green,
                  fontSize: 22,
                ),
              ),
              CustomTextFieldOutline(
                textInputType: TextInputType.text,
                maxLines: 4,
                controller: aboutContoller,
              ),
              SizedBox(
                height: CustomSize.defaultSize! * 3,
              ),
              CustomButton(
                function: () =>
                    BlocProvider.of<AccountCubit>(context).createAccount(
                  name: nameController.text,
                  about: aboutContoller.text,
                  profileImage: profileImage!,
                  phoneNumber: phoneController.text,
                ),
                text: "Get Started",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
