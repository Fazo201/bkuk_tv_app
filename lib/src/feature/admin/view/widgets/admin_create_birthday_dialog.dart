import 'package:bkuk_tv_app/src/core/utils/app_snackbar.dart';
import 'package:bkuk_tv_app/src/feature/admin/manager/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminCreateBirthdayDialog extends ConsumerStatefulWidget {
  const AdminCreateBirthdayDialog({super.key});

  @override
  ConsumerState<AdminCreateBirthdayDialog> createState() => _AdminCreateBirthdayDialogState();
}

class _AdminCreateBirthdayDialogState extends ConsumerState<AdminCreateBirthdayDialog> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _departmentController = TextEditingController();
  DateTime? _birthDate;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _birthDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminProvider);
    final notifier = ref.read(adminProvider.notifier);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 450,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "TUG'ILGAN KUN",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            /// FIRST NAME
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: "Ism",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),

            const SizedBox(height: 12),

            /// LAST NAME
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: "Familiya",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),

            const SizedBox(height: 12),

            /// MIDDLE NAME
            TextField(
              controller: _middleNameController,
              decoration: InputDecoration(
                labelText: "Otasining ismi",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),

            const SizedBox(height: 12),

            /// DEPARTMENT
            TextField(
              controller: _departmentController,
              decoration: InputDecoration(
                labelText: "Departament",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),

            const SizedBox(height: 12),

            /// BIRTH DATE
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today_outlined),
                label: Text(
                  _birthDate == null
                      ? "Tug'ilgan sanani tanlang"
                      : "${_birthDate!.day}.${_birthDate!.month}.${_birthDate!.year}",
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// IMAGE PICKER
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: () async => await notifier.pickImage(),
                icon: state.selectedImage == null
                    ? const Icon(Icons.image_outlined)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.file(state.selectedImage!, width: 36, height: 36, fit: BoxFit.cover),
                      ),
                label: Text(
                  state.selectedImage == null ? "Rasm tanlash" : state.selectedImage!.path.split('/').last,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// BIRTHDAY IMAGE PICKER
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: () async => await notifier.pickBirthdayImage(),
                icon: state.selectedBirthdayImage == null
                    ? const Icon(Icons.celebration_outlined)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.file(state.selectedBirthdayImage!, width: 36, height: 36, fit: BoxFit.cover),
                      ),
                label: Text(
                  state.selectedBirthdayImage == null
                      ? "Tug'ilgan kun rasmi tanlash"
                      : state.selectedBirthdayImage!.path.split('/').last,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            const SizedBox(height: 28),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () async {
                        if (_birthDate == null) {
                          AppSnackBar.show(
                            context: context,
                            text: "Tug'ilgan sanani tanlang!",
                            backgroundColor: Colors.red,
                          );
                          return;
                        }

                        final result = await notifier.createBirthday(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          middleName: _middleNameController.text,
                          department: _departmentController.text,
                          birthDate: _birthDate!,
                          selectedImage: state.selectedImage,
                          selectedBirthdayImage: state.selectedBirthdayImage,
                        );

                        if (context.mounted) {
                          if (result != null) {
                            AppSnackBar.show(context: context, text: result, backgroundColor: Colors.red);
                          } else {
                            Navigator.pop(context);
                            AppSnackBar.show(
                              context: context,
                              text: "Muvaffaqiyatli qo'shildi",
                              backgroundColor: Colors.green,
                            );
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0A4DAB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: state.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Saqlash", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}