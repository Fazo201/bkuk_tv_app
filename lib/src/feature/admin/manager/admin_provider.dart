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
    /// DEFAULT MENU
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

  /// CHANGE MENU
  Future<void> changeMenu(int menuId) async {
    state = state.copyWith(selectedMenuId: menuId, isLoading: true);

    final menu = getMenuById(menuId);

    final data = await menu?.getItems();

    state = state.copyWith(items: data, isLoading: false);
  }

  /// CREATE ITEM
  Future<String?> createCategory({
    required String title,
    required String description,
    File? selectedImage,
    File? selectedPdf,
  }) async {
    // selectedImage ham tekshirilishi kerak
    if (title.isEmpty || description.isEmpty || selectedImage == null || selectedPdf == null) {
      return "Barcha maydonlarni to'ldiring!";
    }

    state = state.copyWith(isLoading: true);

    final menu = getMenuById(state.selectedMenuId);

    /// SAVE IMAGE
    final savedImagePath = await storageService.saveFile(file: selectedImage, folderName: menu!.folder);
    if (savedImagePath == null) {
      state = state.copyWith(isLoading: false);
      return "Rasm saqlanmadi!";
    }

    /// SAVE PDF
    final savedPdfPath = await storageService.saveFile(file: selectedPdf, folderName: menu.folder);
    if (savedPdfPath == null) {
      state = state.copyWith(isLoading: false);
      return "PDF saqlanmadi!";
    }

    /// CREATE DB ITEM
    await menu.createItem(
      title: title,
      description: description,
      imagePath: savedImagePath,
      pdfPath: savedPdfPath,
      createdAt: DateTime.now(),
    );

    /// REFRESH
    await changeMenu(state.selectedMenuId);

    // selectedImage ham null ga qaytarilishi kerak
    state = state.copyWith(isLoading: false, selectedImage: null, selectedPdf: null);

    return null;
  }

  /// DELETE ITEM
  Future<void> deleteItem(int id) async {
    final menu = getMenuById(state.selectedMenuId);

    final item = state.items.cast<dynamic>().firstWhere((e) => e.id == id, orElse: () => null);

    if (item != null) {
      await storageService.deleteFile(filePath: item.imagePath);
      await storageService.deleteFile(filePath: item.pdfPath);
    }

    await menu!.deleteItem(id);

    await changeMenu(state.selectedMenuId);
  }

  void resetSelectedFiles() {
    state = state.copyWith(selectedImage: null, selectedPdf: null);
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

    /// SAVE IMAGE
    final savedImagePath = await storageService.saveFile(file: selectedImage, folderName: "birthdays");
    if (savedImagePath == null) {
      state = state.copyWith(isLoading: false);
      return "Rasm saqlanmadi!";
    }

    /// SAVE BIRTHDAY IMAGE
    final savedBirthdayImagePath = await storageService.saveFile(file: selectedBirthdayImage, folderName: 'birthdays');
    if (savedBirthdayImagePath == null) {
      state = state.copyWith(isLoading: false);
      return "Tug'ilgan kun rasmi saqlanmadi!";
    }

    /// CREATE DB ITEM
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
