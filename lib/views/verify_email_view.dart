
import 'package:flutter/material.dart';
import 'package:freecodecamp/constants/route.dart';
import 'package:freecodecamp/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: Column(
        children: [
          const Text("We've sent your email verification.Please open it to verify your account"),
          const Text("If you haven't received a verification email yet, press the button below ", ),
          TextButton(
            onPressed: () async {
              final user = AuthService.firebase().currentUser;
              AuthService.firebase().sendEmailVerification();
            },
            child: const Text('Send email verification'),
          ),
          TextButton(
            onPressed: ()async{
              await AuthService.firebase().LogOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                 (route) => false,
                 );
            },
            child: const Text('Restart'))        ],
      ),
    );
  }
}