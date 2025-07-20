import 'package:flutter/material.dart';
import '../utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _username, _password, _firstName, _lastName, _phone;
  bool _isLoading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _isLoading = true);
    // Simulate registration logic
    await Future.delayed(Duration(seconds: 2));
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registration successful!')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                validator: Validators.validateName,
                onSaved: (v) => _firstName = v,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: Validators.validateName,
                onSaved: (v) => _lastName = v,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: Validators.validateEmail,
                onSaved: (v) => _email = v,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: Validators.validateName,
                onSaved: (v) => _username = v,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                onSaved: (v) => _phone = v,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: Validators.validatePassword,
                onSaved: (v) => _password = v,
              ),
              SizedBox(height: 24),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submit,
                      child: Text('Register'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
