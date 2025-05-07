import 'package:e_sim_app/second_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'eSim App',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'HelveticaNeue',
      ),
      routes: {
        '2Page': (context) => SecondPage(),
      },
      home: ESimHomePage(),
    );
  }
}

class ESimHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi), 
              child: Image.asset(
                'assets/background.png',
                width: MediaQuery.of(context).size.width * 0.5, 
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/background.png',
              width: MediaQuery.of(context).size.width * 0.7,
              fit: BoxFit.contain,
            ),
          ),
          // основа
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Логотип 
                      Image.asset(
                        'assets/logo.png',
                        height: 40.0, 
                      ),
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage('assets/avatar.png'),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'Одна eSim для всех поездок',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'HelveticaNeue',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _buildFeatureItem(icon: Icons.public, text: 'Одна карта для всех направлений'),
                  _buildFeatureItem(icon: Icons.check_circle_outline, text: 'Оплата только за потраченное'),
                  _buildFeatureItem(icon: Icons.all_inclusive, text: 'Без срока действия'),
                  _buildFeatureItem(icon: Icons.sim_card, text: 'Пакеты от 1\$'),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.white, // цвет текста и иконки на кнопке
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), 
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Список стран и тарифы',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Icon(
                          Icons.arrow_forward,
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),

                  Center(
                    child: Text(
                      'Ваш баланс: 1\$',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                        fontFamily: 'HelveticaNeue',
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '2Page');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      margin: EdgeInsets.only(bottom: 20.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.lightBlueAccent, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(
                        child: Text(
                          'Активировать карту',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'HelveticaNeue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20.0,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'HelveticaNeue',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
