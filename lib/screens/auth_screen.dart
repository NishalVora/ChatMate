import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var isLoading = false;
  void _submitAuth(String email, String password, String username, File image,
      bool isLogin, BuildContext ctx) async {
    AuthResult _authResult;
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(_authResult.user.uid + '.jpg');
        await ref.putFile(image).onComplete;
        final imageUrl = await ref.getDownloadURL();
        await Firestore.instance.collection('users').document().setData(
          //  {'Username': username, 'Email Id': email},
          {'Username': username, 'Email Id': email, 'imageUrl': imageUrl},
        );
      }
    } on PlatformException catch (error) {
      var message = "An error occured,please check the credentials.";
      if (error.message != null) {
        message = error.message;
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print(error);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: AuthForm(_submitAuth, isLoading),
    );
  }
}
