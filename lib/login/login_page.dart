import 'package:flutter/material.dart';
import 'package:login_app/screens/home_screen.dart';


import 'theme_login.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();
  Color _color = Colors.white;

  bool _showForm = true; // menampilkan atau menyembunyikan form
  void _setColor(){
    setState(() {
      _color = _color == Colors.white ? Colors.amberAccent : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text ('Login Page'),
      //   centerTitle: true,
      // ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        
      child:AnimatedContainer(duration:   
        const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        color: _color,
        
        
            
           
          child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ]
              ),
              child: Image.asset( 'lib/assets/images/login2.jpg', height: 100, width: 100)
            ),
            SizedBox(height: 25.0),
            SafeArea(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: [
                    Text(
                      'Welcome', style: TextStyle(fontFamily: 'Domine', fontSize: 60, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade300),
                      ),
                    Text(
                      'Signin into your account', style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30.0),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            child: TextField(
                              decoration: ThemeLogin().TextInputDecoration('Username', 'Enter your username'),
                            ),
                            decoration: ThemeLogin().inputBoxDecorationShadow(),
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            child: TextField(
                              obscureText: true,
                              decoration: ThemeLogin().TextInputDecoration('Password', 'Enter your password'),
                            ),
                            decoration: ThemeLogin().inputBoxDecorationShadow(),
                          ),
                          SizedBox(height: 15.0),
                          Container(
                              margin: EdgeInsets.fromLTRB(10,0,10,20),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                 // Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                },
                                child: Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ),
                                ),
                              ),
                            ),
                          SizedBox(height: 15.0),
                          Container(
                            decoration: ThemeLogin().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text('Login'.toUpperCase(), style: TextStyle(fontFamily: 'Domine', fontSize: 20,fontWeight: FontWeight.bold, color: Colors.deepPurple.shade300)),
                                ),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),
                                  //Navigator.pop(context),
                                  );
                                },
                              ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.black26,
                                elevation: 5.0,
                                side: BorderSide(color: Colors.deepPurple.shade300, width: 2.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text('Animasi'.toUpperCase(), style: TextStyle(fontFamily: 'Domine', fontSize: 20,fontWeight: FontWeight.bold, color: Colors.deepPurple.shade300)),
                                ),
                                onPressed: (){
                                  _setColor();
                                },
                              ),
                          )
                        ],
                      ),
                    )

                  ],
                ),
            )
            )
          ],
        ),
      
        ),
        
      
      )
    );
  }
}

//grid view untuk menampilkan berita dan presensi
//
          // AnimatedContainer(duration: const Duration(milliseconds: 800),
          //   curve: Curves.easeInOut,
          //   color: _color,
          //   child: const Center(
          //     child:  Padding(padding: EdgeInsets.all(24.0), child: LoginPage(),),
          //   ),
          //   ),