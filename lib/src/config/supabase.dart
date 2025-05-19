import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<void> initSupabase() async {
  var url = dotenv.get('SUPABASE_URL', fallback: '');
  var anonKey = dotenv.get('SUPABASE_ANON_KEY', fallback: '');
  if (url.isEmpty || anonKey.isEmpty) {
    throw Exception('Supabase URL and Anonimous Key must be provided');
  }

  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
    authOptions: FlutterAuthClientOptions(
      authFlowType: AuthFlowType.implicit,
      autoRefreshToken: true,
      localStorage: SharedPreferencesLocalStorage(
        persistSessionKey: 'refresh_token', // TODO: Use flutter_secure_storage
      ),
    ),
  );
}
