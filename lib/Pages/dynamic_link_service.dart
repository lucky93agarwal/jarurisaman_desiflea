import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  Future handleDynamicLinks() async {
    // STARTUP FROM DYNAMIC LINK LOGIC
    // Get initial dynamic link if the app is started using the link
    // प्रारंभिक डायनामिक लिंक प्राप्त करें यदि ऐप को लिंक का उपयोग करके शुरू किया गया है
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(data);

    // INTO FOREGROUND FROM DYDNAMIC LINK LOGIC
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
          _handleDeepLink(dynamicLinkData);
        },

        onError: (OnLinkErrorException e) async {
          print('Dynamic Link Failed: ${e.message}');
        }
    );


  }



  void _handleDeepLink(PendingDynamicLinkData data){
    final Uri deepLink = data?.link;
    if(deepLink != null){
      print('_handleDeepLink | deepLink: $deepLink');
    }
  }
}