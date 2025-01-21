import 'package:flutter/material.dart';

class Temas {
  static final ThemeData temaGeral =ThemeData(
    primaryColor: const Color.fromRGBO(7, 176, 237, 1),
    scaffoldBackgroundColor: Color.fromRGBO(223, 234, 243, 1),
    fontFamily: 'Inter', 
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromRGBO(7, 176, 237, 1),
      titleTextStyle: TextStyle(
        fontSize: 100,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      )
    ),
    textTheme: const TextTheme(

    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor:  Color.fromRGBO(7, 176, 237, 1), // Cor de fundo da barra de navegação inferior
          selectedItemColor: Colors.white, // Cor do item selecionado
          unselectedItemColor: Colors.white70, // Cor dos itens não selecionados
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold), // Estilo do rótulo selecionado
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal), // Estilo do rótulo não selecionado
          elevation: 10.0, // Elevação da barra de navegação inferior
        ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          backgroundColor:  const Color.fromRGBO(7, 176, 237, 1),
          foregroundColor: Colors.white,
          minimumSize: Size(100, 40),
          maximumSize: Size(150, 40),
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          )
        ),
      ),
  );
  static final ThemeData botoes = temaGeral.copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          backgroundColor:  const Color.fromRGBO(7, 176, 237, 1),
          foregroundColor: Colors.white,
          minimumSize: Size(350, 60),
          maximumSize: Size(350, 60),
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          )
        ),
      ),
  );
  static final ThemeData formsI = temaGeral.copyWith(
    
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.w900,
        color: Color.fromRGBO(7, 176, 237, 1),
        letterSpacing: 5.0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color.fromRGBO(180, 222, 242, 1.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color:  const Color.fromRGBO(180, 222, 242, 1.0),
        )
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Color.fromRGBO(7, 176, 237, 1)
        )
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.red
        )
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.red
        )
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 3.0,
      ),
      hintStyle: TextStyle(
        fontSize: 20.0,
        color: Colors.white
      ),
      labelStyle: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    )
  );
  static final ThemeData formsII = temaGeral.copyWith(
    inputDecorationTheme: InputDecorationTheme(

    )
  );

}
