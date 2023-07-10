import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/splashScreen/splash_screen.dart';
import 'package:users_app/widgets/progress_dialog.dart';

class SignUpScreen extends StatefulWidget
{
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}




class _SignUpScreenState extends State<SignUpScreen>
{
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  validateForm()
  {
    if (nameTextEditingController.text.length < 3)
      {
        Fluttertoast.showToast(msg: "Nombre debe tener al menos 3 caracteres.");
      }
    else if(!emailTextEditingController.text.contains("@"))
      {
        Fluttertoast.showToast(msg: "Proporcione un email correcto.");
      }
    else if(phoneTextEditingController.text.isEmpty)
      {
        Fluttertoast.showToast(msg: "Numero de telefono es obligatorio");
      }
    else if(passwordTextEditingController.text.length < 6)
    {
      Fluttertoast.showToast(msg: "La contraseña debe tener al menos 6 caracteres");
    }
    else
    {
      saveUserInfoNow();
    }
  }

  saveUserInfoNow() async
  {
    showDialog        (
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Procesando por favor espere...",);
        }
    );

    final User? firebaseUser = (
        await  fAuth.createUserWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error " + msg.TroString());
        })
    ).user;

    if(firebaseUser != null)
      {
        Map userMap =
            {
              "id": firebaseUser.uid,
              "name": nameTextEditingController.text.trim(),
              "email": emailTextEditingController.text.trim(),
              "phone": phoneTextEditingController.text.trim(),
            };

        DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
        usersRef.child(firebaseUser.uid).set(userMap);

        currentFirebaseUser = firebaseUser;
        Fluttertoast.showToast(msg: "Cuenta fue creada");
        Navigator.push(context, MaterialPageRoute(builder: (c) => MySplashScreen()));
      }
    else
      {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Cuenta no fue creada");
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image.asset("images/logo.png"),
              ),

              const SizedBox(height: 30,),

              const Text(
                "Registrate como usuario",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold ,
                ),
              ),

              TextField(
                controller: nameTextEditingController,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  hintText: "Nombre",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              TextField(
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Telefono",
                  hintText: "Telefono",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Contraseña",
                  hintText: "Contraseña",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                onPressed: ()
                {
                  validateForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreenAccent
                ),
                child: const Text(
                  "Crear Cuenta",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              TextButton(
                child: const Text(
                  "Ya tienes una cuenta? Click aqui",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}

