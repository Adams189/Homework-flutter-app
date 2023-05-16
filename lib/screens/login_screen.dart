
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homework/screens/bottom_navigation_screens/home_screen.dart';
import 'package:homework/screens/homescreens/welcome_screen.dart';
import 'package:homework/screens/registration_screen.dart';
import '../components/roundedbutton.dart';
import '../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class LoginScreen extends StatefulWidget {
  static const String id =   'loginRoute';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>with SingleTickerProviderStateMixin {
  //For My Animation
  late AnimationController controller;
  late Animation animation;

 void getPref() async {
    SharedPreferences _preference = await SharedPreferences.getInstance();
    if(_preference.containsKey("user_id")) {
      Navigator.of(context).pushReplacementNamed(WelcomeScreen.id);
      return;
    }
  }

  @override
  void initState(){
  super.initState();
  getPref();
  controller = AnimationController(
    duration: Duration(seconds: 1),
    upperBound: 200,
    vsync: this,);
  controller.forward();
  controller.addListener(() {
    setState((){});
  });
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
//form key
  final _formKey = GlobalKey<FormState>();
//firebase
  final _auth = FirebaseAuth.instance;

  //Editing Controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showSpinner = false;
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
  //Email field

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if (value!.isEmpty){
          return ('Please Enter Your Email');
        }
        //reg expression for email validation
        if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value))
          {
            return('Please Enter a Valid Email');
          }
        return null;
      },
      onSaved: (value){
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: kEmailTextFeildDecoration,
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: _isObscure,
      controller: passwordController,
      validator: (value){
        RegExp regex = new RegExp(r'^.{6,}');
        if (value!.isEmpty){
          return ('Password is Required for Login');
        }
        if (!regex.hasMatch(value)){
          return ('Please Enter a Valid Password(Min.6 characters)');
        }
        return null;
      },
      onSaved: (value){
        passwordController.text = value!;
      },

      textInputAction: TextInputAction.done,
      decoration: kEmailTextFeildDecoration.copyWith(
        hintText: 'Password',
        prefixIcon: Icon(Icons.vpn_key),
          suffixIcon: IconButton(
              icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              })),
    );

    return Scaffold(
backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: controller.value,
                        child: Image.asset('images/adams.png', fit: BoxFit.contain,) ,

                      ),
                    ),
                    SizedBox(height: 45,),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: emailField,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: passwordField,
                    ),
                    SizedBox(height: 35,),
                      RoundedButton(title: 'Log In',onPressed:(){
                      signIn(emailController.text, passwordController.text);
                      } ,),
                    SizedBox(height: 45,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New to HomeWORK app?'),
                        GestureDetector(
                          onTap: (){
                           Navigator.pushNamed(context, RegistrationScreen.id);
                          },
                          child: Text(' SignUp', style: TextStyle(fontSize: 15,
                          fontWeight: FontWeight.w600, color: Colors.green),),
                        )
                      ],
                    )

                  ],
                ),
              ),
            ),),
        ),
      ),
    );
  }

  void addToPref(id) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("user_id", id);
  }


//login Function
  void signIn(String email, String password) async{

    if(_formKey.currentState!.validate()){
      setState((){showSpinner=true;});
      await _auth.signInWithEmailAndPassword(email: email, password: password )
          .then((uid) => {
        Fluttertoast.showToast(msg: 'Login Successful'),
        addToPref(uid.user!.uid),
        Navigator.of(context).pushReplacementNamed(WelcomeScreen.id),

      setState((){showSpinner=false;})
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
    setState((){showSpinner=false;});
  }

}
