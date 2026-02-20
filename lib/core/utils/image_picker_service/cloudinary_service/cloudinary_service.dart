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
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Cloudinary upload failed: ${response.data}");
    }

    return response.data['secure_url'] as String;
  }

  @override
  Future<void> deleteImage(String publicId) async {
    // Note: Deleting images requires a signature generated with the API Secret.
    // This implementation is a placeholder until the crypto package and logic are added.
    // For now, we will just log that deletion is requested.
    print('Deleting image with publicId: $publicId (Simulated)');

    // valid implementation would look like:
    // 1. timestamp = DateTime.now().millisecondsSinceEpoch / 1000
    // 2. params = 'public_id=$publicId&timestamp=$timestamp$_apiSecret'
    // 3. signature = sha1(params)
    // 4. post to destroy endpoint
  }
}
