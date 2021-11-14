import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travelapp/components/form_error.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/repository/user_repository.dart';
import 'package:flutter_travelapp/screens/profile/profile_screen.dart';
import 'package:flutter_travelapp/size_config.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  dynamic inforUser;
  String labelemail = "";
  String labelpassword = "";
  String labelphone = "";
  String labeladdress = "";
  String labelname = "";
  String avatar =
      "https://firebasestorage.googleapis.com/v0/b/travel-app-34be2.appspot.com/o/unknown.jpg?alt=media&token=3dbbbcec-60e1-419b-89b8-cedb9d7f0514";

  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getInforUser();
    // editProfile(labelname, labeladdress, labelphone, image);
    // labelemail;
    // labelpassword;
    // labelphone;
    // labelname;
    // avatar;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getInforUser() async {
    dynamic inforUser = await UserRepository().getProfile();
    setState(() {
      //ten = inforUser;
      //Map<String, dynamic> user = inforUser;
      avatar = inforUser['avatar'];
      labelemail = inforUser['email'];
      labelpassword = inforUser['password'];
      labelphone = inforUser['phone'];
      labeladdress = inforUser['address'];
      labelname = inforUser['name'];
    });
  }

  bool showPassword = false;
  // late String email;
  // late String password;
  // late String phone;
  // late String address;
  // late String name;

  final List<String> errors = [];
  void editProfile(String name, String address, String phone, File? image) {
    setState(() {
      name;
      address;
      phone;
      image;
    });
    // print(name);
    // print(address);
    print("Hello" + phone);
    if (image != null) {
      UserRepository().updateAvatar(image);
    }
    UserRepository().editProfile(name, address, phone).then((value) {
      if (value != null) {
        removeError(error: kEditProfileFail);
        Get.snackbar(
          'Cập nhật thông tin',
          'Cập nhật thông tin thành công',
          snackPosition: SnackPosition.TOP,
          colorText: kPrimaryLightColor,
          backgroundColor: kPrimaryColor,
          duration: const Duration(
            milliseconds: 800,
          ),
        );
        Future.delayed(const Duration(milliseconds: 800), () {
          // Here you can write your code

          setState(() {
            Navigator.pushNamed(context, ProfileScreen.routeName);
          });
        });
      }
    });
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: kPrimaryColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SizedBox(
        child: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                const Text(
                  "Cập Nhật Thông Tin",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Center(
                  child: Stack(
                    children: [
                      image != null
                          ? Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(0, 10))
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(image!)
                                      )),
                            )
                          : Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(0, 10))
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(avatar),

                                    //AssetImage("assets/images/Profile Image.png"),
                                  )),
                            ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(color: Colors.white),
                              ),
                              primary: Colors.white,
                              backgroundColor: const Color(0xFFF5F6F9),
                            ),
                            onPressed: () => pickImage(ImageSource.gallery),
                            //onPressed: () {},
                            child: SvgPicture.asset(
                                "assets/icons/Camera Icon.svg"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildTextField(
                    labelemail,
                    "E-mail",
                    labelemail,
                    false,
                    true,
                    const Icon(
                      Icons.email_outlined,
                      color: kPrimaryColor,
                    )),
                buildTextField(
                    labelname,
                    "Họ và tên",
                    //"Huỳnh Nhựt Thiên",
                    labelname,
                    false,
                    false,
                    const Icon(
                      Icons.account_circle,
                      color: kPrimaryColor,
                    )),
                buildTextField(
                    labelphone,
                    "Số điện thoại",
                    labelphone,
                    false,
                    false,
                    const Icon(
                      Icons.phone,
                      color: kPrimaryColor,
                    )),
                buildTextField(
                    labeladdress,
                    "Địa chỉ",
                    labeladdress,
                    false,
                    false,
                    const Icon(
                      Icons.home,
                      color: kPrimaryColor,
                    )),
                buildTextField(
                    "",
                    "Mật khẩu",
                    "123456789AsZx",
                    true,
                    false,
                    const Icon(
                      Icons.remove_red_eye,
                      color: kPrimaryColor,
                    )),
                FormError(errors: errors),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Hủy",
                          style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 5.5,
                              color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        editProfile(labelname, labeladdress, labelphone, image);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text(
                        "Lưu",
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 5.5,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String? input, String? labelText, String? placeholder,
      bool isPasswordTextField, bool isEmailTextField, Icon icon) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          initialValue: placeholder,
          obscureText: isPasswordTextField ? !showPassword : false,
          enabled: isPasswordTextField
              ? false
              : isEmailTextField
                  ? false
                  : true,
          keyboardType: TextInputType.text,
          onSaved: (newValue) => input == newValue!,
          onChanged: (value) {
            if (value.isNotEmpty) {
              removeError(error: kPhoneNumberNullError);
            }
            input == value;
            return;
          },
          validator: (value) {
            if (value!.isEmpty) {
              addError(error: kAddressNullError);
              return "";
            }
            return null;
          },
          decoration: InputDecoration(
              suffixIcon: isPasswordTextField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: icon,
                    )
                  : IconButton(
                      onPressed: () {},
                      icon: icon,
                    ),

              //contentPadding: EdgeInsets.only(bottom: 50),
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ));

    // return Padding(
    //   padding: const EdgeInsets.only(bottom: 35.0),
    //   child:
    //   TextFormField(
    //     obscureText: isPasswordTextField ? showPassword : false,
    //     decoration: InputDecoration(
    //         suffixIcon: isPasswordTextField
    //             ? IconButton(
    //                 onPressed: () {
    //                   setState(() {
    //                     showPassword = !showPassword;
    //                   });
    //                 },
    //                 icon: Icon(
    //                   Icons.remove_red_eye,
    //                   color: Colors.grey,
    //                 ),
    //               )
    //             : null,
    //         contentPadding: EdgeInsets.only(bottom: 3),
    //         labelText: labelText,
    //         floatingLabelBehavior: FloatingLabelBehavior.always,
    //         hintText: placeholder,
    //         hintStyle: TextStyle(
    //           fontSize: 16,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.black,
    //         )),
    //   ),
    // );
  }
}
