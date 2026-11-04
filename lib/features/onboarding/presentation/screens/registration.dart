import 'package:flutter/material.dart';

import 'package:p1/core/tokens/tokens.dart';
import 'package:p1/core/router/page_transitions.dart';
import 'package:p1/features/home/presentation/screens/home.dart';

// Unified Step 1 (Screens level)
import 'account.dart';

// Creative Track Steps (Subfolder: creative/)
import 'creative/role.dart';
import 'creative/location.dart';
import 'creative/personal_details.dart';
import 'creative/verify.dart';

// Business Track Steps (Subfolder: business/)
import 'business/biz_industry.dart';
import 'business/biz_location.dart';
import 'business/biz_details.dart';
import 'business/biz_verify.dart';

// Header & Progress Component
import '../widgets/registration_header.dart';

class RegistrationPage extends StatefulWidget {
  final String initialUserType; // "creative" | "business"

  const RegistrationPage({
    super.key,
    this.initialUserType = "creative",
  });

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  int currentStep = 0;
  late String selectedUserType; // "creative" | "business"
  final Map<String, dynamic> registrationData = {};

  @override
  void initState() {
    super.initState();
    selectedUserType = widget.initialUserType;
  }

  List<String> get stepNames {
    if (selectedUserType == "creative") {
      return ["Account", "Role", "Location & Rates", "Personal Details", "Verify"];
    } else {
      return ["Account", "Brand & Industry", "Operations & Budget", "Details", "Verify"];
    }
  }

  Map<String, dynamic> get currentHeaderInfo {
    if (selectedUserType == "creative") {
      switch (currentStep) {
        case 0:
          return {
            'tag': 'CREATIVE PROFESSIONAL',
            'title': 'Join the community',
            'sub': 'Get discovered by top brands & find collaborators',
          };
        case 1:
          return {
            'tag': 'CREATIVE ROLE',
            'title': 'Tell us about your work',
            'sub': 'Help brands understand your expertise',
          };
        case 2:
          return {
            'tag': 'PREFERENCES',
            'title': 'Location & Budget',
            'sub': 'Help brands understand your travel preferences & rates',
          };
        case 3:
          return {
            'tag': 'PERSONAL DETAILS',
            'title': 'Tell us about yourself',
            'sub': 'Collaborators want to know who you are',
          };
        case 4:
          return {
            'tag': 'IDENTITY VERIFICATION',
            'title': 'Verify your identity',
            'sub': 'Builds trust with brands & collaborators',
            'badge': 'Secure & Safe',
            'badgeIcon': Icons.shield_outlined,
            'showLater': true,
          };
        default:
          return {'tag': '', 'title': '', 'sub': ''};
      }
    } else {
      switch (currentStep) {
        case 0:
          return {
            'tag': 'INDUSTRY ONBOARDING',
            'title': 'Join as a Brand & Business',
            'sub': 'Hire top creative talent for your projects',
          };
        case 1:
          return {
            'tag': 'BRAND & INDUSTRY',
            'title': 'Tell us about your business',
            'sub': 'Help creative professionals understand your industry',
          };
        case 2:
          return {
            'tag': 'BUSINESS PREFERENCES',
            'title': 'Location & Budget',
            'sub': 'Set operating regions & project budget ranges',
          };
        case 3:
          return {
            'tag': 'CONTACT DETAILS',
            'title': 'Personal & Contact Details',
            'sub': 'Tell collaborators who to get in touch with',
          };
        case 4:
          return {
            'tag': 'BUSINESS VERIFICATION',
            'title': 'Verify your business',
            'sub': 'Builds trust & verifies official business identity',
            'badge': 'GST Verified',
            'badgeIcon': Icons.verified_user_outlined,
            'showLater': true,
          };
        default:
          return {'tag': '', 'title': '', 'sub': ''};
      }
    }
  }

  void _nextStep() {
    if (currentStep < stepNames.length - 1) {
      setState(() => currentStep++);
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  void _navigateToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransitions.fade(const HomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final header = currentHeaderInfo;
    final bool isBiz = selectedUserType == "business";

    Widget activeStepWidget;

    // ── Step 0: Unified Account Form
    if (currentStep == 0) {
      activeStepWidget = AccountStep(
        initialRole: selectedUserType,
        onRoleChanged: (role) => setState(() => selectedUserType = role),
        onAccountCreated: _nextStep,
        onSignInTap: () => Navigator.pop(context),
      );
    } else if (!isBiz) {
      // ── Steps 1-4: Creative Track
      switch (currentStep) {
        case 1:
          activeStepWidget = RoleStep(
            onSaveAndContinue: (data) {
              registrationData.addAll(data);
              _nextStep();
            },
          );
          break;
        case 2:
          activeStepWidget = LocationStep(
            onSaveAndContinue: (data) {
              registrationData.addAll(data);
              _nextStep();
            },
          );
          break;
        case 3:
          activeStepWidget = PersonalDetailStep(
            isModel: registrationData['primaryRole'] == 'Model',
            onProceedToVerify: (data) {
              registrationData.addAll(data);
              _nextStep();
            },
          );
          break;
        case 4:
          activeStepWidget = VerifyStep(
            onFinishOnboarding: _navigateToHome,
          );
          break;
        default:
          activeStepWidget = const SizedBox.shrink();
      }
    } else {
      // ── Steps 1-4: Business Track
      switch (currentStep) {
        case 1:
          activeStepWidget = BizIndustryStep(
            onSaveAndContinue: (data) {
              registrationData.addAll(data);
              _nextStep();
            },
          );
          break;
        case 2:
          activeStepWidget = BizLocationStep(
            onSaveAndContinue: (data) {
              registrationData.addAll(data);
              _nextStep();
            },
          );
          break;
        case 3:
          activeStepWidget = BizDetailStep(
            onProceedToVerify: (data) {
              registrationData.addAll(data);
              _nextStep();
            },
          );
          break;
        case 4:
          activeStepWidget = BizVerifyStep(
            onFinishOnboarding: _navigateToHome,
          );
          break;
        default:
          activeStepWidget = const SizedBox.shrink();
      }
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Column(
        children: [
          RegistrationHeader(
            currentStep: currentStep,
            totalSteps: stepNames.length,
            stepNames: stepNames,
            isBusiness: isBiz, // Controls bluish (#1C3A5E -> #2A5FAA) vs green gradient
            categoryTag: header['tag'] ?? '',
            title: header['title'] ?? '',
            subtitle: header['sub'] ?? '',
            badgeText: header['badge'],
            badgeIcon: header['badgeIcon'],
            showDoThisLater: header['showLater'] ?? false,
            onBackTap: _previousStep,
            onDoThisLaterTap: _nextStep,
          ),
          Expanded(
            child: activeStepWidget,
          ),
        ],
      ),
    );
  }
}