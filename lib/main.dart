import 'package:e_sim_app/second_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eSim App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'HelveticaNeue',
      ),
      routes: {
        '2Page': (context) => const SecondPage(),
      },
      home: const ESimHomePage(),
    );
  }
}

class ESimHomePage extends StatelessWidget {
  const ESimHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWideScreen = width > 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Adaptive background
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                  'assets/background_left.png',
                  width: isWideScreen ? math.min(width * 0.3, 300) : 150,
                  fit: BoxFit.contain,
                ),
              ),
            
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/background_right.png',
                width: isWideScreen ? math.min(width * 0.45, 450) :200,
                fit: BoxFit.contain,
              ),
            ),
          

          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/logo.png',
                            height: 40,
                          ),
                          const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage('assets/avatar.png'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Одна eSim для всех поездок',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'HelveticaNeue',
                          height: 1.1,
                          letterSpacing: -0.28
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildFeatureItem(
                        icon: Icons.public,
                        text: 'Одна карта для всех направлений',
                      ),
                      _buildFeatureItem(
                        icon: Icons.check_circle_outline,
                        text: 'Оплата только за потраченное',
                      ),
                      _buildFeatureItem(
                        icon: Icons.all_inclusive,
                        text: 'Без срока действия',
                      ),
                      _buildFeatureItem(
                        icon: Icons.sim_card,
                        text: 'Пакеты от 1\$',
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '2Page');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Список стран и тарифы',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: Text(
                          'Ваш баланс: 1\$',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '2Page');
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3761DF), Color(0xFF25ABFF)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              'Активировать карту',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'HelveticaNeue',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
        ],
      ),
    );
  }
}