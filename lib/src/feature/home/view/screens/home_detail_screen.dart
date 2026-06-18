import 'package:bkuk_tv_app/src/core/constants/menus.dart';
import 'package:bkuk_tv_app/src/feature/home/manager/home_provider.dart';
import 'package:bkuk_tv_app/src/feature/home/manager/home_state.dart';
import 'package:bkuk_tv_app/src/feature/home/view/widgets/home_detail_menu_widget.dart';
import 'package:bkuk_tv_app/src/feature/widgets/custom_card_widget.dart';
import 'package:bkuk_tv_app/src/feature/widgets/custom_divider.dart';
import 'package:bkuk_tv_app/src/feature/widgets/custom_load_pdf_widget.dart';
import 'package:bkuk_tv_app/src/feature/widgets/date_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDetailScreen extends ConsumerStatefulWidget {
  const HomeDetailScreen({super.key});
  @override
  ConsumerState<HomeDetailScreen> createState() => _HomeDetailScreenState();
}

class _HomeDetailScreenState extends ConsumerState<HomeDetailScreen> {
  final _pdfPath = ValueNotifier<String?>(null);
  int? _lastMenuId;

  @override
  void dispose() {
    _pdfPath.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);

    if (_lastMenuId != null && _lastMenuId != state.selectedMenuId) {
      _pdfPath.value = null;
    }
    _lastMenuId = state.selectedMenuId;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/home_detail_background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Positioned(
            left: 32.w,
            top: 32.h,
            child: SizedBox(height: 1020.h, width: 400.w, child: HomeDetailMenuWidget()),
          ),
          Positioned(
            right: 32.w,
            top: 22.h,
            child: SizedBox(
              width: 1290.w,
              child: Column(
                spacing: 12.h,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 220.w,
                    children: [
                      Expanded(
                        child: Text(
                          state.selectedMenuId != 999
                              ? menus[state.selectedMenuId - 1].title.toUpperCase()
                              : "TUG'ILGAN KUNLAR",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ),
                      DateTimeWidget(color: Colors.white),
                    ],
                  ),
                  CustomDivider(),
                ],
              ),
            ),
          ),
          Positioned(
            right: 36.w,
            bottom: 20.h,
            child: SizedBox(
              height: 890.h,
              width: 1350.w,
              child: ValueListenableBuilder<String?>(
                valueListenable: _pdfPath,
                builder: (context, path, widget) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildContent(state, path),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(HomeState state, String? path) {
    final menu = getMenuById(state.selectedMenuId);

    if (menu?.singleItem == true) {
      final item = state.items.first;

      return CustomLoadPdfWidget(
        key: ValueKey(item.pdfPath),
        fileName: item.title,
        filePath: item.pdfPath!,
        onClose: () {},
        automaticallyImplyLeading: false,
      );
    }

    if (path != null) {
      return CustomLoadPdfWidget(
        key: ValueKey(path),
        fileName: state.items.firstWhere((item) => item.pdfPath == path).title,
        filePath: path,
        onClose: () => _pdfPath.value = null,
      );
    }

    return ListView.separated(
      key: const ValueKey('list'),
      itemCount: state.items.length,
      separatorBuilder: (_, __) => SizedBox(height: 20.h),
      itemBuilder: (context, index) {
        final item = state.items[index];

        return CustomCardWidget(
          imageUrl: item.imagePath,
          title: item.title,
          description: item.description,
          date: item.createdAt.toString().split(' ').first,
          onTap: () {
            if (item.pdfPath == null) return;
            _pdfPath.value = item.pdfPath;
          },
        );
      },
    );
  }
}
