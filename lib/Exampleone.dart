import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Exampleone extends StatefulWidget {
  const Exampleone({Key? key}) : super(key: key);

  @override
  State<Exampleone> createState() => _ExampleoneState();
}

class _ExampleoneState extends State<Exampleone> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
void signup (String email,password) async {
  try{
    Response response =await post(
      Uri.parse('https://reqres.in/api/register'),
      body: {
        'email':email,
    'password':password
    }
     
    );
    if (response.statusCode == 200){
      var data =jsonDecode(response.body.toString());
      print(data['tokn']);
      print(data['id']);
print("account created");
    }else{
print('Filled');
    }
  }catch(e){
    print(e.toString());

  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup api"),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: "Password"),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: (){
                signup(emailController.text.toString(),passwordController.text.toString());
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                child: const Center(
                  child: const Text('signup now'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontoller = TextEditingController();
  void login (String email,password)async{
    try{
      Response response= await  post(
          Uri.parse('https://reqres.in/api/login'),
          body : {
            'email':email,
            'password':password
          }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print('Login you account ');
      }
      else{
        print("filled");
      }
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(   appBar: AppBar(
      title:Text("Login Now"),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(controller: emailcontroller,
            decoration: InputDecoration(hintText: 'Email'),
          ),SizedBox(height: 20,),
          TextFormField(controller: passwordcontoller,
            decoration: InputDecoration(hintText: 'Password'),
          ),SizedBox(height: 40,),
          GestureDetector(

            onTap: (){login(emailcontroller.text.toString(),passwordcontoller.text.toString());},
            child: Container(
              height: 50,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green,
            ),
            child: Center(child: Text('Login Now'),),),
          ),
          SizedBox(height: 40,),
          Row(
            children: [Expanded(child: Container()),
            Text("Not register?"),
SizedBox(width: 5,),
           TextButton(onPressed: (){Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => const Exampleone()),
           );}, child:Text('Create account') ),
              Expanded(child: Container()),
          ],)
      ],),
    ),
    );
  }
}
