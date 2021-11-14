import 'package:elixir/common/internet_checker.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class Init {
  static dynamic events, resources, teams, clubs;
  static Future<void> main(context) async {
    WidgetsFlutterBinding.ensureInitialized();

    final client = SupabaseClient('https://iwzkglzldgxwucbjsipf.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzNDE0MjEzMywiZXhwIjoxOTQ5NzE4MTMzfQ.hjuVuWTw5v4emv8mLjk5wdsf_Z8bY_xwykUqgMu0uEs');

    while (!await isThereInternetConnection()) {
      continue;
    }
    Init.events = await client.from('Events').select('*').execute();
    // if (Init.events.data == null) {
    //   while (Init.events.data == null) {
    //     Init.events = await client.from('Events').select('*').execute();
    //   }
    // }

    while (!await isThereInternetConnection()) {
      continue;
    }
    Init.resources = await client.from('Resources').select('*').execute();
    // if (Init.resources.data == null) {
    //   while (Init.resources.data == null) {
    //     Init.resources = await client.from('Resources').select('*').execute();
    //   }
    // }

    while (!await isThereInternetConnection()) {
      continue;
    }
    Init.teams = await client.from('Teams').select('*').execute();
    // if (Init.teams.data == null) {
    //   while (Init.teams.data == null) {
    //     Init.teams = await client.from('Teams').select('*').execute();
    //   }
    // }

    while (!await isThereInternetConnection()) {
      continue;
    }
    Init.clubs = await client.from('Clubs').select('*').execute();
    // if (Init.clubs.data == null) {
    //   while (Init.clubs.data == null) {
    //     Init.clubs = await client.from('Clubs').select('*').execute();
    //   }
    // }
  }
}
