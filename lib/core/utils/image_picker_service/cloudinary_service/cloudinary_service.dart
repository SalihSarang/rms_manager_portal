import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

abstract class CloudinaryService {
  Future<String> uploadImage({
    required XFile file,
    required String folder,
    required String uploadPreset,
    Function(double progress)? onProgress,
  });
  Future<void> deleteImage(String publicId);

  static String? getPublicIdFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;
      final uploadIndex = pathSegments.indexOf('upload');
      if (uploadIndex == -1 || uploadIndex + 2 >= pathSegments.length) {
        return null;
      }
      List<String> publicIdSegments = pathSegments.sublist(uploadIndex + 2);
      String publicIdWithExtension = publicIdSegments.join('/');
      final lastDotIndex = publicIdWithExtension.lastIndexOf('.');
      if (lastDotIndex != -1) {
        return publicIdWithExtension.substring(0, lastDotIndex);
      }
      return publicIdWithExtension;
    } catch (e) {
      return null;
    }
  }
}

class CloudinaryServiceImpl implements CloudinaryService {
  final Dio _dio = Dio();

  static const _cloudName = 'defjrqf4i';

  @override
  Future<String> uploadImage({
    required XFile file,
    required String folder,
    required String uploadPreset,
    Function(double progress)? onProgress,
  }) async {
    log(
      '[CloudinaryService] uploadImage -> file: ${file.name}, folder: $folder, preset: $uploadPreset',
      name: 'CloudinaryService',
    );

    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        await file.readAsBytes(),
        filename: file.name,
      ),
      'upload_preset': uploadPreset,
      'folder': folder,
    });

    final response = await _dio.post(
      'https://api.cloudinary.com/v1_1/$_cloudName/image/upload',
      data: formData,
      onSendProgress: (sent, total) {
        if (onProgress != null && total > 0) {
          final progress = sent / total;
          onProgress(progress);
        }
      },
    );

    log(
      '[CloudinaryService] uploadImage <- status: ${response.statusCode}, data: ${response.data}',
      name: 'CloudinaryService',
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Cloudinary upload failed: ${response.data}");
    }

    final secureUrl = response.data['secure_url'] as String;
    log(
      '[CloudinaryService] uploadImage <- secure_url: $secureUrl',
      name: 'CloudinaryService',
    );
    return secureUrl;
  }

  @override
  Future<void> deleteImage(String publicId) async {
    log(
      '[CloudinaryService] deleteImage -> publicId: $publicId',
      name: 'CloudinaryService',
    );
    // TODO: implement delete via Cloudinary Admin API
  }
}
