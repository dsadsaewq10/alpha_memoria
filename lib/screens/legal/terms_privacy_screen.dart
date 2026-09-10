import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class TermsPrivacyScreen extends StatefulWidget {
  final int initialTab;

  const TermsPrivacyScreen({super.key, this.initialTab = 0});

  @override
  State<TermsPrivacyScreen> createState() => _TermsPrivacyScreenState();
}

class _TermsPrivacyScreenState extends State<TermsPrivacyScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Terms & Privacy', style: AppTextStyles.headingSmall),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Terms & Conditions'),
            Tab(text: 'Privacy Policy'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _LegalDocBody(sections: _termsSections),
          _LegalDocBody(sections: _privacySections),
        ],
      ),
    );
  }
}

class _LegalSection {
  final String title;
  final List<String> points;

  const _LegalSection(this.title, this.points);
}

class _LegalDocBody extends StatelessWidget {
  final List<_LegalSection> sections;

  const _LegalDocBody({required this.sections});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final section in sections) ...[
            Text(section.title, style: AppTextStyles.headingSmall),
            const SizedBox(height: 8),
            for (final point in section.points) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(point, style: AppTextStyles.bodyMedium),
              ),
            ],
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

const List<_LegalSection> _termsSections = [
  _LegalSection('1. Acceptance of Terms', [
    'By creating an account, making a booking, or otherwise using the Service, you ("the Client") agree to be bound by these Terms & Conditions. If you do not agree, please do not use the Service.',
  ]),
  _LegalSection('2. Booking & Reservations', [
    'A booking is confirmed only once the required deposit (see Section 3) has been received and a confirmation notification has been issued through the App.',
    'Event details (date, time, venue, package selected, add-ons) must be accurate at the time of booking. Any changes must be requested at least [X] days before the event date, subject to availability.',
    'The Service reserves the right to decline a booking due to scheduling conflicts, venue restrictions, or other operational reasons, with notice given as early as possible.',
  ]),
  _LegalSection('3. Payment & Deposits', [
    'A non-refundable reservation deposit of 50% is required to confirm a booking.',
    'The remaining balance is due 3 days before the event date, or on the event day itself, as specified in the booking summary.',
    'Accepted payment methods: GCash, bank transfer, credit/debit card via payment gateway.',
    'Prices are inclusive/exclusive of applicable taxes as indicated at checkout.',
  ]),
  _LegalSection('4. Cancellations & Rescheduling', [
    'Cancellations made 5 days or more before the event are eligible for a partial refund / credit toward a future booking, excluding the deposit.',
    'Cancellations made within 5 days of the event are non-refundable.',
    'Rescheduling is allowed once, free of charge, if requested at least 5 days before the original event date, subject to availability. Additional reschedules may incur a fee.',
    'The Service reserves the right to cancel or reschedule a booking due to force majeure (e.g., extreme weather, equipment failure, emergencies), in which case the Client will be offered a full refund or free rescheduling.',
  ]),
  _LegalSection('5. Client Responsibilities', [
    'The Client must provide a suitable space for the photo booth setup (space, power access, and reasonable weather protection for outdoor events) as specified in setup requirements shared prior to the event.',
    'The Client is responsible for ensuring event guests use the photo booth appropriately and safely.',
    'Any damage to equipment caused by guest misuse or negligence may be charged to the Client.',
  ]),
  _LegalSection('6. Service Provider Responsibilities', [
    'The Service will arrive and set up within the agreed time window and provide the booth for the contracted duration.',
    'Technical issues will be addressed promptly; if unresolved issues significantly reduce usable service time, the Client may be entitled to a partial refund or service credit.',
  ]),
  _LegalSection('7. Photos, Prints & Media Usage', [
    'Digital copies and/or prints from the event will be delivered per the selected package.',
    'Unless the Client opts out at booking, sample images from the event may be used by Alpha Memoria for portfolio, marketing, or social media purposes. Clients may request removal at any time.',
  ]),
  _LegalSection('8. Limitation of Liability', [
    'Alpha Memoria is not liable for indirect, incidental, or consequential damages arising from use of the Service, including delays or disruptions beyond reasonable control, except as required by Philippine law.',
  ]),
  _LegalSection('9. Governing Law', [
    'These Terms are governed by the laws of the Republic of the Philippines. Disputes shall first be addressed through good-faith negotiation before formal proceedings.',
  ]),
];

const List<_LegalSection> _privacySections = [
  _LegalSection('Overview', [
    'This Privacy Policy explains how Alpha Memoria collects, uses, stores, and protects personal data through the App, in accordance with the Data Privacy Act of 2012 (Republic Act No. 10173) and its Implementing Rules and Regulations.',
  ]),
  _LegalSection('1. Information We Collect', [
    'Account information: full name, email address, phone number, and (if applicable) profile photo.',
    'Booking information: event date, time, venue/address, package selected, add-ons, and special requests.',
    'Payment information: transaction reference and payment status (full card/bank details are processed directly by our third-party payment provider, e.g., PayMongo, and are not stored on our servers).',
    'Event media: photos/videos captured during the booth session, where applicable.',
    'Usage data: device type, app version, and general usage logs, collected automatically for troubleshooting and service improvement.',
  ]),
  _LegalSection('2. How We Use Your Information', [
    'Process and confirm bookings, payments, and rescheduling requests.',
    'Communicate booking confirmations, reminders, and updates.',
    'Deliver event photos/videos to the Client.',
    'Improve the App\'s features, reliability, and user experience.',
    'With consent, use sample event photos for portfolio/marketing purposes.',
    'Comply with legal and regulatory obligations.',
  ]),
  _LegalSection('3. Legal Basis for Processing', [
    'We process personal data based on: (a) consent given at account creation and booking, (b) performance of the booking contract, and (c) legitimate business interests such as service improvement and fraud prevention.',
  ]),
  _LegalSection('4. Data Sharing', [
    'We do not sell personal data. We may share data with:',
    'Payment processors (e.g., PayMongo) to complete transactions.',
    'Cloud service providers (e.g., Firebase/Google Cloud) for secure data storage and hosting.',
    'Event staff/photographers assigned to fulfill a booking, limited to information necessary for the event.',
    'Legal authorities, only when required by law or a valid legal request.',
  ]),
  _LegalSection('5. Data Storage & Security', [
    'Data is stored on secure cloud infrastructure (Firebase Firestore and Storage) with access restricted via role-based access control.',
    'Passwords are stored using industry-standard hashing; payment details are never stored in plaintext.',
  ]),
  _LegalSection('6. Your Rights', [
    'Under the Data Privacy Act, you have the right to be informed about how your data is processed, access your data, correct inaccurate data, object to or withdraw consent (e.g., marketing use of photos), request deletion subject to legal retention requirements, and file a complaint with the National Privacy Commission (NPC).',
    'To exercise these rights, contact us at [privacy email address].',
  ]),
  _LegalSection('7. Children\'s Data', [
    'Our Service is not directed at children under 18. If a booking involves minors (e.g., as event guests), only minimal information necessary for event coordination is collected, and parental/guardian consent is assumed to have been secured by the booking Client.',
  ]),
  _LegalSection('8. Cookies & Tracking (Web App)', [
    'The web app may use cookies or similar technologies for session management and analytics. You can control cookie preferences through your browser settings.',
  ]),
];