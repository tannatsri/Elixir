
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Init {
  static dynamic events, resources, teams, clubs;
  static Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
      url: 'https://iwzkglzldgxwucbjsipf.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzNDE0MjEzMywiZXhwIjoxOTQ5NzE4MTMzfQ.hjuVuWTw5v4emv8mLjk5wdsf_Z8bY_xwykUqgMu0uEs',
    );
    final client = SupabaseClient('https://iwzkglzldgxwucbjsipf.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzNDE0MjEzMywiZXhwIjoxOTQ5NzE4MTMzfQ.hjuVuWTw5v4emv8mLjk5wdsf_Z8bY_xwykUqgMu0uEs');

    Init.events = await client.from('Events').select('*').execute();
    Init.resources = await client.from('Resources').select('*').execute();
    Init.teams = await client.from('Team').select('*').execute();
    Init.clubs = await client.from('Clubs').select('*').execute();

  }
}
