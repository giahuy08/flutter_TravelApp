import 'package:flutter/material.dart';
import 'package:flutter_travelapp/models/user.dart';
import 'package:flutter_travelapp/repository/user_repository.dart';
import 'package:get_storage/get_storage.dart';

class UserProvider extends ChangeNotifier {
  final _getStorage = GetStorage();
  final storageKey = 'token';
  dynamic _user;

  dynamic get user => _user;

  setUser(dynamic data) async {
    print(_user);
    _user = data;
    if (user != null) {
      await UserRepository().getProfile().then((value) {
        _user = UserModel.fromMap(value);
        print(_user);
        _user.token = data.token;
      });
      _getStorage.write(storageKey, user!.token);
    } else {
      _getStorage.remove(storageKey);
    }
    notifyListeners();
  }

  // setUserGoogle(String data){
  //   if(data!=null){
  //        _getStorage.write(storageKey, user!.token);
  //   }
  //   else {
  //     _getStorage.write(storageKey, '');
  //   }
  //   notifyListeners();
  // }

  Future checkLogined() async {
    String token = await _getStorage.read(storageKey) ?? '';
    if (token != '') {
      _user = UserModel(token: token);
      await UserRepository().getProfile().then((value) {
        _user = UserModel.fromMap(value);
        _user.token = token;
      });
    } else {
      _user = null;
    }
  }

  // getInfoUser(Map<String, dynamic> data) {
  //   print(data['role']);
  //   _user.userId = data['_id'];
  //   _user.address = data['address'];
  //   _user.fullName = data['displayName'];
  //   _user.image = data['avatar'] == null || data['avatar'] == ''
  //       ? icon_app
  //       : data['avatar'];
  //   _user.phone = data['phone'];
  //   _user.role = data['role'];
  //   _user.username = data['userName'];
  //   _user.priceShipPTH = data['priceShipPTH'];
  //   _user.priceShipPTN = data['priceShipPTN'];
  //   _user.priceShipReceived = data['priceShipReceived'];
  //   _user.area = data['area'];
  //   notifyListeners();
  // }

  // updateShippingFee(Map<String, dynamic> data) {
  //   _user.priceShipPTH = data['priceShipPTH'];
  //   _user.priceShipPTN = data['priceShipPTN'];
  //   _user.priceShipReceived = data['priceShipReceived'];
  //   notifyListeners();
  // }
}

UserProvider userProvider = UserProvider();
