import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class AuthService {
  final SupabaseClient _supabase;

  /*final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );*/

  AuthService(this._supabase);

  Future<void> signUp(String email, String password, Map<String, dynamic> userData) async {
    AuthResponse authResponse;
    try {
      authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        throw Exception('User signup failed: No user returned (e.g., email confirmation needed).');
      }
    } on AuthException catch (e) {
      throw Exception('Signup failed: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred during signup: $e');
    }

    final String? userId = authResponse.user?.id;
    if (userId == null) {
      throw Exception('User ID not available after successful authentication but no user object.');
    }

    try {
      await _supabase.from('profiles').insert({
        'id': userId,
        'full_name': userData['fullName'],
        'phone_number': userData['phoneNumber'],
        'profile_image_url': userData['profileImageUrl'],
        'account_type': userData['accountType'],
        'member_since': userData['memberSince'],
        'location': userData['location'],
        'bio': userData['bio'],
        'total_trips_completed': userData['totalTripsCompleted'],
        'dob': userData['dob'],
        'gender': userData['gender'],
        'mpesa_number': userData['mpesaNumber'],
      });
      debugPrint('User signed up and profile created successfully for $email');
    } on PostgrestException catch (e) {
      await _supabase.auth.signOut();
      throw Exception('Failed to create user profile: ${e.message}');
    } catch (e) {
      await _supabase.auth.signOut();
      throw Exception('An unexpected error occurred during profile creation: $e');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final AuthResponse response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      debugPrint('User signed in: ${response.user?.email}');
    } on AuthException catch (e) {
      throw Exception('Sign in failed: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred during sign in: $e');
    }
  }

  /*Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google Sign-In cancelled by user.');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('No Google ID Token found.');
      }

      final AuthResponse response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user != null) {
        debugPrint('Signed in with Google: ${response.user!.email}');
      } else {
        throw Exception('Supabase Google sign-in failed: No user returned.');
      }
    } on AuthException catch (e) {
      debugPrint('Supabase Google Sign-In Error: ${e.message}');
      throw Exception('Supabase Google Sign-In Failed: ${e.message}');
    } on Exception catch (e) {
      debugPrint('Google Sign-In Error: $e');
      throw Exception('Google Sign-In Failed: $e');
    }
  }*/

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      //await _googleSignIn.signOut();
      debugPrint('User signed out.');
    } on AuthException catch (e) {
      throw Exception('Sign out failed: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred during sign out: $e');
    }
  }

  User? get currentUser => _supabase.auth.currentUser;
}