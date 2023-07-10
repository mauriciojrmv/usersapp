import 'package:firebase_auth/firebase_auth.dart';
import 'package:users_app/models/direction_details_info.dart';
import 'package:users_app/models/user_model.dart';



final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List dList = []; //online-active drivers Information List
DirectionDetailsInfo? tripDirectionDetailsInfo;
String? chosenDriverId="";
String cloudMessagingServerToken = "key=AAAAWRlIk3k:APA91bHM1d3YHJ_lLPrl9n97bGDfVeKD1vu6oPSLHN3Nr9fXaXWTAxB-qjYHtGv5Y38KNxUDdH3qR9VhI8iZH8zRV7Q_riTs0TMTJIlA-M5LVabIDJW93SxTB98Bkc0rhDHz7nfHKtbl";
String userDropOffAddress = "";
String driverCarDetails="";
String driverName="";
String driverPhone="";
double countRatingStars=0.0;
String titleStarsRating="";