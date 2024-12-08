import 'package:flipr_assignment/screens/home_screen.dart';
import 'package:flipr_assignment/screens/log_in_screen.dart';
import 'package:flipr_assignment/services/auth_service.dart';
import 'package:flipr_assignment/widgets/custom_button.dart';
import 'package:flipr_assignment/widgets/custom_input_field.dart';
import 'package:flipr_assignment/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignUpScreen({super.key});

  void _signUp(BuildContext context) async{
    final email = _emailController.text.trim();
    final pass = _passwordController.text;

    print("Email Entered: $email");
    print("Regex Match: ${RegExp(r'^[a-zA-Z0-9._%+-]+@flipr\.ai$').hasMatch(email)}");
    //Email verification
    if(!RegExp(r'^[a-zA-Z0-9._%+-]+@flipr\.ai$').hasMatch(email)){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email must end with @flipr.ai')));
      return;
    }

    //Password validation
    if(pass.length < 8){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password must be at least 8 characters long.')));
      return;
    }

    try{
      final user = await AuthService().signupWithEmailPass(email, pass);
      if (user != null){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
      }
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 100.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextWidget(text: "Sign Up", fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),

              const Text("Name", style: TextStyle(fontSize: 18),),
              const CustomInputField(type: TextInputType.text),

              // email field
              const Text("Email", style: TextStyle(fontSize: 18)),
              CustomInputField(type: TextInputType.emailAddress, controller: _emailController),

              // password field
              const Text("Password", style: TextStyle(fontSize: 18),),
              CustomInputField(type: TextInputType.text, visibility: true, controller: _passwordController),

              const Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text("Forgot Password?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.deepOrangeAccent,
                    decorationThickness: 2,
                    color: Colors.deepOrangeAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),)
              ],),
              const SizedBox(height: 20),

              // Register Button
              CustomButtonWidget(text: "Sign Up", color: Colors.deepOrange, textColor: Colors.white,
                  onPressed: () => _signUp(context)
              ),

              const SizedBox(height: 15),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Already have an account? ", style: TextStyle(fontSize: 16,)),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LogInScreen()));
                  },
                  child: const Text("Login", style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.deepOrangeAccent,
                    decorationThickness: 2,
                    color: Colors.deepOrangeAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
                ),
              ],),
              const SizedBox(height: 15),
              const Row(
                children: <Widget>[
                  Expanded(child: Divider(color: Colors.black)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("Sign in with", style: TextStyle(fontSize: 16),),
                  ),
                  Expanded(child: Divider(color: Colors.black)),
                ],
              ),
              const SizedBox(height: 15),
              CustomButtonWidget(text: "Continue with Facebook", color: Colors.black12, textColor: Colors.black, icon: const Icon(Bootstrap.facebook, color: Colors.blueAccent,),
                  onPressed: (){
                    try{
                      AuthService().signinWithGoogle();
                    }
                    catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
              ),
              const SizedBox(height: 15),
              CustomButtonWidget(text: "Continue with Google", color: Colors.black12, textColor: Colors.black, icon: const Icon(Bootstrap.google, color: Colors.red,),onPressed: (){}),
            ],),
        ),
      ),
    );
  }
}
