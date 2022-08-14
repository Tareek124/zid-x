import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants/pages.dart';
import 'logic/utils/functions/logged_user.dart';
import 'routing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'view/screens/profile_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const FruitMarket());
}

class FruitMarket extends StatefulWidget {
  const FruitMarket({Key? key}) : super(key: key);

  @override
  State<FruitMarket> createState() => _FruitMarketState();
}

class _FruitMarketState extends State<FruitMarket> {
  final user = loggedUser();

  @override
  void initState() {
    super.initState();
  }

  final AppRoutes appRoutes = AppRoutes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'poppins'),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      onGenerateRoute: appRoutes.generateRoute,
      initialRoute: user == null ? splashScreen : mainScreen,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
    );
  }
}
