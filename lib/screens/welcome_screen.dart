import 'package:flipr_assignment/screens/log_in_screen.dart';
import 'package:flipr_assignment/screens/sign_up_screen.dart';
import 'package:flipr_assignment/services/auth_service.dart';
import 'package:flipr_assignment/widgets/custom_button.dart';
import 'package:flipr_assignment/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.white, Colors.orangeAccent, Colors.deepOrange],
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            )),
        ),

        Padding(padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              const CustomTextWidget(text: "Welcome to", fontSize: 40, fontWeight: FontWeight.w600, color: Colors.black),
              const CustomTextWidget(text: "Fast Food", fontSize: 40, fontWeight: FontWeight.w600, color: Colors.deepOrangeAccent),
              const CustomTextWidget(text: "Get your favouite meals delivered \nquickly right to your doorstep", fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
              const SizedBox(height: 30),
              CustomButtonWidget(text: "Start with Email", textColor: Colors.white, color: Colors.black, 
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));}
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 30),
              CustomButtonWidget(text: "Continue with Facebook", textColor: Colors.black, color: Colors.white, icon: const Icon(Bootstrap.facebook, color: Colors.blueAccent), onPressed: (){}),
              const SizedBox(height: 15),
              CustomButtonWidget(text: "Continue with Google", color: Colors.white, textColor: Colors.black, icon: const Icon(Bootstrap.google, color: Colors.red),
                  onPressed: (){
                    try{
                      AuthService().signinWithGoogle();
                    }
                    catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                  const Text("Already have an account? ", style: TextStyle(fontSize: 16),),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> LogInScreen()));
                    },
                    child: const Text("Sign in", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),)),
                ],),
              ),
              const SizedBox(height: 30,)
            ],
          ),
        ),
      ),
      ],),
    );
  }
}