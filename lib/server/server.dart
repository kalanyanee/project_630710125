import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  final server = await HttpServer.bind(
    'localhost',
    3354,
  );
  print('Server is running on http://${server.address.host}:${server.port}');

  await for (HttpRequest request in server) {
    switch (request.method) {
      case 'GET':
        handleGetRequest(request);
        break;
      case 'POST':
        await handlePostRequest(request);
        break;
      default:
        request.response
          ..statusCode = HttpStatus.methodNotAllowed
          ..write('Unsupported request method')
          ..close();
    }
  }
}

void addCorsHeaders(HttpResponse response) {
  response.headers.add('Access-Control-Allow-Origin', '*');
  response.headers.add('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
  response.headers.add('Access-Control-Allow-Headers', 'Content-Type');
}

void handleGetRequest(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.ok
    ..write('GET request received!')
    ..close();
}

Future<void> handlePostRequest(HttpRequest request) async {
  try {
    final body = await utf8.decoder.bind(request).join();
    final data = jsonDecode(body);

    print('Received POST data: $data');

    // Perform additional logic or send data to external API
    await handlePostLogic(data);

    request.response
      ..statusCode = HttpStatus.ok
      ..write('POST request received! Data: $data')
      ..close();
  } catch (e) {
    request.response
      ..statusCode = HttpStatus.badRequest
      ..write('Invalid JSON format or other error')
      ..close();
  }
}

Future<void> handlePostLogic(Map<String, dynamic> data) async {
  try {
    final apiUrl = 'http://192.168.141.192/addresses'; // Replace with your external API URL

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Data sent to external API successfully');
    } else {
      print('Failed to send data to external API. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error sending data to external API: $error');
  }
}
