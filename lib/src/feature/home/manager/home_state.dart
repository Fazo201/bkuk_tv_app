import 'dart:io';

class HomeState {
  final int selectedMenuId;

  final bool isLoading;

  final List<dynamic> items;

  final List<dynamic> birthdayItems;

  const HomeState({this.selectedMenuId = 5, this.isLoading = false, this.items = const [], this.birthdayItems = const []});

  HomeState copyWith({int? selectedMenuId, bool? isLoading, List<dynamic>? items, List<dynamic>? birthdayItems, File? file}) {
    return HomeState(
      selectedMenuId: selectedMenuId ?? this.selectedMenuId,

      isLoading: isLoading ?? this.isLoading,

      items: items ?? this.items, 
      
      birthdayItems: birthdayItems ?? this.birthdayItems,
    );
  }
}
