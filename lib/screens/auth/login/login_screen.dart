import 'package:alandalos/api_service/connectivity/no_internet_screen.dart';
import 'package:alandalos/core/app_loader.dart';
import 'package:alandalos/core/extensions/num_extensions.dart';
import 'package:alandalos/core/utils/showToast.dart';
import 'package:alandalos/custom_widgets/custom_buttom.dart';
import 'package:alandalos/custom_widgets/new/customTextFormField.dart';
import 'package:alandalos/screens/auth/login/auth_provider.dart';
import 'package:alandalos/utils/res.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/locale_keys.g.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void _onSubmit(BuildContext context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        String email = _emailController.text;
        String password = _passwordController.text;
        if (email.isEmpty) {
          ToastUtils.showToast(LocaleKeys.enterEmail.tr());
        }
        else if (email.isValidEmail() == false) {
          ToastUtils.showToast(LocaleKeys.checkEmail.tr());
        }
        else if (password.isEmpty) {
          ToastUtils.showToast(LocaleKeys.enterPassword.tr());
        } else {
          Provider.of<AuthProvider>(context, listen: false)
              .login(email: email, context: context, password: password);
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: Hero(
        tag: 'end',
        child: Scaffold(
            backgroundColor: Colors.white,
            // key: context.watch<AuthProvider>().scaffoldKey,
            body: Stack(
              children: [
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: SvgPicture.asset(
                    'assets/icons/ic_pattern.svg',
                    width: 150,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: 64,
                      ),
                      Center(
                          child: SvgPicture.asset(
                        "assets/logos/gdawel_icon.svg",
                        width: 64,
                      )),
                      const SizedBox(
                        height: 64,
                      ),
                      Center(
                        child: Text(
                          tr("login"),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                          tr("Welcome"),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.secondary_text_color),
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      _buildForm(),

                      const SizedBox(
                        height: 4,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Provider.of<AuthProvider>(context, listen: false).isLoading?SizedBox(width: 10.w,height: 100.h,
                          child:const AppLoader()): CustomButton(
                        title: tr("login"),
                        clickButton: () {
                          _onSubmit(context);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  _buildForm() {
    return Form(
        key: _formKey,
        child:Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: tr("email"),
                fillColor: Colors.white,
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(12.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                  BorderSide(color: AppColors.light_grey),
                  borderRadius:
                  BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller:_passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText:
              !context.read<AuthProvider>().passwordVisible,
              decoration: InputDecoration(
                labelText: tr("password"),
                fillColor: Colors.white,
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(12.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                  BorderSide(color: AppColors.light_grey),
                  borderRadius:
                  BorderRadius.all(Radius.circular(12.0)),
                ),
                // Here is key idea
                suffixIcon: IconButton(
                  icon: Icon(
                    context.watch<AuthProvider>().passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.colorPrimary,
                  ),
                  onPressed: () {
                    context
                        .read<AuthProvider>()
                        .passwordVisibility();
                  },
                ),
              ),
            ),
          ),
        ],),
    );}
}
