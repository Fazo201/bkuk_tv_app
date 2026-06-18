import 'package:bkuk_tv_app/src/core/constants/menus.dart';
import 'package:bkuk_tv_app/src/core/db/app_database.dart';
import 'package:bkuk_tv_app/src/core/services/file_storage_service.dart';
import 'package:bkuk_tv_app/src/feature/home/data/home_repository_impl.dart';
import 'package:bkuk_tv_app/src/feature/home/manager/home_state.dart';
import 'package:flutter_riverpod/legacy.dart';

/// PROVIDER
final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) => HomeNotifier());

/// REPOSITORY
final HomeRepositoryImpl repo = HomeRepositoryImpl(AppDatabase());

/// STORAGE SERVICE
final FileStorageService storageService = FileStorageService();

/// NOTIFIER
class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState()) {
    changeMenu(1);
    getAllBirthdays();
  }

  /// CHANGE MENU
  Future<void> changeMenu(int menuId) async {
    state = state.copyWith(selectedMenuId: menuId, isLoading: true);

    if (menuId == 999) {
      await getAllBirthdays();
      return;
    }

    final menu = getMenuById(menuId);
    final data = await menu?.getItems();
    state = state.copyWith(items: data, isLoading: false);
  }

  Future<void> getAllBirthdays() async {
    final items = await repo.getAllBirthdays();
    state = state.copyWith(birthdayItems: items, isLoading: false);
  }
}
