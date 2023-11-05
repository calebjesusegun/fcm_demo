import 'package:fcm_demo/core/model/push_notification.dart';
import 'package:fcm_demo/core/navigation/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../app/app_locator.dart';
import '../navigation/route.dart';
import '../services/fcm_service.dart';

class LoginViewModel extends ChangeNotifier {
  final _fcmService = locator<FcmService>();
  final auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  String? getUserId() {
    return auth.currentUser?.uid;
  }

  String getEmail() {
    return auth.currentUser!.email!;
  }

  void isBusy(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    try {
      isBusy(true);
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isBusy(false);
      return null;
    } on FirebaseAuthException catch (e) {
      isBusy(false);
      return e.message;
    } catch (e) {
      isBusy(false);
      return e.toString();
    }
  }

  void logout() async {
    await auth.signOut();
    notifyListeners();
  }

  Future sendPushNotification() async {
    try {
      isBusy(true);
      var data = await _fcmService.sendPushNotification();
      isBusy(false);
      notifyListeners();
      PushNotificationModel pushNotificationModel =
          PushNotificationModel.fromJson(data);
      if (pushNotificationModel.success == 1) {
        return data;
      }
    } catch (e) {
     AppNavigator.pushNamedReplacement(startupRoute);
    }
  }
}