
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:xingpin_mall_app/router/index.dart' as router;
import 'package:xingpin_mall_app/router/routers.dart';
import 'package:xingpin_mall_app/store/app_store.dart';
import 'package:xingpin_mall_app/store/cart_store.dart';
import 'package:xingpin_mall_app/utils/locale_lang_util.dart';
import 'package:xingpin_mall_app/utils/translations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStore()),
        ChangeNotifierProvider(create: (_) => CartStore()),
      ],
      child: Consumer<AppStore>(
        builder: (context,userStore,_){
          return MaterialApp(
            title: '星品之家',
            theme: Provider.of<AppStore>(context,listen: false).themeData,
            initialRoute: RouterNames.root,
            /// 注册路由
            onGenerateRoute: router.routeGenerator,
            /// 国际化
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              TranslationsDelegate(),
            ],
            supportedLocales: localeLangUtil.supportedLocales(),
          );
        },
      ),
    );
  }


}



