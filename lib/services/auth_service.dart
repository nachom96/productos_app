import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

  class AuthService extends ChangeNotifier{
    
    final String _baseUrl = 'identitytoolkit.googleapis.com';
    final String _firebaseToken = 'AIzaSyCj8UVdbx-xd173QPTBtiOw3HzGmz7uruI';

    // Si devuelve null significa que puede pasar a la siguiente pantalla
    Future<String?> createUser( String email, String password) async{
      
      final Map<String, dynamic> authData = {
        'email' : email,
        'password' : password
      };

      final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
        'key': _firebaseToken
      });

      final resp = await http.post(url, body: json.encode(authData));
      final Map<String, dynamic> decodedResp = json.decode(resp.body);

      if ( decodedResp.containsKey('idToken')){ 
        // Hay que guardar el Token en un lugar seguro
        // return decodedResp['idToken'];
        return null; 
      } else{
        return decodedResp['error']['message'];
      }

    }

        Future<String?> login( String email, String password) async{
      
      final Map<String, dynamic> authData = {
        'email' : email,
        'password' : password
      };

      final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
        'key': _firebaseToken
      });

      final resp = await http.post(url, body: json.encode(authData));
      final Map<String, dynamic> decodedResp = json.decode(resp.body);

      if ( decodedResp.containsKey('idToken')){ 
        // Hay que guardar el Token en un lugar seguro
        // return decodedResp['idToken'];
        return null; 
      } else{
        return decodedResp['error']['message'];
      }

    }




  }