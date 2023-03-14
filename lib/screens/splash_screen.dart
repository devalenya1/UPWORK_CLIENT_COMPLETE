import '../app_config.dart';
import '../helpers/addons_helper.dart';
import '../helpers/auth_helper.dart';
import '../helpers/business_setting_helper.dart';
import '../helpers/shared_value_helper.dart';
import '../my_theme.dart';
import '../providers/locale_provider.dart';
import '../screens/main.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: AppConfig.app_name,
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getSharedValueHelperData(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            print("LocaleProvider Splash screen ${app_mobile_language.$}");
            print("LocaleProvider Splash screen ${app_language_rtl.$}");


            Future.delayed(Duration(seconds: 3)).then((value) {

              Provider.of<LocaleProvider>(context,listen: false).setLocale(app_mobile_language.$);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return Main(go_back: false,);
                  }));
            }
            );

          }
          return splashScreen();
        }
    );
  }

  Widget splashScreen() {
    return Container(
      color:  MyTheme.splash_screen_color,
      child: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Hero(
                    tag: "backgroundImageInSplash",
                    child: Container(
                      child: Image.asset(
                          "assets/splash_login_registration_background_image.png"),
                    ),
                  ),
                  radius: 140.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 60.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Hero(
                                tag: "splashscreenImage",
                                child: Container(
                                  child: Image.asset(
                                      "assets/app_logo.png"),
                                ),
                              ),
                              radius: 60.0,
                            ),
                          ),
                          Text(
                            "V " + _packageInfo.version,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                          ),
                          Text(
                            AppConfig.copyright_text,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String>  getSharedValueHelperData()async{
    access_token.load().whenComplete(() {
      AuthHelper().fetch_and_set();
    });
    AddonsHelper().setAddonsData();
    BusinessSettingHelper().setBusinessSettingData();
    await app_language.load();
    await app_mobile_language.load();
    await app_language_rtl.load();

    print("new splash screen ${app_mobile_language.$}");
    print("new splash screen app_language_rtl ${app_language_rtl.$}");

    return app_mobile_language.$;

  }
}
