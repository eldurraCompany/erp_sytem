import 'package:flutter/material.dart';

import '../helpers/AppTheme.dart';
import '../helpers/SizeConfig.dart';
import '../helpers/style.dart' as style;
import '../locale/MyLocalizations.dart';

Widget posBottomBar(page, context, [call]) {
  ThemeData themeData = AppTheme.getThemeFromThemeMode(1);
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: Offset(0, -2),
        ),
      ],
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Container(
        height: MySize.size70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            bottomBarMenu(
                context,
                '/home',
                AppLocalizations.of(context).translate('home'),
                page == "home",
                Icons.home_rounded,
                true),
            bottomBarMenu(
                context,
                '/products',
                AppLocalizations.of(context).translate('products'),
                page == "products",
                Icons.inventory_2_rounded,
                true),
            bottomBarMenu(
                context,
                '/sale',
                AppLocalizations.of(context).translate('sales'),
                page == "sale",
                Icons.receipt_long_rounded,
                true),
          ],
        ),
      ),
    ),
  );
}

Widget bottomBarMenu(context, route, name, isSelected, icon,
    [replace, arguments]) {
  replace = (replace == null) ? false : replace;
  return GestureDetector(
    onTap: () {
      if (replace)
        Navigator.pushReplacementNamed(context, route, arguments: arguments);
      else
        Navigator.pushNamed(context, route, arguments: arguments);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: isSelected ? Colors.white : Color(0xFF718096),
            size: 24,
          ),
          if (isSelected)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                name,
                style: AppTheme.getTextStyle(
                  Theme.of(context).textTheme.bodyMedium,
                  color: Colors.white,
                  fontWeight: 600,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

Widget cartBottomBar(route, name, context, [nextArguments]) {
  ThemeData themeData = AppTheme.getThemeFromThemeMode(1);
  //TODO: add some shadows.
  return Material(
    child: Container(
      color: themeData.colorScheme.onPrimary,
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          bottomBarMenu(context, route, name, true, Icons.arrow_forward, false,
              nextArguments),
        ],
      ),
    ),
  );
}

//syncAlert
syncing(time, context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(),
        Container(
            margin: EdgeInsets.only(left: 5),
            child: Text("Sync in progress...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: time), () {
        Navigator.of(context).pop(true);
      });
      return alert;
    },
  );
}
