import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/domain/user_credencial_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/modules/my_application/src/authentication/data/use_cases/auth_signin_user_case_impl.dart';
import 'app/modules/my_application/src/authentication/domain/user_credencial_entity.dart';
import 'app/modules/my_application/src/authentication/external/cache/auth_local_cache_sp_impl.dart';
import 'app/modules/my_application/src/authentication/manager/auth_service_manager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //permite que seja assincrona rodando no android
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  return runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
