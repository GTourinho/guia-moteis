import 'dart:convert';
import 'dart:io';

class MotelRepository {
  Future<Map<String, dynamic>> fetchMotels() async {
    final client = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    final request =
        await client.getUrl(Uri.parse('https://jsonkeeper.com/b/1IXK'));
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    if (response.statusCode == 200) {
      return json.decode(responseBody);
    } else {
      throw Exception('Failed to load motels');
    }
  }
}
