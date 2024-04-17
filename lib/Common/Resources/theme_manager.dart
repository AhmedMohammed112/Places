import 'package:flutter/material.dart';
import 'package:my_places/Common/Resources/style_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'values_manager.dart';

ThemeData getThemeData() {
  return ThemeData(
    primarySwatch: Colors.grey,
    scaffoldBackgroundColor: ColorManager.white,
    //main color
    primaryColor: ColorManager.darkGrey,
    primaryColorLight: ColorManager.lightPurple,
    primaryColorDark: ColorManager.newPrimary,
    disabledColor: ColorManager.lightGrey,



    //card view theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSizes.s4,
    ),

    //Appbar theme
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.white,
      elevation: AppSizes.s0,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: ColorManager.black,
      ),
      shadowColor: ColorManager.lightPurple,
      titleTextStyle: regularText(
        fontSize: AppSizes.s16,
        color: ColorManager.black,
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.s16),
          topRight: Radius.circular(AppSizes.s16),
        ),
      ),
    ),


    //Button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      buttonColor: ColorManager.primary,
      disabledColor: ColorManager.lightGrey,
      splashColor: ColorManager.lightPrimary,
    ),

    tabBarTheme: TabBarTheme(
      labelColor: ColorManager.white,
      labelStyle: regularText(
        fontSize: FontSizes.s16,
        color: ColorManager.white,
      ),
      unselectedLabelColor: ColorManager.lightGrey,
      unselectedLabelStyle: regularText(
        fontSize: FontSizes.s16,
        color: ColorManager.black,
      ),
      indicatorColor: ColorManager.lightGrey,
      indicator: const BoxDecoration(

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.s8),
          topRight: Radius.circular(AppSizes.s8),
        ),

      ),
    ),



    //Elevated Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.newPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s12),
        ),
        elevation: AppSizes.s12,
        shadowColor: ColorManager.newPrimary,
        textStyle: regularText(
          fontSize: FontSizes.s17,
          color: ColorManager.white,
        ),
      ),
    ),

    iconTheme: const IconThemeData(
      color: ColorManager.newPrimary,
    ),

    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all(ColorManager.newPrimary),
      ),
    ),


    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(ColorManager.white),
      checkColor: MaterialStateProperty.all(ColorManager.newPrimary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.s4),
       side: const BorderSide(
         color: ColorManager.newPrimary,
         width: AppSizes.s2,
       ),
      ),
    ),

    listTileTheme: const ListTileThemeData(
      iconColor: ColorManager.newPrimary,
      leadingAndTrailingTextStyle: TextStyle(color: ColorManager.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.s16),
        ),
      ),
    ),


    dialogTheme: const DialogTheme(
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.s8),
        ),
      ),
    ),



    //Text theme
    textTheme: TextTheme(
        displayLarge: semiBoldText(
          fontSize: FontSizes.s20,
          color: ColorManager.newPrimary,
        ),
        headlineMedium: regularText(
          fontSize: FontSizes.s14,
          color: ColorManager.darkGrey,
        ),
        titleSmall: mediumText(
          fontSize: FontSizes.s14,
          color: ColorManager.newPrimary,
        ),
        labelLarge: regularText(
          color: ColorManager.newPrimary,
        ),
        bodyLarge: regularText(
          color: ColorManager.newPrimary,
        ),
        labelSmall:
            boldText(color: ColorManager.grey, fontSize: AppSizes.s12)),

    //Input theme Text Form Field
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p16,),
      iconColor: ColorManager.black,
      prefixIconColor: ColorManager.newPrimary,
      suffixIconColor: ColorManager.newPrimary,


      // change text input color
      suffixStyle: regularText(
        color: ColorManager.newPrimary,
        fontSize: FontSizes.s20,
      ),

      //Label Text Style
      labelStyle: regularText(
        color: ColorManager.newPrimary,
        fontSize: FontSizes.s20,
      ),


      //Hint Text Style
      hintStyle: mediumText(
        color: ColorManager.newPrimary,
        fontSize: FontSizes.s14,
      ),

      //Error Text Style
      errorStyle: regularText(
        color: ColorManager.error,
        fontSize: FontSizes.s12,
      ),

      // input color
      helperStyle: regularText(
        color: ColorManager.newPrimary,
        fontSize: FontSizes.s14,
      ),


      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s16),
        borderSide: const BorderSide(
          color: ColorManager.newPrimary,
          width: AppSizes.s1,
        ),
      ),

      //Enabled Border Style
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s16),
        borderSide: const BorderSide(
          color: ColorManager.newPrimary,
          width: AppSizes.s1,
        ),
      ),

      //Disabled Border Style
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s16),
        borderSide: const BorderSide(
          color: ColorManager.newPrimary,
          width: AppSizes.s1,
        ),
      ),


      //Error Border Style
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s16),
        borderSide: const BorderSide(
          color: ColorManager.error,
          width: AppSizes.s1,
        ),
      ),

      //Focused Error Border Style
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s16),
        borderSide: const BorderSide(
          color: ColorManager.newPrimary,
          width: AppSizes.s1,
        ),
      ),
    ),
  );
}


ThemeData getDarkThemeData() {
  return ThemeData(
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: ColorManager.indigo,
    //main color
    primaryColor: ColorManager.newPrimary,
    primaryColorLight: ColorManager.newPrimary,
    primaryColorDark: ColorManager.newPrimary,
    disabledColor: ColorManager.lightGrey,



    //card view theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSizes.s4,
    ),

    //Appbar theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.indigo.shade900,
      elevation: AppSizes.s0,
      centerTitle: true,
      shadowColor: ColorManager.lightPurple,
      titleTextStyle: regularText(
        fontSize: AppSizes.s16,
        color: ColorManager.white,
      ),
    ),

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ColorManager.black.withAlpha(120),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.s16),
          topRight: Radius.circular(AppSizes.s16),
        ),
      ),
    ),






    dialogTheme: const DialogTheme(
      backgroundColor: ColorManager.newPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.s8),
        ),
      ),
    ),

    //Button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      buttonColor: ColorManager.primary,
      disabledColor: ColorManager.lightGrey,
      splashColor: ColorManager.lightPrimary,
    ),

    //Elevated Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.newPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s12),
        ),
        elevation: AppSizes.s12,
        shadowColor: ColorManager.newPrimary,
        textStyle: regularText(
          fontSize: FontSizes.s17,
          color: ColorManager.white,
        ),
      ),
    ),

    iconTheme: const IconThemeData(
      color: ColorManager.white,
    ),

    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all(ColorManager.white),
      ),
    ),


    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(ColorManager.white),
      checkColor: MaterialStateProperty.all(ColorManager.newPrimary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.s4),
        side: const BorderSide(
          color: ColorManager.newPrimary,
          width: AppSizes.s2,
        ),
      ),
    ),

    listTileTheme: const ListTileThemeData(
      iconColor: ColorManager.white,
      leadingAndTrailingTextStyle: TextStyle(color: ColorManager.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.s16),
        ),
      ),
    ),


    tabBarTheme: TabBarTheme(
      labelColor: ColorManager.white,
      labelStyle: regularText(
        fontSize: FontSizes.s16,
        color: ColorManager.white,
      ),
      unselectedLabelColor: ColorManager.lightGrey,
      unselectedLabelStyle: regularText(
        fontSize: FontSizes.s16,
        color: ColorManager.white,
      ),
      indicatorColor: ColorManager.newPrimary,
      indicator: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.s8),
          topRight: Radius.circular(AppSizes.s8),
        ),
        color: ColorManager.newPrimary,
      ),
    ),




    //Text theme
    textTheme: TextTheme(
        displayLarge: semiBoldText(
          fontSize: FontSizes.s16,
          color: ColorManager.white,
        ),
        headlineMedium: regularText(
          fontSize: FontSizes.s14,
          color: ColorManager.white,
        ),
        titleSmall: mediumText(
          fontSize: FontSizes.s14,
          color: ColorManager.white,
        ),
        labelMedium: regularText(
          fontSize: FontSizes.s14,
          color: ColorManager.white,
        ),
        labelLarge: regularText(
          color: ColorManager.grey,
        ),
        bodyLarge: regularText(
          color: ColorManager.darkGrey,
        ),
        labelSmall:
        boldText(color: ColorManager.primary, fontSize: AppSizes.s12)),

    //Input theme Text Form Field
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      iconColor: ColorManager.black,
      prefixIconColor: ColorManager.white,
      suffixIconColor: ColorManager.white,

      // change text input color
      suffixStyle: regularText(
        color: ColorManager.white,
        fontSize: FontSizes.s14,
      ),

      //Label Text Style
      labelStyle: regularText(
        color: ColorManager.white,
        fontSize: FontSizes.s18,
      ),


      //Hint Text Style
      hintStyle: mediumText(
        color: ColorManager.white,
        fontSize: FontSizes.s14,
      ),

      //Error Text Style
      errorStyle: regularText(
        color: ColorManager.error,
        fontSize: FontSizes.s12,
      ),

      // input color
      helperStyle: regularText(
        color: ColorManager.white,
        fontSize: FontSizes.s14,
      ),


      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s16),
        borderSide: const BorderSide(
          color: ColorManager.newPrimary,
          width: AppSizes.s1,
        ),
      ),

      //Enabled Border Style
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s16),
        borderSide: const BorderSide(
          color: ColorManager.newPrimary,
          width: AppSizes.s1,
        ),
      ),

      //Disabled Border Style
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s16),
        borderSide: const BorderSide(
          color: ColorManager.newPrimary,
          width: AppSizes.s1,
        ),
      ),


      //Error Border Style
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s16),
        borderSide: const BorderSide(
          color: ColorManager.error,
          width: AppSizes.s1,
        ),
      ),

      //Focused Error Border Style
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s16),
        borderSide: const BorderSide(
          color: ColorManager.newPrimary,
          width: AppSizes.s1,
        ),
      ),
    ),
  );
}
