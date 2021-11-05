import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/form_error.dart';
import 'package:flutter_travelapp/constants.dart';
import 'package:flutter_travelapp/models/user.dart';
import 'package:flutter_travelapp/repository/user_repository.dart';
import 'package:flutter_travelapp/screens/profile/profile_screen.dart';
import 'package:flutter_travelapp/size_config.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  //User? user;
  //User user = new User(id: '');
  String labelemail = "";
  String labelpassword = "";
  String labelphone = "";
  String labeladdress = "";
  String labelname = "";
  String avatar = "";
  //dynamic User = [];

  @override
  void initState() {
    super.initState();
    getInforUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getInforUser() async {
    dynamic inforUser = await UserRepository().getProfile();

    User user;
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
  String? email;
  String? password;
  String? phone;
  String? address;
  String? name;

  final List<String> errors = [];

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
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const ProfileScreen()));
            },
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
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
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
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: kPrimaryColor,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildTextField(
                    email,
                    "E-mail",
                    labelemail,
                    false,
                    true,
                    const Icon(
                      Icons.email_outlined,
                      color: kPrimaryColor,
                    )),
                buildTextField(
                    name,
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
                    phone,
                    "Số điện thoại",
                    labelphone,
                    false,
                    false,
                    const Icon(
                      Icons.phone,
                      color: kPrimaryColor,
                    )),
                buildTextField(
                    address,
                    "Địa chỉ",
                    labeladdress,
                    false,
                    false,
                    const Icon(
                      Icons.home,
                      color: kPrimaryColor,
                    )),
                buildTextField(
                    password,
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
                      onPressed: () {},
                      child: const Text("Hủy",
                          style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 5.5,
                              color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {},
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
          onSaved: (newValue) => input = newValue!,
          onChanged: (value) {
            if (value.isNotEmpty) {
              removeError(error: kPhoneNumberNullError);
            }
            input = value;
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