import 'package:elixir/common/internet_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';

class Init {
  static dynamic events, resources, teams, clubs;
  static bool userStatus = false;
  static Future<void> main(context) async {
    WidgetsFlutterBinding.ensureInitialized();

    final client = SupabaseClient('supabase id',
        'supabase api key');

    while (!await isThereInternetConnection()) {
      continue;
    }
    Init.events = await client.from('Events').select('*').execute();


    while (!await isThereInternetConnection()) {
      continue;
    }
    Init.resources = await client.from('Resources').select('*').execute();


    while (!await isThereInternetConnection()) {
      continue;
    }


    while (!await isThereInternetConnection()) {
      continue;
    }
    Init.clubs = await client.from('Clubs').select('*').execute();


    SharedPreferences prefs = await SharedPreferences.getInstance();
    Init.userStatus = prefs.containsKey('uid');
  }
}
