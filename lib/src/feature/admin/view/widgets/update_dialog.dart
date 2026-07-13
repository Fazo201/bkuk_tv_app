import 'dart:io';

import 'package:bkuk_tv_app/src/core/utils/app_snackbar.dart';
import 'package:bkuk_tv_app/src/feature/admin/manager/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateDialog extends ConsumerStatefulWidget {
  final int itemId;
  final String initialTitle;
  final String initialDescription;
  final String? initialImagePath;
  final String? initialPdfPath;

  const UpdateDialog({
    super.key,
    required this.itemId,
    required this.initialTitle,
    required this.initialDescription,
    this.initialImagePath,
    this.initialPdfPath,
  });

  @override
  ConsumerState<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends ConsumerState<UpdateDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  bool _removeImage = false;
  bool _removePdf = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController = TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool get _hasImage => !_removeImage && widget.initialImagePath != null;
  bool get _hasPdf => !_removePdf && widget.initialPdfPath != null;

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
              "YANGILASH",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

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
                      onPressed: () async {
                        await notifier.pickImage();
                        setState(() => _removeImage = false);
                      },
                      icon: state.selectedImage != null
                          ? _filePreview(state.selectedImage!)
                          : _hasImage
                              ? _pathPreview(widget.initialImagePath!)
                              : const Icon(Icons.image_outlined),
                      label: Text(
                        state.selectedImage != null
                            ? state.selectedImage!.path.split('/').last
                            : _hasImage
                                ? widget.initialImagePath!.split('/').last
                                : "Rasm tanlash",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: _removeImage && state.selectedImage == null
                              ? Colors.red.shade300
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),

                if (state.selectedImage != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: "Tanlangan rasmni bekor qilish",
                    onPressed: () => notifier.clearImage(),
                    icon: const Icon(Icons.close, color: Colors.orange),
                  ),
                ] else if (_hasImage) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: "Rasmni o'chirish",
                    onPressed: () => setState(() => _removeImage = true),
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
                ] else if (_removeImage) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: "O'chirishni bekor qilish",
                    onPressed: () => setState(() => _removeImage = false),
                    icon: const Icon(Icons.undo, color: Colors.green),
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
                      onPressed: () async {
                        await notifier.pickPdf();
                        setState(() => _removePdf = false);
                      },
                      icon: Icon(
                        Icons.picture_as_pdf_rounded,
                        color: _removePdf && state.selectedPdf == null
                            ? Colors.red.shade300
                            : Colors.red,
                      ),
                      label: Text(
                        state.selectedPdf != null
                            ? state.selectedPdf!.path.split('/').last
                            : _hasPdf
                                ? widget.initialPdfPath!.split('/').last
                                : "PDF tanlash",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: _removePdf && state.selectedPdf == null
                              ? Colors.red.shade300
                              : !_hasPdf && state.selectedPdf == null
                                  ? Colors.grey
                                  : null,
                        ),
                      ),
                    ),
                  ),
                ),

                if (state.selectedPdf != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: "Tanlangan PDFni bekor qilish",
                    onPressed: () => notifier.clearPdf(),
                    icon: const Icon(Icons.close, color: Colors.orange),
                  ),
                ] else if (_hasPdf) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: "PDFni o'chirish",
                    onPressed: () => setState(() => _removePdf = true),
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
                ] else if (_removePdf) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: "O'chirishni bekor qilish",
                    onPressed: () => setState(() => _removePdf = false),
                    icon: const Icon(Icons.undo, color: Colors.green),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 28),

            /// UPDATE BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () async {
                        final result = await notifier.updateItem(
                          id: widget.itemId,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          newImage: state.selectedImage,
                          newPdf: state.selectedPdf,
                          removeImage: _removeImage,
                          removePdf: _removePdf,
                        );

                        if (context.mounted) {
                          if (result != null) {
                            AppSnackBar.show(
                              context: context,
                              text: result,
                              backgroundColor: Colors.red,
                            );
                          } else {
                            Navigator.pop(context);
                            AppSnackBar.show(
                              context: context,
                              text: "Yangilandi",
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
                    : const Text(
                        "Yangilash",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filePreview(File file) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.file(file, width: 36, height: 36, fit: BoxFit.cover),
    );
  }

  Widget _pathPreview(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.file(
        File(path),
        width: 36,
        height: 36,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.image_outlined),
      ),
    );
  }
}