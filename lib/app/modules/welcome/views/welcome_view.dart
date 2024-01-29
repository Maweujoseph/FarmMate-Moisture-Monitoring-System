import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monitoring_project/app/modules/dashboard/screens/components/dashboard_content.dart';
import 'package:monitoring_project/app/modules/dashboard/screens/dash_board_screen.dart';
import 'package:monitoring_project/app/modules/sign_in/user_sign_in.dart';
import 'package:monitoring_project/app/modules/sign_up/sign_up_user.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';*/
import 'package:monitoring_project/app/modules/common/toast.dart';
import 'package:monitoring_project/app/modules/user_auth/firebase_auth_services.dart';



import '../../../../config/translations/strings_enum.dart';
import '../../../../utils/constants.dart';
import '../../../components/custom_button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(Constants.welcome, fit: BoxFit.cover),
          ),
          Center(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: screenWidth > 300 ? 300 : screenWidth),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSmoothIndicator(
                      activeIndex: 1,
                      count: 3,
                      effect: WormEffect(
                        activeDotColor: Colors.green,
                        dotColor: theme.colorScheme.secondary,
                        dotWidth: 10,
                        dotHeight: 10,
                      ),
                    ),
                    24.verticalSpace,
                    Text(
                      Strings.welcomScreenTitle.tr,
                      style: theme.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ).animate().fade().slideY(
                          duration: 300.ms,
                          begin: -1,
                          curve: Curves.easeInSine,
                        ),
                    16.verticalSpace,
                    Text(
                      Strings.welcomScreenSubtitle.tr,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 16, // Fixed font size
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ).animate(delay: 300.ms).fade().slideY(
                          duration: 300.ms,
                          begin: -1,
                          curve: Curves.easeInSine,
                        ),
                    const SizedBox(height: 20),
                    CustomButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage())),
                      text: Strings.getStarted.tr,
                      fontSize: 18,
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      width: 265,
                      radius: 30,
                      verticalPadding: 20,
                    ).animate().fade().slideY(
                          duration: 300.ms,
                          begin: 1,
                          curve: Curves.easeInSine,
                        ),
                    20.verticalSpace,
                    Text(
                      '-------or sign in with--------',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Adjust as needed
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/google.svg',
                            width: 23,
                            height: 23,
                          ),
                          iconSize: 40, // Adjust the icon size as needed
                          onPressed: () {
                            // Handle Google sign-in
                            _signInWithGoogle(context);
                          },
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/x-twitter.svg',
                            width: 23,
                            height: 23,
                          ),
                          iconSize: 40, // Adjust the icon size as needed
                          onPressed: () {
                            // Handle Twitter sign-in
                          },
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/meta.svg',
                            width: 23,
                            height: 23,
                          ),
                          iconSize: 40, // Adjust the icon size as needed
                          onPressed: () {
                            // Handle Facebook sign-in
                          /* _signInWithFacebook(context);*/
                          },
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpPage()), //call sign_up widget
                                  (route) => false);
                            },
                            child: Text(
                              "signup",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ))
                      ],
                    )
                    /*Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: Strings.alreadyHaveAnAccount.tr,
                          style: theme.textTheme.bodyMedium,
                        ),
                        TextSpan(
                          text: Strings.login.tr,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                      ]),
                    ).animate(delay: 300.ms).fade().slideY(
                          duration: 300.ms,
                          begin: 1,
                          curve: Curves.easeInSine,
                        ),*/
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _signInWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: '837503318475-pqhu911k3o3gvv4hcbdq7dqud4fb615v.apps.googleusercontent.com',
 );

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DashBoardScreen()));
      }
    } catch (e) {
      showToast(message: "some error occured $e");
    }
  }

  /*_signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      switch(result.status) {
        case LoginStatus.success:
          // Handle successful login
          // Access user information using result.accessToken
          break;
        case LoginStatus.cancelled:
          // Handle user cancellation
          break;
        case LoginStatus.failed:
          // Handle login error
          showToast(message: "Facebook login error: ${result.message}");
          break;
        default:
        // Handle other cases
        break;
      }
    } catch (e) {
      showToast(message: "Facebook login error: $e");
    }
  }*/

 /*_signInWithFacebook(BuildContext context) async {
  final _facebookAuth = FacebookAuth.instance;

  try {
    // Trigger the sign-in flow
    final LoginResult loginResult = await _facebookAuth.login();

    // Check for null values and handle potential errors
    if (loginResult.status == LoginStatus.failed) {
      // Handle cases where login failed
      showToast(message: "Facebook login failed: ${loginResult.message}");
      return;
    }

    if (loginResult.accessToken == null) {
      // Handle cases where access token is not available
      showToast(message: "Facebook login failed: Access token not received");
      return;
    }

    // Create a credential from the access token (safely using conditional access)
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Sign in with Firebase using the credential
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    // Navigate to DashboardContent
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DashboardContent()));
      } on FirebaseAuthException catch (e) {
        // ... (existing error handling)
      } catch (e) {
        // ... (existing error handling)
      }
  }
  */
}
