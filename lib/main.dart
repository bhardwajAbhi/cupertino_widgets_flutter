import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_widgets/model/app_state_model.dart';
import 'app.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  return runApp(ChangeNotifierProvider<AppStateModel>(
    create: (context) => AppStateModel()..loadProducts(),
    child: CupertinoStoreApp(),
  ));
}
