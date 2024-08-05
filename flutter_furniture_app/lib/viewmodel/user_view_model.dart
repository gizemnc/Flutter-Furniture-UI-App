import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_furniture_app/model/user_model.dart';
import 'package:flutter_furniture_app/repository/user_repository.dart';
import 'package:flutter_furniture_app/services/auth_base.dart';
import 'package:flutter_furniture_app/services/locator.dart';

enum ViewState {
  idle,
  busy,
}

class UserViewModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.idle;
  final UserRepository _userRepository = locator<UserRepository>();
  UserModel? _user;

  UserModel? get user => _user;
  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await currentUser(); // Initialize user
    } catch (e) {
      debugPrint("Initialization error: $e");
    }
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      state = ViewState.busy;
      _user = await _userRepository.currentUser();
      return _user!;
    } catch (e) {
      debugPrint("ViewModel current user error: $e");
      rethrow;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserModel> signInAnonymously() async {
    try {
      state = ViewState.busy;
      _user = await _userRepository.signInAnonymously();
      return _user!;
    } catch (e) {
      debugPrint("ViewModel sign in anonymously error: $e");
      rethrow;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.busy;
      bool result = await _userRepository.signOut();
      _user = null; // Clear user data after sign out
      return result;
    } catch (e) {
      debugPrint("ViewModel sign out error: $e");
      return false;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      state = ViewState.busy;
      _user = await _userRepository.signInWithGoogle();
      return _user!;
    } catch (e) {
      debugPrint("ViewModel sign in Google error: $e");
      rethrow;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      state = ViewState.busy;
      _user = await _userRepository.signInWithFacebook();
      return _user!;
    } catch (e) {
      debugPrint("ViewModel sign in Facebook error: $e");
      rethrow;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    try {
      state = ViewState.busy;
      _user = await _userRepository.signInWithEmailAndPassword(email, password);
      return _user!;
    } catch (e) {
      debugPrint("ViewModel sign in email error: $e");
      rethrow;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword(String email, String password) async {
    try {
      state = ViewState.busy;
      _user = await _userRepository.createUserWithEmailAndPassword(email, password);
      return _user!;
    } catch (e) {
      debugPrint("ViewModel create user email error: $e");
      rethrow;
    } finally {
      state = ViewState.idle;
    }
  }
}
