import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vegetables/provider/action_provider.dart';
import 'package:vegetables/provider/auth_provider.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth-screen';
  AuthScreen({super.key});

  final AuthProvider apiProvider = AuthProvider();

  var userName;
  var mobileNumber;
  var email;
  var password;

  final formKey = GlobalKey<FormState>();

  void submit(BuildContext context) async {
    final action = Provider.of<ActionProvider>(context, listen: false);
    action.isAuthTrue();

    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    formKey.currentState!.save();
    action.isLogin
        ? await apiProvider.loginUser(email, password, context)
        : await apiProvider.registerUser(
            userName: userName,
            email: email,
            mobile: mobileNumber,
            password: password,
            context: context);
    action.isAuthFalse();
    print('out');
  }

  @override
  Widget build(BuildContext context) {
    final action = Provider.of<ActionProvider>(context);
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            Text(
              action.isLogin ? 'Login' : 'Register',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            if (!action.isLogin)
              TextFFeild(
                icon: CupertinoIcons.person,
                title: 'Username',
                validator: (v) {
                  if (v!.trim().isEmpty || v.trim().length < 4) {
                    return 'name must be at lease 4 characters';
                  }
                  return null;
                },
                onSaved: (v) {
                  userName = v;
                },
                keyboardType: TextInputType.name,
              ),
            if (!action.isLogin)
              TextFFeild(
                icon: CupertinoIcons.phone,
                title: 'Mobile Number',
                maxLength: true,
                validator: (v) {
                  if (v!.trim().isEmpty || v.trim().length < 10) {
                    return 'number must be at lease 10 characters';
                  }
                  return null;
                },
                onSaved: (v) {
                  mobileNumber = v;
                },
                keyboardType: TextInputType.number,
              ),
            TextFFeild(
              icon: CupertinoIcons.mail,
              title: 'Email Address',
              validator: (v) {
                if (v!.trim().isEmpty) {
                  return 'enter a valid mail address';
                }
                return null;
              },
              onSaved: (v) {
                email = v;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextFFeild(
              icon: CupertinoIcons.lock,
              title: 'Password',
              validator: (v) {
                if (v!.trim().isEmpty || v.trim().length < 6) {
                  return 'password must be at lease 6 characters';
                }
                return null;
              },
              onSaved: (v) {
                password = v;
              },
              keyboardType: TextInputType.visiblePassword,
              obscureText: action.isVisible,
              suffixIcon: IconButton(
                  onPressed: () {
                    action.toggleObscureStatus();
                  },
                  icon: Icon(action.isVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fixedSize: const Size(double.infinity, 60)),
                  onPressed: () {
                    submit(context);
                  },
                  child: action.isAuthLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          action.isLogin ? 'Login' : 'Register',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        )),
            ),
            Center(
              child: Text(
                action.isLogin
                    ? 'Don\'t you have an account?'
                    : 'Have you already registred?',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fixedSize: const Size(double.infinity, 60)),
                  onPressed: () {
                    action.toggleLoginStatus();
                  },
                  child: Text(
                    action.isLogin ? 'Register' : 'Login',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFFeild extends StatelessWidget {
  const TextFFeild({
    super.key,
    required this.icon,
    required this.title,
    required this.validator,
    this.onSaved,
    this.keyboardType,
    this.obscureText = false,
    this.maxLength = false,
    this.suffixIcon,
    this.initialValue,
  });

  final IconData icon;
  final String title;
  final String? Function(String?) validator;
  final void Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool maxLength;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        maxLength: maxLength ? 10 : null,
        obscureText: obscureText,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0)),
          prefixIcon: Icon(
            icon,
          ),
          suffixIcon: suffixIcon,
          hintText: title,
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
