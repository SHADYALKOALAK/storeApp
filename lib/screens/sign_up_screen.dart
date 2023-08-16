import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storeonline/Helbers/chickDataHelber.dart';
import 'package:storeonline/Helbers/nav_helber.dart';
import 'package:storeonline/firebase/fb_auth_controller.dart';
import 'package:storeonline/firebase/models/user_model.dart';
import 'package:storeonline/firebase/users_fb_controller.dart';
import 'package:storeonline/screens/main_screen_login.dart';
import 'package:storeonline/witgets/my_button.dart';
import 'package:storeonline/witgets/my_text_filed.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with NavHelper, ChickData {
  AppLocalizations get localizations => AppLocalizations.of(context)!;
  late TextEditingController userNameEditingController;
  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;
  late TextEditingController cPasswordEditingController;
  bool obscure = false;
  bool cObscure = false;
  bool loader = false;
  bool chickBox = false;

  @override
  void initState() {
    super.initState();
    userNameEditingController = TextEditingController();
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    cPasswordEditingController = TextEditingController();
  }

  @override
  void deactivate() {
    userNameEditingController.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
    cPasswordEditingController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenLogin(
      titel: localizations.letGetStarted,
      supTitle: localizations.supTitel,
      widget: Container(
        width: double.infinity.w,
        height: 440.h,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyTextField(
                  editingController: userNameEditingController,
                  hint: localizations.userName,
                  colorBackground: const Color(0xffFAFAF4),
                  colorHint: const Color(0xffA0A0A0),
                  inputAction: TextInputAction.go,
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                MyTextField(
                  editingController: emailEditingController,
                  hint: localizations.email,
                  colorBackground: const Color(0xffFAFAF4),
                  colorHint: const Color(0xffA0A0A0),
                  inputAction: TextInputAction.next,
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
                  focsNods: true,
                  obscureCallBack: (_) => setState(() => obscure = _),
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 16.h),
                MyTextField(
                  editingController: cPasswordEditingController,
                  hint: localizations.cPassword,
                  colorBackground: const Color(0xffFAFAF4),
                  colorHint: const Color(0xffA0A0A0),
                  isSuffixIcon: true,
                  isPassword: true,
                  obscure: cObscure,
                  focsNods: true,
                  onSubmit: (p0) async => await _performRegister,
                  obscureCallBack: (_) => setState(() => cObscure = _),
                  inputType: TextInputType.visiblePassword,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 5.w),
                  child: Row(
                    children: [
                      Checkbox(
                        value: chickBox,
                        onChanged: (value) => setState(() => chickBox = value!),
                        activeColor: Theme.of(context).primaryColor,
                      ),
                      Expanded(child: Text(localizations.policy))
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                MyButton(
                  text: localizations.register.toUpperCase(),
                  sizeText: 14.sp,
                  loader: loader,
                  colorText: Colors.black,
                  onTap: () async => await _performRegister,
                  colorButton: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> get _performRegister async {
    if (_checkData) {
      await _register;
    }
  }

  Future<void> get _register async {
    setState(() => loader = true);
    try {
      /// Auth
      var authStatus = await FbAuthController().createAccount(
          email: emailEditingController.text.trim(),
          password: passwordEditingController.text.trim());

      if (authStatus == null) throw Exception('Auth Error!');

      /// Firestore
      bool firestoreStatus = await UsersFbController().create(UserModel(
        id: authStatus.user?.uid,
        email: emailEditingController.text.trim(),
        password: passwordEditingController.text.trim(),
        name: userNameEditingController.text.trim(),
        cPassword: cPasswordEditingController.text.trim(),
        image: null,
      ));

      if (!firestoreStatus) throw Exception('Firestore Error!');

      if (context.mounted) {
        showSnackBar(context, 'Account Created Successfully!', false);
        Navigator.pop(context);
      }
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
    setState(() => loader = false);
  }

  bool get _checkData {
    String fullName = userNameEditingController.text.trim();
    String email = emailEditingController.text.trim();
    String password = passwordEditingController.text.trim();
    String cPassword = cPasswordEditingController.text.trim();
    if (fullName.isEmpty) {
      showSnackBar(context, localizations.pleaseEnterYourFullName, true);
      return false;
    } else if (email.isEmpty) {
      showSnackBar(context, localizations.pleaseEnterYourEmail, true);
      return false;
    } else if (password.isEmpty) {
      showSnackBar(context, localizations.pleaseEnterYourPassword, true);
      return false;
    } else if (cPassword.isEmpty) {
      showSnackBar(context, localizations.pleaseEnterYourConfirmPassword, true);
      return false;
    } else if (cPassword != password) {
      showSnackBar(context, localizations.makeSureThePasswordMatches, true);
      return false;
    } else if (!email.contains('@gmail.com')) {
      showSnackBar(context, localizations.pleaseEnterYourEmail, true);
      return false;
    } else if (password.length < 6) {
      showSnackBar(
          context, localizations.passwordMusterLongerThanCharacters, true);
      return false;
    } else {
      return true;
    }
  }
}
