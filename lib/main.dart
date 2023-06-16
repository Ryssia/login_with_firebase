import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/modules/my_application/src/authentication/data/use_cases/auth_signin_user_case_impl.dart';
import 'app/modules/my_application/src/authentication/domain/user_credencial_entity.dart';
import 'app/modules/my_application/src/authentication/manager/auth_service_manager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // var user1 = await FirebaseAuth.instance
  //     .signInWithEmailAndPassword(email: 'aa@com.br', password: '123456');

  // var service = AuthServiceManager(AuthType.email);
  // var useCase = AuthSignInUserCaseImpl(service());
  // var resp = await useCase('aa@com.br', '123456');
  // // var resp = await useCase('aa', '123456', 'maria');
  // resp.fold((l) {
  //   print('entrou aqui');
  //   print(l);
  //   print(l);
  // }, (r) {
  //   print(r.email);
  // });
  // // var teste = FirebaseAuth.instance.currentUser!;
  // print('Teste de currente user');
  // print(teste.email);
  // var teste2 = await teste.getIdTokenResult();
  // print(teste2.authTime);
  // await FirebaseAuth.instance.signOut();

  // var service = AuthServiceManager(AuthType.email);
  // var useCase = AuthSignUpUserCaseImpl(service());
  // var resp = await useCase('cc@com.br', '123456', 'joao');

  // var user = await FirebaseAuth.instance
  //     .signInWithEmailAndPassword(email: 'aa@com.br', password: '123456');
  // var ref = FirebaseFirestore.instance.collection('Users');
  // var t = await ref.doc(user.user?.uid).get();

  // var users = await FirebaseFirestore.instance
  //     .collection('Users')
  //     .doc(user.user?.uid)
  //     .get();

  //print(t.data());

  /* parte testada 

  var service = AuthServiceManager(AuthType.email);
  var useCase = AuthSignInUserCaseImpl(service());
  var resp = await useCase('aa@com.br', '123456');

  resp.fold((l) {
    print('entrou aqui');
    print(l);
    print(l);
  }, (r) {
    print(r.email);
  });

   fim da parte testada*/

  //FirebaseFirestore.instance.collection('teste').add({'teste': 'ola mundo'});

  // try {
  //   await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: 'aa@com.br', password: '123452');
  // } on FirebaseAuthException catch (e) {
  //   if (e.message!.contains('wrong-password')) {
  //     throw UserWrongPassword('classe errada');
  //   }
  // } catch (e) {
  //   print(e);
  // }
  return runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
