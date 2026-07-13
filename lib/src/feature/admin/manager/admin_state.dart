import 'dart:io';

class AdminState {
  final int selectedMenuId;
  final bool isLoading;
  final List<dynamic> items;
  final List<dynamic> birthdayItems;
  final File? selectedImage;
  final File? selectedBirthdayImage;
  final File? selectedPdf;

  const AdminState({
    this.selectedMenuId = 5,
    this.isLoading = false,
    this.items = const [],
    this.birthdayItems = const [],
    this.selectedImage,
    this.selectedBirthdayImage,
    this.selectedPdf,
  });

  AdminState copyWith({
    int? selectedMenuId,
    bool? isLoading,
    List<dynamic>? items,
    List<dynamic>? birthdayItems,
    Object? selectedImage = _keep,
    Object? selectedBirthdayImage = _keep,
    Object? selectedPdf = _keep,
  }) {
    return AdminState(
      selectedMenuId: selectedMenuId ?? this.selectedMenuId,
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      birthdayItems: birthdayItems ?? this.birthdayItems,
      selectedImage: selectedImage == _keep ? this.selectedImage : selectedImage as File?,
      selectedBirthdayImage: selectedBirthdayImage == _keep ? this.selectedBirthdayImage : selectedBirthdayImage as File?,
      selectedPdf: selectedPdf == _keep ? this.selectedPdf : selectedPdf as File?,
    );
  }
}

// Sentinel — "parametr o'tkazilmadi" belgisi
const Object _keep = Object();