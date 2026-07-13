import 'dart:io';

import 'package:bkuk_tv_app/src/core/constants/menus.dart';
import 'package:bkuk_tv_app/src/core/services/file_storage_service.dart';
import 'package:bkuk_tv_app/src/feature/admin/data/admin_repository_impl.dart';
import 'package:bkuk_tv_app/src/feature/admin/manager/admin_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/legacy.dart';

/// PROVIDER
final adminProvider = StateNotifierProvider<AdminNotifier, AdminState>((ref) => AdminNotifier());

/// REPOSITORY
final AdminRepositoryImpl repo = AdminRepositoryImpl();

/// STORAGE SERVICE
final FileStorageService storageService = FileStorageService();

/// NOTIFIER
class AdminNotifier extends StateNotifier<AdminState> {
  AdminNotifier() : super(const AdminState()) {
    changeMenu(1);
  }

  /// PICK PDF
  Future<void> pickPdf() async {
    final result = await FilePicker.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      state = state.copyWith(selectedPdf: File(result.files.single.path!));
    }
  }

  /// PICK IMAGE
  Future<void> pickImage() async {
    final result = await FilePicker.pickFiles(type: FileType.image);
    if (result != null) {
      state = state.copyWith(selectedImage: File(result.files.single.path!));
    }
  }

  /// PICK BIRTHDAY IMAGE
  Future<void> pickBirthdayImage() async {
    final result = await FilePicker.pickFiles(type: FileType.image);
    if (result != null) {
      state = state.copyWith(selectedBirthdayImage: File(result.files.single.path!));
    }
  }

  /// CLEAR
  void clearImage() => state = state.copyWith(selectedImage: null);
  void clearPdf() => state = state.copyWith(selectedPdf: null);
  void clearBirthdayImage() => state = state.copyWith(selectedBirthdayImage: null);
  void resetSelectedFiles() => state = state.copyWith(selectedImage: null, selectedPdf: null);

  /// CHANGE MENU
  Future<void> changeMenu(int menuId) async {
    state = state.copyWith(selectedMenuId: menuId, isLoading: true);
    final data = await getMenuById(menuId)?.getItems();
    state = state.copyWith(items: data ?? [], isLoading: false);
  }

  /// CREATE ITEM
  Future<String?> createCategory({
    required String title,
    required String description,
    File? selectedImage,
    File? selectedPdf,
  }) async {
    if (title.isEmpty || description.isEmpty) {
      return "Barcha maydonlarni to'ldiring!";
    }

    state = state.copyWith(isLoading: true);

    final menu = getMenuById(state.selectedMenuId);
    if (menu == null) {
      state = state.copyWith(isLoading: false);
      return "Menyu topilmadi!";
    }

    String? savedImagePath;
    String? savedPdfPath;

    if (selectedImage != null) {
      savedImagePath = await storageService.saveFile(file: selectedImage, folderName: menu.folder);
      if (savedImagePath == null) {
        state = state.copyWith(isLoading: false);
        return "Rasm saqlanmadi!";
      }
    }

    if (selectedPdf != null) {
      savedPdfPath = await storageService.saveFile(file: selectedPdf, folderName: menu.folder);
      if (savedPdfPath == null) {
        state = state.copyWith(isLoading: false);
        return "PDF saqlanmadi!";
      }
    }

    await menu.createItem(
      title: title,
      description: description,
      imagePath: savedImagePath,
      pdfPath: savedPdfPath,
      createdAt: DateTime.now(),
    );

    await changeMenu(state.selectedMenuId);

    state = state.copyWith(isLoading: false, selectedImage: null, selectedPdf: null);

    return null;
  }

  /// UPDATE ITEM
  Future<String?> updateItem({
    required int id,
    required String title,
    required String description,
    File? newImage,
    File? newPdf,
    bool removeImage = false,
    bool removePdf = false,
  }) async {
    if (title.isEmpty || description.isEmpty) {
      return "Sarlavha va tavsifni to'ldiring!";
    }

    state = state.copyWith(isLoading: true);

    final menu = getMenuById(state.selectedMenuId);
    if (menu == null) {
      state = state.copyWith(isLoading: false);
      return "Menyu topilmadi!";
    }

    final oldItem = state.items.firstWhereOrNull((e) => e.id == id);

    // ── RASM ──────────────────────────────────────────────────────
    String? finalImagePath = oldItem?.imagePath;

    if (newImage != null) {
      // Yangi rasm tanlangan — eskisini o'chirib, yangisini saqlaymiz
      if (oldItem?.imagePath != null) {
        await storageService.deleteFile(filePath: oldItem!.imagePath);
      }
      finalImagePath = await storageService.saveFile(file: newImage, folderName: menu.folder);
      if (finalImagePath == null) {
        state = state.copyWith(isLoading: false);
        return "Rasm saqlanmadi!";
      }
    } else if (removeImage) {
      // Foydalanuvchi rasmni o'chirishni tanlagan
      if (oldItem?.imagePath != null) {
        await storageService.deleteFile(filePath: oldItem!.imagePath);
      }
      finalImagePath = null;
    }
    // else — na yangi, na o'chirish → finalImagePath = oldItem?.imagePath (o'zgarmaydi)

    // ── PDF ───────────────────────────────────────────────────────
    String? finalPdfPath = oldItem?.pdfPath;

    if (newPdf != null) {
      if (oldItem?.pdfPath != null) {
        await storageService.deleteFile(filePath: oldItem!.pdfPath);
      }
      finalPdfPath = await storageService.saveFile(file: newPdf, folderName: menu.folder);
      if (finalPdfPath == null) {
        state = state.copyWith(isLoading: false);
        return "PDF saqlanmadi!";
      }
    } else if (removePdf) {
      if (oldItem?.pdfPath != null) {
        await storageService.deleteFile(filePath: oldItem!.pdfPath);
      }
      finalPdfPath = null;
    }

    // ── DB YANGILASH ──────────────────────────────────────────────
    await menu.updateItem(
      id: id,
      title: title,
      description: description,
      imagePath: finalImagePath,
      pdfPath: finalPdfPath,
    );

    await changeMenu(state.selectedMenuId);

    state = state.copyWith(isLoading: false, selectedImage: null, selectedPdf: null);

    return null;
  }

  /// DELETE ITEM
  Future<void> deleteItem(int id) async {
    final menu = getMenuById(state.selectedMenuId);
    if (menu == null) return;

    final item = state.items.firstWhereOrNull((e) => e.id == id);

    if (item != null) {
      if (item.imagePath != null) await storageService.deleteFile(filePath: item.imagePath);
      if (item.pdfPath != null) await storageService.deleteFile(filePath: item.pdfPath);
    }

    await menu.deleteItem(id);
    await changeMenu(state.selectedMenuId);
  }

  /// CREATE BIRTHDAY
  Future<String?> createBirthday({
    required String firstName,
    required String lastName,
    required String middleName,
    required String department,
    required DateTime birthDate,
    File? selectedImage,
    File? selectedBirthdayImage,
  }) async {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        middleName.isEmpty ||
        department.isEmpty ||
        selectedImage == null ||
        selectedBirthdayImage == null) {
      return "Barcha maydonlarni to'ldiring!";
    }

    state = state.copyWith(isLoading: true);

    final savedImagePath = await storageService.saveFile(file: selectedImage, folderName: "birthdays");
    if (savedImagePath == null) {
      state = state.copyWith(isLoading: false);
      return "Rasm saqlanmadi!";
    }

    final savedBirthdayImagePath = await storageService.saveFile(file: selectedBirthdayImage, folderName: 'birthdays');
    if (savedBirthdayImagePath == null) {
      state = state.copyWith(isLoading: false);
      return "Tug'ilgan kun rasmi saqlanmadi!";
    }

    await repo.addBirthday(
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      department: department,
      birthDate: birthDate,
      imagePath: savedImagePath,
      birthdayImagePath: savedBirthdayImagePath,
    );

    await getAllBirthdays();

    state = state.copyWith(isLoading: false, selectedImage: null, selectedBirthdayImage: null);

    return null;
  }

  /// GET BIRTHDAYS
  Future<void> getAllBirthdays() async {
    final items = await repo.getAllBirthdays();
    state = state.copyWith(birthdayItems: items);
  }

  /// DELETE BIRTHDAY
  Future<void> deleteBirthday(int id) async {
    await repo.deleteBirthday(id);
    await getAllBirthdays();
  }

  Future<void> changeMenuToBirthday() async {
    state = state.copyWith(selectedMenuId: 999, isLoading: true);
    final items = await repo.getAllBirthdays();
    state = state.copyWith(birthdayItems: items, isLoading: false);
  }
}

// List<dynamic> uchun firstWhereOrNull extension
extension _FirstWhereOrNull on List<dynamic> {
  dynamic firstWhereOrNull(bool Function(dynamic) test) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }
}
