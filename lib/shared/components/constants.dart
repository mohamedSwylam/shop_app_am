
import 'package:shop_app_am/modules/Login/shop_login_screen.dart';
import 'package:shop_app_am/shared/network/local/cache_helper.dart';
import 'components.dart';

void signOut(context)=> CacheHelper.removeData(key: 'token').then((value) {
  if(value){
    navigateAndFinish(context, ShopLoginScreen());
  }
});
void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
String token='';