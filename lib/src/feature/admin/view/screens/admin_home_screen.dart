import 'package:bkuk_tv_app/src/core/constants/menus.dart';
import 'package:bkuk_tv_app/src/core/utils/app_snackbar.dart';
import 'package:bkuk_tv_app/src/feature/admin/manager/admin_provider.dart';
import 'package:bkuk_tv_app/src/feature/admin/view/widgets/admin_create_birthday_dialog.dart';
import 'package:bkuk_tv_app/src/feature/admin/view/widgets/admin_custom_card.dart';
import 'package:bkuk_tv_app/src/feature/admin/view/widgets/admin_menu_widget.dart';
import 'package:bkuk_tv_app/src/feature/admin/view/widgets/create_dialog.dart';
import 'package:bkuk_tv_app/src/feature/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomeScreen extends ConsumerWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminProvider);
    final notifier = ref.read(adminProvider.notifier);

    final isBirthday = state.selectedMenuId == 999;
    final menu = getMenuById(state.selectedMenuId);
    final canAdd = isBirthday || (menu?.singleItem != true || state.items.isEmpty);

    void showCreateDialog() {
      showDialog(
        context: context,
        builder: (_) => isBirthday ? const AdminCreateBirthdayDialog() : const CreateDialog(),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/home_detail_background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),

          /// MENU
          Positioned(
            left: 32.w,
            top: 32.h,
            child: SizedBox(height: 1020.h, width: 400.w, child: AdminMenuWidget()),
          ),

          /// HEADER
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
                          isBirthday ? "TUG'ILGAN KUNLAR" : menu?.title.toUpperCase() ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          ),
                        ),
                      ),
                      if (canAdd)
                        FloatingActionButton(
                          onPressed: showCreateDialog,
                          backgroundColor: const Color(0xFF1B4677),
                          child: const Icon(Icons.add, color: Color(0xFFE7B96E)),
                        )
                        else
                        SizedBox(width: 56.w, height: 56.h), 
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        isBirthday
                            ? "Jami tug'ilgan kunlar: ${state.birthdayItems.length}"
                            : "Jami hujjatlar soni: ${state.items.length}",
                        style: TextStyle(color: const Color(0xFFE7B96E), fontSize: 22.sp),
                      ),
                      Expanded(child: CustomDivider()),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// LIST
          Positioned(
            right: 36.w,
            bottom: 20.h,
            child: Container(
              height: 890.h,
              width: 1350.w,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
              child: isBirthday
                  ? _BirthdayList(
                      items: state.birthdayItems,
                      onDelete: (id) async {
                        await notifier.deleteBirthday(id);
                        if (context.mounted) {
                          AppSnackBar.show(context: context, text: "O'chirildi", backgroundColor: Colors.green);
                        }
                      },
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return AdminCustomCard(
                          title: item.title,
                          description: item.description,
                          imagePath: item.imagePath,
                          date: item.createdAt.toString().split(' ').first,
                          onDelete: () async {
                            await notifier.deleteItem(item.id);
                            if (context.mounted) {
                              AppSnackBar.show(context: context, text: "O'chirildi", backgroundColor: Colors.green);
                            }
                          },
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(height: 20.h),
                      itemCount: state.items.length,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── BIRTHDAY LIST ────────────────────────────────────────────────

class _BirthdayList extends StatelessWidget {
  final List<dynamic> items;
  final Future<void> Function(int id) onDelete;

  const _BirthdayList({required this.items, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 20.h),
      itemBuilder: (context, index) {
        final item = items[index];
        return AdminCustomCard(
          title: '${item.lastName} ${item.firstName} ${item.middleName}',
          description: item.department,
          imagePath: item.imagePath,
          date: '${item.birthDate.day}.${item.birthDate.month}.${item.birthDate.year}',
          onDelete: () => onDelete(item.id),
        );
      },
    );
  }
}
