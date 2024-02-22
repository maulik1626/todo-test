import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:services/api_services.dart';

void main() {
  group('APIServices', () {
    test('postMultiPart should return correct response for valid inputs', () async {
      const endPoint = 'https://example.com/upload';
      final body = {'key': 'value'};
      final file = File('path/to/file1');

      final response = await APIServices.postMultiPart(
        endPoint: endPoint,
        body: body,
        file: file,
      );

      // Check if the response contains the expected keys
      expect(response.containsKey('statusCode'), true);
      expect(response.containsKey('responseBody'), true);

      // You can add more specific expectations based on your API response structure
      // For example, you might check that the statusCode is 200 for a successful request

      // Also, check that the logs were printed correctly
      // You might want to capture logs using a testing library and assert on them
    });

    test('postEndPoint should return correct response for valid inputs', () async {
      const endPoint = 'https://example.com/api';
      final body = {'key': 'value'};

      final response = await APIServices.postEndPoint(
        endPoint: endPoint,
        body: body,
      );

      // Check if the response contains the expected keys
      expect(response.containsKey('statusCode'), true);
      expect(response.containsKey('responseBody'), true);

      // You can add more specific expectations based on your API response structure
      // For example, you might check that the statusCode is 200 for a successful request

      // Also, check that the logs were printed correctly
      // You might want to capture logs using a testing library and assert on them
    });
  });
}
