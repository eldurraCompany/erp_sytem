import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config.dart';
import '../helpers/AppTheme.dart';
import '../helpers/SizeConfig.dart';
import '../helpers/otherHelpers.dart';
import '../locale/MyLocalizations.dart';
import '../pages/login.dart';

// ignore: must_be_immutable
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  static int themeType = 1;
  ThemeData themeData = AppTheme.getThemeFromThemeMode(themeType);
  CustomAppTheme customAppTheme = AppTheme.getCustomAppTheme(themeType);

  final _formKey = GlobalKey<FormState>();
  final clientIdController = TextEditingController();
  final clientSecretController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with current values from config
    Config.loadClientCredentials();
    clientIdController.text = Config.clientId;
    clientSecretController.text = Config.clientSecret;
  }

  @override
  void dispose() {
    clientIdController.dispose();
    clientSecretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                fit: BoxFit.fill,
                height: MySize.screenHeight! * 0.3,
                width: MySize.screenWidth,
                imageUrl: Config().splashScreen,
                placeholder: (context, url) => Transform.scale(
                  scale: 0.1,
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/splash_screen.png'),
              ),
              Text(AppLocalizations.of(context).translate('welcome'),
                  style: AppTheme.getTextStyle(
                      themeData.textTheme.headlineLarge,
                      color: themeData.colorScheme.onSurface)),
              SizedBox(height: MySize.size16!),
              // Configuration Form is only shown if Config.CleintHandled == false
              if (!Config.CleintHandled)
                Container(
                  margin: EdgeInsets.only(
                      left: MySize.size16!,
                      right: MySize.size16!,
                      top: MySize.size16!),
                  child: Card(
                    elevation: 8,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MySize.size12!,
                          left: MySize.size16!,
                          right: MySize.size16!,
                          bottom: MySize.size12!),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Client Configuration',
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.titleLarge,
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: 600),
                            ),
                            SizedBox(height: MySize.size16!),
                            TextFormField(
                              style: AppTheme.getTextStyle(
                                  themeData.textTheme.bodyLarge,
                                  letterSpacing: 0.1,
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: 500),
                              decoration: InputDecoration(
                                hintText: 'Client ID',
                                hintStyle: AppTheme.getTextStyle(
                                    themeData.textTheme.titleSmall,
                                    letterSpacing: 0.1,
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: 500),
                                prefixIcon: Icon(MdiIcons.identifier),
                              ),
                              controller: clientIdController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Client ID';
                                }
                                return null;
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(top: MySize.size16!),
                              child: TextFormField(
                                style: AppTheme.getTextStyle(
                                    themeData.textTheme.bodyLarge,
                                    letterSpacing: 0.1,
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: 500),
                                decoration: InputDecoration(
                                  hintText: 'Client Secret',
                                  hintStyle: AppTheme.getTextStyle(
                                      themeData.textTheme.titleSmall,
                                      letterSpacing: 0.1,
                                      color: themeData.colorScheme.onSurface,
                                      fontWeight: 500),
                                  prefixIcon: Icon(MdiIcons.key),
                                ),
                                controller: clientSecretController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter Client Secret';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: MySize.size16!),
              ElevatedButton.icon(
                onPressed: () async {
                  if (true) //(_formKey.currentState!.validate())
                  {
                    // Update config with new credentials
                    if (Config.CleintHandled == false) {
                      Config.updateClientCredentials(
                        clientIdController.text,
                        clientSecretController.text,
                      );
                    }

                    await Helper().requestAppPermission();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (prefs.getInt('userId') != null) {
                      USERID = prefs.getInt('userId');
                      Config.userId = USERID;
                      Helper().jobScheduler();
                      //Take to home page
                      Navigator.of(context).pushReplacementNamed('/home');
                      // Navigator.of(context).pushNamed('/home');
                    } else
                      // Navigator.of(context).pushReplacementNamed('/login');
                      Navigator.of(context).pushNamed('/login');
                  }
                },
                icon: Icon(Icons.navigate_next,
                    color: themeData.colorScheme.primary),
                label: Text(AppLocalizations.of(context).translate('login'),
                    style: AppTheme.getTextStyle(themeData.textTheme.bodyLarge,
                        color: themeData.colorScheme.primary, fontWeight: 600)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: themeData.colorScheme.onPrimary,
                    shadowColor: themeData.colorScheme.primary),
              ),
              Visibility(
                visible: Config().showRegister,
                child: Padding(
                  padding: EdgeInsets.all(MySize.size10!),
                  child: GestureDetector(
                    child: Text(
                        AppLocalizations.of(context).translate('register'),
                        style: AppTheme.getTextStyle(
                            themeData.textTheme.bodyLarge,
                            color: themeData.colorScheme.onSurface,
                            fontWeight: 600)),
                    onTap: () async {
                      await launch('${Config.baseUrl}business/register');
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
