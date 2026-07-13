import 'package:bkuk_tv_app/src/core/constants/menus.dart';
import 'package:bkuk_tv_app/src/core/utils/app_snackbar.dart';
import 'package:bkuk_tv_app/src/feature/admin/manager/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateDialog extends ConsumerStatefulWidget {
  const CreateDialog({super.key});

  @override
  ConsumerState<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends ConsumerState<CreateDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
            Text(menus[state.selectedMenuId-1].title.toUpperCase(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

            const SizedBox(height: 24),

            /// TITLE
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Sarlavha",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),

            const SizedBox(height: 16),

            /// DESCRIPTION
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Tavsif",
                alignLabelWithHint: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),

            const SizedBox(height: 16),

            /// IMAGE PICKER
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: OutlinedButton.icon(
                      onPressed: () async => await notifier.pickImage(),
                      icon: state.selectedImage == null
                          ? const Icon(Icons.image_outlined)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                state.selectedImage!,
                                width: 36,
                                height: 36,
                                fit: BoxFit.cover,
                              ),
                            ),
                      label: Text(
                        state.selectedImage == null
                            ? "Rasm tanlash"
                            : state.selectedImage!.path.split('/').last,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                if (state.selectedImage != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: "Rasmni o'chirish",
                    onPressed: () => notifier.clearImage(),
                    icon: const Icon(Icons.close, color: Colors.red),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 12),

            /// PDF PICKER
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: OutlinedButton.icon(
                      onPressed: () async => await notifier.pickPdf(),
                      icon: const Icon(Icons.picture_as_pdf_rounded, color: Colors.red),
                      label: Text(
                        state.selectedPdf == null
                            ? "PDF fayl tanlash"
                            : state.selectedPdf!.path.split('/').last,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                if (state.selectedPdf != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: "PDF faylni o'chirish",
                    onPressed: () => notifier.clearPdf(),
                    icon: const Icon(Icons.close, color: Colors.red),
                  ),
                ],
              ],
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
                        final result = await notifier.createCategory(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          selectedImage: state.selectedImage,
                          selectedPdf: state.selectedPdf,
                        );

                        if (context.mounted) {
                          if (result != null) {
                            AppSnackBar.show(context: context, text: result, backgroundColor: Colors.red);
                          } else {
                            Navigator.pop(context);
                            AppSnackBar.show(context: context, text: "E'lon qo'shildi", backgroundColor: Colors.green);
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
