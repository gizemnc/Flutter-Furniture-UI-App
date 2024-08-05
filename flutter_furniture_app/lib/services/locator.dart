
import 'package:flutter_furniture_app/repository/user_repository.dart';
import 'package:flutter_furniture_app/services/fake_auth_service.dart';
import 'package:flutter_furniture_app/services/firebase_auth_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator(){
 locator.registerLazySingleton<FirebaseAuthService>(()=>FirebaseAuthService());
 locator.registerLazySingleton<FakeAuthService>(()=>FakeAuthService());
 locator.registerLazySingleton<UserRepository>(()=>UserRepository());
}
