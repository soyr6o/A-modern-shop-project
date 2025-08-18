import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSupabase{
    final SupabaseClient _supabase = Supabase.instance.client;
  Future<AuthResponse?> signUp(String email,String password) async{
    final response = await _supabase.auth.signInWithPassword(
        email: email, password: password);
  }


  Future<AuthResponse> signin(String email, String password) async{
    return await _supabase.auth.signInWithPassword(email: email,password: password);
  }

  Future<void> signOut() async {
    return await _supabase.auth.signOut();
  }
}