import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class FileStorageService {
  static const String _baseFolder = 'bkuk_tv_storage';

  /// Fayl saqlash
  Future<String?> saveFile({required File file, required String folderName, String? customFileName}) async {
    try {
      final targetDir = await _getDirectory(folderName);

      final extension = p.extension(file.path);
      final baseName = customFileName ?? p.basenameWithoutExtension(file.path);
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final fileName = '${baseName}_$timestamp$extension';
      final savePath = p.join(targetDir.path, fileName);

      final savedFile = await file.copy(savePath);

      return savedFile.path;
    } catch (e) {
      return null;
    }
  }

  /// Folder ichidagi barcha fayllar
  Future<List<File>> getFiles({required String folderName, List<String>? allowedExtensions}) async {
    try {
      final targetDir = await _getDirectory(folderName);

      if (!await targetDir.exists()) {
        return [];
      }

      final files = targetDir.listSync().whereType<File>().where((file) {
        if (allowedExtensions == null || allowedExtensions.isEmpty) {
          return true;
        }

        final ext = p.extension(file.path).toLowerCase();

        return allowedExtensions.contains(ext);
      }).toList();

      files.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

      return files;
    } catch (e) {
      return [];
    }
  }

  /// Bitta fayl olish
  Future<File?> getFile({required String filePath}) async {
    try {
      final file = File(filePath);

      if (await file.exists()) {
        return file;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Fayl mavjudligini tekshirish
  Future<bool> fileExists({required String filePath}) async {
    try {
      return await File(filePath).exists();
    } catch (e) {
      return false;
    }
  }

  /// Faylni o‘chirish
  Future<bool> deleteFile({required String filePath}) async {
    try {
      final file = File(filePath);

      if (await file.exists()) {
        await file.delete();
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Folder ichidagi barcha fayllarni o‘chirish
  Future<bool> clearFolder({required String folderName}) async {
    try {
      final targetDir = await _getDirectory(folderName);

      if (await targetDir.exists()) {
        await targetDir.delete(recursive: true);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Folder size
  Future<int> getFolderSize({required String folderName}) async {
    try {
      final targetDir = await _getDirectory(folderName);

      if (!await targetDir.exists()) {
        return 0;
      }

      int totalSize = 0;

      final files = targetDir.listSync(recursive: true);

      for (final entity in files) {
        if (entity is File) {
          totalSize += await entity.length();
        }
      }

      return totalSize;
    } catch (e) {
      return 0;
    }
  }

  /// Internal helper
  Future<Directory> _getDirectory(String folderName) async {
    final appDir = await getApplicationDocumentsDirectory();

    final targetDir = Directory(p.join(appDir.path, _baseFolder, folderName));

    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }

    return targetDir;
  }
}
