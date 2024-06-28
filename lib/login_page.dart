import 'package:flutter/material.dart';
import 'package:uas_project/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    
    print('Login with: ${_usernameController.text}, ${_passwordController.text}');
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        backgroundColor: Colors.indigo, // Set the background color to a light indigo
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Image.asset(
                'assets/LOGO_SURAT.png', // Ensure the logo.png file exists in the assets folder and is listed in pubspec.yaml
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20),
              const Text(
                'Generate Letter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: "roboto"
                ),
              ),
              SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white)
                  ),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none, // Adjusted to use the container's border
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white)
                  ),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none, // Adjusted to use the container's border
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20), // Padding of the button
                  onPrimary: Colors.indigo,
                  primary: Colors.white, // Background color of the button
                  shape: RoundedRectangleBorder( // Adding border to the button
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.white), // Border color
                  ),
                ),
                child: Container(
                  width: 100, // Make the button width match the TextField
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    
                  ),
                  child: Center(
                    child: Text(
                  "Login",
                  style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
