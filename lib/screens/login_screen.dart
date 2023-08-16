import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:storeonline/Helbers/chickDataHelber.dart';
import 'package:storeonline/Helbers/nav_helber.dart';
import 'package:storeonline/enums.dart';
import 'package:storeonline/firebase/fb_auth_controller.dart';
import 'package:storeonline/firebase/users_fb_controller.dart';
import 'package:storeonline/providers/auth_provider.dart';
import 'package:storeonline/providers/cache/cache_controller.dart';
import 'package:storeonline/screens/home_page_screen.dart';
import 'package:storeonline/screens/main_screen_login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:storeonline/screens/sign_up_screen.dart';
import 'package:storeonline/witgets/my_button.dart';
import 'package:storeonline/witgets/my_text_filed.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with NavHelper, ChickData {
  AppLocalizations get localizations => AppLocalizations.of(context)!;
  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;
  bool obscure = false;
  bool loader = false;

  @override
  void initState() {
    super.initState();
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
  }

  @override
  void deactivate() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenLogin(
      titel: localizations.welcomeBack,
      supTitle: localizations.supTitel,
      widget: Container(
        width: double.infinity.w,
        height: 320.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(25.w),
            topStart: Radius.circular(25.w),
          ),
        ),
        child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            children: [
              MyTextField(
                editingController: emailEditingController,
                hint: localizations.email,
                colorBackground: const Color(0xffFAFAF4),
                colorHint: const Color(0xffA0A0A0),
                inputAction: TextInputAction.next,
                isFocus: false,
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              MyTextField(
                editingController: passwordEditingController,
                hint: localizations.password,
                colorBackground: const Color(0xffFAFAF4),
                colorHint: const Color(0xffA0A0A0),
                isSuffixIcon: true,
                isPassword: true,
                obscure: obscure,
                isFocus: false,
                focsNods: true,
                obscureCallBack: (_) => setState(() => obscure = _),
                inputAction: TextInputAction.next,
                inputType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => jump(context, const SignUpScreen(), false),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Text(localizations.register,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                          )),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => gust(),
                      child: Text(localizations.gust,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              MyButton(
                text: localizations.login.toUpperCase(),
                sizeText: 14.sp,
                loader: loader,
                colorText: Colors.black,
                onTap: () async => await _performLogin,
                colorButton: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> get _performLogin async {
    if (_checkData) {
      await _login;
    }
  }

  Future<void> get _login async {
    setState(() => loader = true);
    try {
      var authStatus = await FbAuthController().login(
          email: emailEditingController.text,
          password: passwordEditingController.text);

      if (authStatus == null) throw Exception('Auth Error !!');

      /// Save Login
      await CacheController().setter(CacheKeys.loggedIn, true);
      await CacheController()
          .setter(CacheKeys.email, emailEditingController.text);

      /// Get User by Email from Firestore
      var user = await UsersFbController().show(emailEditingController.text);

      if (user == null) throw Exception('User Not Found!');

      if (context.mounted) {
        Provider.of<AuthProvider>(context, listen: false).user = user;
        showSnackBar(context, 'Logged In Successfully!', false);
        jump(context, const HomePageScreen(), true);
      }
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
    setState(() => loader = false);
  }

  bool get _checkData {
    String email = emailEditingController.text.trim();
    String password = passwordEditingController.text.trim();
    if (email.isEmpty) {
      showSnackBar(context, localizations.pleaseEnterYourEmail, true);
      return false;
    } else if (password.isEmpty) {
      showSnackBar(context, localizations.pleaseEnterYourPassword, true);
      return false;
    } else {
      return true;
    }
  }

  void gust() {
    var user = FbAuthController().loginAsVisitor();
    if (user != null) {
      jump(context, const HomePageScreen(), true);
      showSnackBar(context, 'Logged In Successfully!', false);
    }
  }
}
