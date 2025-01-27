import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:get/get.dart';

class CloudinaryService {
  static const String _cloudName = 'dvgapjlqg';
  static const String _apiKey = '673926594311159';
  static const String _apiSecret = 'VpM6DtEz8H8Hzxxo2v0AYtUxJ7U';
  static const String _uploadPreset = 'ml_default'; // Replace with your upload preset
  static const String _uploadUrl = 'https://api.cloudinary.com/v1_1/$_cloudName/image/upload';

  static String _generateSignature(Map<String, String> params) {
    // Sort parameters alphabetically
    var sortedParams = Map.fromEntries(params.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
    
    // Create string to sign
    var stringToSign = sortedParams.entries.map((e) => '${e.key}=${e.value}').join('&');
    
    // Generate signature
    var bytes = utf8.encode(stringToSign + _apiSecret);
    var signature = sha1.convert(bytes);
    
    return signature.toString();
  }

  static Future<String?> uploadImage(File imageFile) async {
    try {
      // Get the MIME type of the image
      final mimeType =  'image/jpeg';
      final mimeData = mimeType.split('/');

      if (mimeData.length != 2) {
        throw 'Invalid mime type';
      }

      // Generate timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      // Parameters for signing
      final params = {
        'timestamp': timestamp.toString(),
        'api_key': _apiKey,
      };

      // Generate signature
      final signature = _generateSignature(params);

      // Create the multipart request
      final request = http.MultipartRequest('POST', Uri.parse(_uploadUrl))
        ..fields.addAll({
          'timestamp': timestamp.toString(),
          'api_key': _apiKey,
          'signature': signature,
          'upload_preset': _uploadPreset,
        })
        ..files.add(
          await http.MultipartFile.fromPath(
            'file',
            imageFile.path,
            contentType: MediaType(mimeData[0], mimeData[1]),
          ),
        );

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final imageUrl = responseData['secure_url'];
        return imageUrl;
      } else {
        final error = jsonDecode(response.body);
        throw 'Failed to upload image: ${error['error']['message'] ?? 'Unknown error'}';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to upload image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFF3B3B),
        colorText: const Color(0xFFFFFFFF),
        duration: const Duration(seconds: 3),
      );
      return null;
    }
  }
}