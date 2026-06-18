import 'dart:io';

class AdminState {
  final int selectedMenuId;

  final bool isLoading;

  final List<dynamic> items;

  final List<dynamic> birthdayItems;

  final File? selectedImage;

  final File? selectedBirthdayImage;

  final File? selectedPdf;

  const AdminState({this.selectedMenuId = 5, this.isLoading = false, this.items = const [], this.birthdayItems = const [], this.selectedImage, this.selectedBirthdayImage, this.selectedPdf});

  AdminState copyWith({int? selectedMenuId, bool? isLoading, List<dynamic>? items, List<dynamic>? birthdayItems, File? selectedImage, File? selectedBirthdayImage, File? selectedPdf}) {
    return AdminState(
      selectedMenuId: selectedMenuId ?? this.selectedMenuId,

      isLoading: isLoading ?? this.isLoading,

      items: items ?? this.items,

      birthdayItems: birthdayItems ?? this.birthdayItems,

      selectedImage: selectedImage ?? this.selectedImage,

      selectedBirthdayImage: selectedBirthdayImage ?? this.selectedBirthdayImage,

      selectedPdf: selectedPdf ?? this.selectedPdf,
    );
  }
}
