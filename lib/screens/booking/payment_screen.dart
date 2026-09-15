import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/booking_provider.dart';
import '../../widgets/booking/booking_stepper.dart';
import '../../widgets/layout/app_top_bar.dart';
import '../../widgets/layout/bottom_nav_bar.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _uploadedFileName;
  String? _uploadedFileType; // 'jpg', 'png', 'pdf'
  String? _uploadedFileSize;

  String _detectFileType(String filename) {
    final lower = filename.toLowerCase().trim();
    if (lower.endsWith('.pdf')) return 'pdf';
    if (lower.endsWith('.png')) return 'png';
    if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) return 'jpg';
    return 'unknown';
  }

  void _attachFile(String fileName, {String? type, String? size}) {
    final detectedType = type ?? _detectFileType(fileName);
    final detectedSize = size ?? '1.8 MB';

    setState(() {
      _uploadedFileName = fileName;
      _uploadedFileType = detectedType;
      _uploadedFileSize = detectedSize;
    });

    context.read<BookingProvider>().setReceiptFileName(fileName);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              detectedType == 'pdf'
                  ? Icons.picture_as_pdf_rounded
                  : (detectedType == 'png'
                      ? Icons.image_rounded
                      : Icons.photo_library_rounded),
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Attached ${detectedType.toUpperCase()}: $fileName',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryNavy,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _removeFile() {
    setState(() {
      _uploadedFileName = null;
      _uploadedFileType = null;
      _uploadedFileSize = null;
    });
    context.read<BookingProvider>().setReceiptFileName(null);
  }

  void _showFileUploadPicker(BuildContext context) {
    final customNameController = TextEditingController(text: 'payment_receipt_${DateTime.now().millisecondsSinceEpoch % 10000}');
    String selectedExt = '.png';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (modalCtx, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                top: 24,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(modalCtx).viewInsets.bottom + 24,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Modal Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Upload Payment Confirmation',
                                style: TextStyle(
                                  color: AppColors.primaryNavy,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Select a format (JPG, PNG, or PDF max 10MB)',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                            onPressed: () => Navigator.pop(ctx),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Format 1: JPG Option
                      _buildUploadOptionCard(
                        ctx: ctx,
                        badgeText: 'JPG',
                        badgeColor: const Color(0xFFD97706),
                        badgeBg: const Color(0xFFFEF3C7),
                        icon: Icons.photo_camera_rounded,
                        iconColor: const Color(0xFFD97706),
                        title: 'Upload JPG Photo Receipt',
                        subtitle: 'Best for camera captures or photo gallery',
                        defaultFilename: 'camera_receipt_${DateTime.now().millisecondsSinceEpoch % 10000}.jpg',
                        fileSize: '1.4 MB',
                        type: 'jpg',
                      ),
                      const SizedBox(height: 10),

                      // Format 2: PNG Option
                      _buildUploadOptionCard(
                        ctx: ctx,
                        badgeText: 'PNG',
                        badgeColor: const Color(0xFF2563EB),
                        badgeBg: const Color(0xFFDBEAFE),
                        icon: Icons.image_rounded,
                        iconColor: const Color(0xFF2563EB),
                        title: 'Upload PNG Screenshot',
                        subtitle: 'Best for GCash / Maya transaction receipts',
                        defaultFilename: 'gcash_screenshot_${DateTime.now().millisecondsSinceEpoch % 10000}.png',
                        fileSize: '2.1 MB',
                        type: 'png',
                      ),
                      const SizedBox(height: 10),

                      // Format 3: PDF Option
                      _buildUploadOptionCard(
                        ctx: ctx,
                        badgeText: 'PDF',
                        badgeColor: const Color(0xFFDC2626),
                        badgeBg: const Color(0xFFFEE2E2),
                        icon: Icons.picture_as_pdf_rounded,
                        iconColor: const Color(0xFFDC2626),
                        title: 'Upload PDF Document',
                        subtitle: 'Best for bank deposit slip or e-statement',
                        defaultFilename: 'bank_transfer_slip_${DateTime.now().millisecondsSinceEpoch % 10000}.pdf',
                        fileSize: '850 KB',
                        type: 'pdf',
                      ),
                      const SizedBox(height: 18),

                      const Divider(height: 1, color: Color(0xFFE2E8F0)),
                      const SizedBox(height: 14),

                      // Custom File Name Option
                      const Text(
                        'Or Custom File Name:',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: customNameController,
                              style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                              decoration: InputDecoration(
                                hintText: 'Enter file name',
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                filled: true,
                                fillColor: const Color(0xFFF8FAFC),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: AppColors.primaryNavy, width: 1.5),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Dropdown for extension
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFCBD5E1)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedExt,
                                items: const [
                                  DropdownMenuItem(value: '.jpg', child: Text('.jpg', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                                  DropdownMenuItem(value: '.png', child: Text('.png', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                                  DropdownMenuItem(value: '.pdf', child: Text('.pdf', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                                ],
                                onChanged: (val) {
                                  if (val != null) {
                                    setModalState(() {
                                      selectedExt = val;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            final rawName = customNameController.text.trim();
                            if (rawName.isEmpty) return;

                            String finalFileName = rawName;
                            // Ensure proper extension
                            if (!finalFileName.toLowerCase().endsWith('.jpg') &&
                                !finalFileName.toLowerCase().endsWith('.jpeg') &&
                                !finalFileName.toLowerCase().endsWith('.png') &&
                                !finalFileName.toLowerCase().endsWith('.pdf')) {
                              finalFileName = '$finalFileName$selectedExt';
                            }

                            final type = _detectFileType(finalFileName);
                            _attachFile(finalFileName, type: type, size: '1.5 MB');
                            Navigator.pop(ctx);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryNavy,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Attach Custom File',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildUploadOptionCard({
    required BuildContext ctx,
    required String badgeText,
    required Color badgeColor,
    required Color badgeBg,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String defaultFilename,
    required String fileSize,
    required String type,
  }) {
    return InkWell(
      onTap: () {
        _attachFile(defaultFilename, type: type, size: fileSize);
        Navigator.pop(ctx);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: badgeBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: badgeBg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badgeText,
                          style: TextStyle(
                            color: badgeColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.read<BookingProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppTopBar(
        title: 'Alpha Memoria',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // STEP 4 OF 4: Payment
            const BookingStepper(
              currentStep: 4,
              totalSteps: 4,
              stepTitle: 'Payment',
            ),

            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 580),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Complete your payment',
                      style: TextStyle(
                        color: AppColors.primaryNavy,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Scan the QR code, then upload you receipt below to complete or pay 50% of non-refundable downpayment.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // QR Code Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                      decoration: BoxDecoration(
                        color: const Color(0xFF132238),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          // QR Container
                          Container(
                            width: 170,
                            height: 170,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: CustomPaint(
                              painter: _StylizedQrPainter(),
                            ),
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            'Alpha Memoria Events',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // GCash line
                          _buildPaymentNumberRow('GCash', '0917 123 4567'),
                          const SizedBox(height: 6),

                          // Maya line
                          _buildPaymentNumberRow('Maya', '0917 123 4567'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // UPLOAD PAYMENT CONFIRMATION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'UPLOAD PAYMENT CONFIRMATION',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                          ),
                        ),
                        if (_uploadedFileName != null)
                          TextButton.icon(
                            onPressed: () => _showFileUploadPicker(context),
                            icon: const Icon(Icons.swap_horiz_rounded, size: 14, color: AppColors.primaryNavy),
                            label: const Text(
                              'Change',
                              style: TextStyle(
                                color: AppColors.primaryNavy,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Upload Container (Dashed if empty, Solid Card if attached)
                    if (_uploadedFileName == null) ...[
                      InkWell(
                        onTap: () => _showFileUploadPicker(context),
                        borderRadius: BorderRadius.circular(14),
                        child: CustomPaint(
                          painter: _DashedRectPainter(
                            color: const Color(0xFF60A5FA),
                            strokeWidth: 1.5,
                            gap: 5,
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F7FF),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF0077E6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_upward_rounded,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Click to upload receipt',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Supports JPG, PNG, or PDF — max 10MB',
                                  style: TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      // File Attached Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F7FF),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.primaryNavy.withValues(alpha: 0.3), width: 1.2),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: _uploadedFileType == 'pdf'
                                    ? const Color(0xFFFEE2E2)
                                    : (_uploadedFileType == 'jpg'
                                        ? const Color(0xFFFEF3C7)
                                        : const Color(0xFFDBEAFE)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                _uploadedFileType == 'pdf'
                                    ? Icons.picture_as_pdf_rounded
                                    : (_uploadedFileType == 'jpg'
                                        ? Icons.photo_library_rounded
                                        : Icons.image_rounded),
                                color: _uploadedFileType == 'pdf'
                                    ? const Color(0xFFDC2626)
                                    : (_uploadedFileType == 'jpg'
                                        ? const Color(0xFFD97706)
                                        : const Color(0xFF2563EB)),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _uploadedFileName!,
                                          style: const TextStyle(
                                            color: AppColors.primaryNavy,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: const Color(0xFFCBD5E1)),
                                        ),
                                        child: Text(
                                          (_uploadedFileType ?? 'FILE').toUpperCase(),
                                          style: const TextStyle(
                                            color: AppColors.primaryNavy,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Text(
                                        _uploadedFileSize ?? '1.6 MB',
                                        style: const TextStyle(
                                          color: AppColors.textMuted,
                                          fontSize: 11,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      const Icon(Icons.check_circle_rounded, size: 12, color: Color(0xFF10B981)),
                                      const SizedBox(width: 3),
                                      const Text(
                                        'Ready to submit',
                                        style: TextStyle(
                                          color: Color(0xFF10B981),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary, size: 18),
                              onPressed: _removeFile,
                              tooltip: 'Remove receipt',
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 28),

                    // Back & Submit Buttons Row
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 44,
                            child: OutlinedButton(
                              onPressed: () => Navigator.maybePop(context),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primaryNavy,
                                side: const BorderSide(color: AppColors.primaryNavy, width: 1.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_uploadedFileName == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please upload a payment confirmation (JPG, PNG, or PDF) before submitting.'),
                                      backgroundColor: Color(0xFFDC2626),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  _showFileUploadPicker(context);
                                  return;
                                }

                                bookingProvider.submitBookingReceipt(_uploadedFileName!);
                                Navigator.pushNamed(context, AppRoutes.bookingConfirmed);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryNavy,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Icon(Icons.lock_outline_rounded, size: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
  bottomNavigationBar: BottomNavBar(
    currentIndex: 1,
    onTap: (index) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.mainNav,
        (route) => false,
        arguments: index,
      );
    },
  ),
);
}

  Widget _buildPaymentNumberRow(String provider, String number) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$provider number copied to clipboard!'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$provider - $number',
              style: const TextStyle(
                color: Color(0xFFCBD5E1),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.copy_rounded,
              color: Color(0xFF94A3B8),
              size: 13,
            ),
          ],
        ),
      ),
    );
  }
}

class _StylizedQrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0F172A)
      ..style = PaintingStyle.fill;

    const int grid = 9;
    final double cellW = size.width / grid;
    final double cellH = size.height / grid;

    // Corner Finder 1: Top-Left
    _drawFinder(canvas, 0, 0, cellW, cellH, paint);
    // Corner Finder 2: Top-Right
    _drawFinder(canvas, 6, 0, cellW, cellH, paint);
    // Corner Finder 3: Bottom-Left
    _drawFinder(canvas, 0, 6, cellW, cellH, paint);

    // Random QR data blocks
    final dataCells = [
      const Point(4, 0),
      const Point(4, 2),
      const Point(1, 4),
      const Point(3, 4),
      const Point(4, 4),
      const Point(5, 4),
      const Point(7, 4),
      const Point(4, 6),
      const Point(6, 6),
      const Point(7, 7),
      const Point(8, 7),
      const Point(5, 8),
      const Point(7, 8),
    ];

    for (final p in dataCells) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(p.x * cellW + 1, p.y * cellH + 1, cellW - 2, cellH - 2),
          const Radius.circular(2),
        ),
        paint,
      );
    }
  }

  void _drawFinder(Canvas canvas, int x, int y, double cellW, double cellH, Paint paint) {
    final outerRect = Rect.fromLTWH(x * cellW, y * cellH, cellW * 3, cellH * 3);
    final borderPaint = Paint()
      ..color = const Color(0xFF0F172A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = cellW * 0.7;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        outerRect.deflate(cellW * 0.35),
        const Radius.circular(4),
      ),
      borderPaint,
    );

    final innerRect = Rect.fromLTWH(
      (x + 1) * cellW + cellW * 0.15,
      (y + 1) * cellH + cellH * 0.15,
      cellW * 0.7,
      cellH * 0.7,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(innerRect, const Radius.circular(2)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  _DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(14),
    ));

    final metrics = path.computeMetrics().first;
    double distance = 0.0;
    while (distance < metrics.length) {
      final len = distance + gap > metrics.length ? metrics.length - distance : gap;
      final extract = metrics.extractPath(distance, distance + len);
      canvas.drawPath(extract, paint);
      distance += gap * 2;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Point {
  final int x;
  final int y;
  const Point(this.x, this.y);
}
