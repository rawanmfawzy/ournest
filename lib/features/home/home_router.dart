import 'package:flutter/material.dart';
import 'package:ournest/core/cubit/token_storage_helper.dart';
import 'package:ournest/core/widgets/buttom_navigation_bar_mother.dart';
import 'package:ournest/core/widgets/buttom_navigation_bar_baby.dart';
import 'package:ournest/core/widgets/buttom_navigation_bar_father.dart';
import 'package:ournest/features/home/services/family_service.dart';
import 'dart:convert';
import 'package:ournest/features/auth/views/login_page.dart';
import 'package:ournest/features/link/father/views/father_link.dart';
class HomeRouter extends StatefulWidget {
  const HomeRouter({super.key});

  @override
  State<HomeRouter> createState() => _HomeRouterState();
}

class _HomeRouterState extends State<HomeRouter> {
  @override
  void initState() {
    super.initState();
    _route();
  }

  Future<void> _route() async {
    try {
      final role = await TokenStorage.getRole();
      final token = await TokenStorage.getToken();
      String? jwtRole;

      // Decode JWT as a robust fallback for the role
      if (token != null) {
        final parts = token.split('.');
        if (parts.length == 3) {
          final payloadStr = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
          final payload = jsonDecode(payloadStr);
          jwtRole = payload['role'] ?? payload['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
        }
      }

      final dashboardData = await FamilyService.getDashboard();
      final isPregnant = dashboardData['isPregnant'] ?? false;
      final isLinked = dashboardData['isLinked'] ?? false;

      // Extract current week if available and save it for the Home Screen
      int currentWeek = 0;
      if (dashboardData['currentWeek'] != null) {
        currentWeek = dashboardData['currentWeek'];
      } else if (dashboardData['babyData'] != null && dashboardData['babyData']['pregnancy'] != null) {
        currentWeek = dashboardData['babyData']['pregnancy']['currentWeek'] ?? 0;
      }
      await TokenStorage.saveCurrentWeek(currentWeek);

      if (dashboardData['babyData'] != null && dashboardData['babyData']['babies'] != null) {
        final babies = dashboardData['babyData']['babies'] as List;
        if (babies.isNotEmpty) {
          await TokenStorage.saveBabyBirthDate(babies[0]['dateOfBirth']);
        }
      }
      
      if (!mounted) return;
      
      final currentRole = role?.trim() ?? jwtRole?.trim() ?? "Mother"; // fallback
      
      if (currentRole.toLowerCase() == "father") {
        if (!isLinked) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LinkFather()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ButtomNavigationBarFather()),
          );
        }
      } else {
        if (isPregnant) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ButtomNavigationBarmother()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ButtomNavigationBarBaby()),
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(color: Color(0xFFB34962)),
      ),
    );
  }
}
