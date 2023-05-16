import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homework/components/user_model.dart';
import '../constants.dart';
import 'login_screen.dart';
import '../components/roundedbutton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class RegistrationScreen extends StatefulWidget {
static const String id = 'registrationRoute';



  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();

}

//form key
final _formKey = GlobalKey<FormState>();
//firebase
final _auth = FirebaseAuth.instance;
//Editing Controller
final firstNameController = TextEditingController();
final  lastNameController = TextEditingController();
final  emailController = TextEditingController();
final  passwordController = TextEditingController();
final  confirmPasswordController = TextEditingController();

class _RegistrationScreenState extends State<RegistrationScreen> {
bool showSpinner = false;
  final firstNameField = TextFormField(
    autofocus: false,
    controller: firstNameController,
    keyboardType: TextInputType.name,
    validator: (value){
      RegExp regex = new RegExp(r'^.{3,}');
      if (value!.isEmpty){
        return ('First Name Cannot be Empty');
      }
      if (!regex.hasMatch(value)){
        return ('Please Enter a Valid Name(Min.3 characters)');
      }
      return null;
    },
    onSaved: (value){
      firstNameController.text = value!;
    },
    textInputAction: TextInputAction.next,
    decoration: kEmailTextFeildDecoration.copyWith(
        hintText: 'First Name',
        prefixIcon: Icon(Icons.account_circle)
    ),

  );
  final lastNameField = TextFormField(
    autofocus: false,
    controller: lastNameController,
    keyboardType: TextInputType.name,
      validator: (value){

        if (value!.isEmpty){
          return ('Last Name Cannot be Empty');
        }
        return null;
      },
    onSaved: (value){
      lastNameController.text = value!;
    },
    textInputAction: TextInputAction.next,
    decoration:  kEmailTextFeildDecoration.copyWith(
        hintText: 'Last Name',
        prefixIcon: Icon(Icons.account_circle))
  );
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
    decoration: kEmailTextFeildDecoration
  );
  final passwordField = TextFormField(
    autofocus: false,
    obscureText: true,
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
    textInputAction: TextInputAction.next,
    decoration: kEmailTextFeildDecoration.copyWith(
        hintText: 'Password',
        prefixIcon: Icon(Icons.vpn_key)
    ),
  );
  final confirmPasswordField = TextFormField(
    autofocus: false,
    obscureText: true,
    controller: confirmPasswordController,
    validator: (value){
      if(confirmPasswordController.text != passwordController.text){
        return 'Password Do not Match';
      }
      return null;
    },
    onSaved: (value){
      confirmPasswordController.text = value!;
    },
    textInputAction: TextInputAction.done,
    decoration: kEmailTextFeildDecoration.copyWith(
        hintText: 'Confirm Password',
        prefixIcon: Icon(Icons.vpn_key)
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
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
                        height: 200,
                        child: Image.asset('images/adams.png', fit: BoxFit.contain,) ,

                      ),
                    ),
                    SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: firstNameField,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: lastNameField,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: emailField,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: passwordField,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: confirmPasswordField,
                    ),
                    SizedBox(height: 30,),
                    RoundedButton(title: 'Sign Up',onPressed:(){
                      signUp(emailController.text, passwordController.text);

                    } ,),
                    SizedBox(height: 45,),


                  ],
                ),
              ),
            ),),
        ),
      ),
    );
  }

  postDetailsToFirestore() async {
    //calling our firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    //calling our user model
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameController.text;
    userModel.lastName = lastNameController.text;
    
    //sending these values
    await firebaseFirestore
      .collection('users')
      .doc(user.uid)
      .set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Account Created Successfully:)');
    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
  }


  void signUp(String email, String password) async {
    setState((){showSpinner=true;});
    if(_formKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
        postDetailsToFirestore(),
      setState((){showSpinner=false;})

          }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }

    setState((){showSpinner=false;});

  }
}
