import 'package:alandalos/core/app_loader.dart';
import 'package:alandalos/core/extensions/num_extensions.dart';
import 'package:alandalos/screens/auth/login/auth_provider.dart';
import 'package:alandalos/screens/componets/my_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import '../../../../../injection.dart';
import '../../../core/utils/showToast.dart';
import '../../../custom_widgets/custom_buttom.dart';
import '../../../custom_widgets/new/customTextFormField.dart';
import '../../../data/model/body/updateProfileBody.dart';
import '../../../data/repository/SaveUserData.dart';

SaveUserData iiii=getIt();
class UpdateProfile extends StatefulWidget {
  UpdateProfile({Key? key, required this.parentId}) : super(key: key);
final String parentId;
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  SaveUserData provider=getIt();

  setData(){
    print('wsdfghjkl;${_emailController.text}');
    _emailController.text=provider.getUserData()?.data?.email??'';
    _fullNameController.text=provider.getUserData()?.data?.name??'';
  }

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  void _onSubmit(context) async {
    UpdateProfileBody updateProfileBody = UpdateProfileBody();
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        String password = _confirmPasswordController.text;
        if (password!=_passwordController.text) {
          ToastUtils.showToast('password does not match'.tr());
          return;
        }
          updateProfileBody.name = _fullNameController.text;
          updateProfileBody.email = _emailController.text;
          updateProfileBody.password = _passwordController.text;
          updateProfileBody.parentId = widget.parentId;
          Provider.of<AuthProvider>(context, listen: false).updateProfileApi(context,updateProfileBody);}
      }
  }
  void initState() {
    super.initState();
    setData();}

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<AuthProvider>().isLoading;
    return Consumer<AuthProvider>(builder: (context, data, child) {
      return  Scaffold(
          appBar: MyAppBar(
            haveLeading: true,
            title: 'Edit account'.tr(),
            // backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding:
            EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 33.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h,),
                  Center(
                    child: Container(height: 140.h,decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r),), child:
                    Image.asset('assets/images/review.png')
                    ) ),
                  SizedBox(height: 20.h,),
                  _buildForm(context),
                  SizedBox(height: 50.h,),
                  isLoading? AppLoader():CustomButton(
                    title: LocaleKeys.confirm.tr(),
                    clickButton: (){
                      _onSubmit(context);
                    },
                  )
                ],
              ),
            ),
          ));
    });
  }

  _buildForm(BuildContext context) {
    // final provider = Provider.of<EditProfileViewModel>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormFiled(height: 70.h,
            controller: _fullNameController,
            textInputType: TextInputType.name,
            hintText: LocaleKeys.reviews.tr(),
            backGroundColor: AppColors.light_grey,),
          const SizedBox(height: 20,),
          CustomTextFormFiled(height: 70.h,
            controller: _emailController,
            textInputType: TextInputType.emailAddress,
            hintText: LocaleKeys.reviews.tr(),
            backGroundColor: AppColors.light_grey,),
          const SizedBox(height: 20,),
          CustomTextFormFiled(height: 70.h,
            controller: _passwordController,
            textInputType: TextInputType.text,
            hintText: 'new_password'.tr(),
            backGroundColor: AppColors.light_grey,),
          const SizedBox(height: 20,),
          CustomTextFormFiled(height: 70.h,
            controller: _confirmPasswordController,
            textInputType: TextInputType.text,
            hintText: 'Re_type_new_password'.tr(),
            backGroundColor: AppColors.light_grey,),
        ],
      ),
    );
  }
}
