import 'dart:io';

Future<bool> hasInternetAccess() async {
  return isReachable('https://clients3.google.com/generate_204');
}

Future<bool> isReachable(String url) async {
  try {
    final response = await HttpClient().getUrl(Uri.parse(url));
    final result = await response.close();
    return result.statusCode >= 200;
  } catch (e) {
    return false;
  }
}

class NoInternetConnection implements Exception {
  const NoInternetConnection();
}

class ServerUnreachable implements Exception {
  const ServerUnreachable();
}
