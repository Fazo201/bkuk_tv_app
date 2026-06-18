import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdfrx/pdfrx.dart';

class CustomLoadPdfWidget extends StatefulWidget {
  const CustomLoadPdfWidget({super.key, required this.fileName, required this.filePath, required this.onClose, this.automaticallyImplyLeading = true});

  final String fileName;
  final String filePath;
  final VoidCallback onClose;
  final bool automaticallyImplyLeading;

  @override
  State<CustomLoadPdfWidget> createState() => _CustomLoadPdfWidgetState();
}

class _CustomLoadPdfWidgetState extends State<CustomLoadPdfWidget> {
  final PdfViewerController _pdfController = PdfViewerController();
  final ScrollController _thumbnailScrollController = ScrollController();

  int _currentPage = 1;
  int _totalPages = 0;
  PdfDocument? _pdfDoc;
  bool _isFitMode = true;

  @override
  void initState() {
    super.initState();
    _loadPdfDocument();
  }

  Future<void> _loadPdfDocument() async {
    try {
      final doc = await PdfDocument.openFile(widget.filePath, passwordProvider: () async => '');
      if (mounted) {
        setState(() {
          _pdfDoc = doc;
          _totalPages = doc.pages.length;
        });
      }
    } catch (e) {
      debugPrint('PDF load error: $e');
    }
  }

  @override
  void dispose() {
    _thumbnailScrollController.dispose();
    _pdfDoc?.dispose();
    super.dispose();
  }

  void _scrollThumbnailToPage(int page) {
    final itemHeight = 150.h;
    final offset = (page - 1) * itemHeight;
    _thumbnailScrollController.animateTo(offset, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Column(
        children: [
          // ── Toolbar ──
          Container(
            height: 64.h,
            decoration: BoxDecoration(
              color: Color(0xFF12345B),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              border: Border.all(color: Colors.white10, width: 1.2),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              spacing: 12.w,
              children: [
                if(widget.automaticallyImplyLeading)
                _BackButton(onTap: widget.onClose),
                Expanded(
                  child: Text(
                    widget.fileName,
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(4.r)),
                  child: Text(
                    '$_currentPage / $_totalPages',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
                PdfFitButton(
                  isFitMode: _isFitMode,
                  onTap: () async {
                    setState(() => _isFitMode = !_isFitMode);

                    if (_isFitMode) {
                      await _pdfController.goTo(_pdfController.calcMatrixFitWidthForPage(pageNumber: _currentPage));
                    } else {
                      // Minimal zoom
                      await _pdfController.setZoom(_pdfController.centerPosition, _pdfController.minScale);
                    }
                  },
                ),
              ],
            ),
          ),

          // ── Asosiy qism ──
          Expanded(
            child: Row(
              children: [
                // ── Thumbnail panel ──
                Container(
                  width: 240.w,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    border: Border.all(color: Colors.white10, width: 1.2),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.r)),
                  ),
                  child: _pdfDoc == null
                      ? const Center(child: CircularProgressIndicator(color: Colors.white54))
                      : ListView.builder(
                          controller: _thumbnailScrollController,
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          itemCount: _totalPages,
                          itemBuilder: (context, index) {
                            final pageNumber = index + 1;
                            final isSelected = pageNumber == _currentPage;

                            return PdfThumbnailItem(
                              pdfDoc: _pdfDoc!,
                              pageNumber: pageNumber,
                              isSelected: isSelected,
                              onTap: () {
                                _pdfController.goToPage(pageNumber: pageNumber);
                                setState(() => _currentPage = pageNumber);
                              },
                            );
                          },
                        ),
                ),

                // ── PDF Viewer ──
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      border: Border.all(color: Colors.white10, width: 1.2),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.r)),
                    ),
                    child: PdfViewer.file(
                      widget.filePath,
                      key: ValueKey(widget.filePath),
                      controller: _pdfController,
                      params: PdfViewerParams(
                        backgroundColor: Colors.transparent,
                        onPageChanged: (page) {
                          if (page == null) return;
                          setState(() => _currentPage = page);
                          _scrollThumbnailToPage(page);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Toolbar icon button ──
class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.r,
        height: 36.r,
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4.r)),
        child: Icon(Icons.arrow_back, color: Colors.white, size: 22.r),
      ),
    );
  }
}

class PdfThumbnailItem extends StatelessWidget {
  const PdfThumbnailItem({
    super.key,
    required this.pdfDoc,
    required this.pageNumber,
    required this.isSelected,
    required this.onTap,
  });

  final PdfDocument pdfDoc;
  final int pageNumber;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 54.w, vertical: 12.h),
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Color(0xFFECC96A).withValues(alpha: 0.55) : Colors.transparent,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: isSelected
              ? [BoxShadow(color: const Color(0xFFECC96A).withValues(alpha: 0.4), blurRadius: 6)]
              : null,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: Stack(
                children: [
                  PdfPageView(document: pdfDoc, pageNumber: pageNumber, alignment: Alignment.center),

                  Positioned(
                    left: 6.w,
                    bottom: 6.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFD4A842) : Colors.black54,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                      child: Text(
                        '$pageNumber',
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PdfFitButton extends StatelessWidget {
  const PdfFitButton({super.key, required this.isFitMode, required this.onTap});

  final bool isFitMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.r,
        height: 36.r,
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4.r)),
        alignment: Alignment.center,
        child: Icon(
          isFitMode ? CupertinoIcons.fullscreen_exit : CupertinoIcons.fullscreen,
          color: Colors.white,
          size: 22.r,
        ),
      ),
    );
  }
}
