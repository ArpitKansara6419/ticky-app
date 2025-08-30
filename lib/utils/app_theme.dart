import 'package:ticky/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      surfaceTint: primaryColor,
      onPrimary: Color(4294967295),
      primaryContainer: Color(4291225599),
      onPrimaryContainer: Color(4278197805),
      secondary: Color(4278216828),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4289785087),
      onSecondaryContainer: Color(4278198055),
      tertiary: Color(4278216820),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4288606206),
      onTertiaryContainer: Color(4278198052),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294376190),
      onSurface: Color(4279770143),
      onSurfaceVariant: Color(4282468429),
      outline: Color(4285626494),
      outlineVariant: Color(4290889678),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086261),
      inversePrimary: Color(4287811317),
      primaryFixed: Color(4291225599),
      onPrimaryFixed: Color(4278197805),
      primaryFixedDim: Color(4287811317),
      onPrimaryFixedVariant: Color(4278209643),
      secondaryFixed: Color(4289785087),
      onSecondaryFixed: Color(4278198055),
      secondaryFixedDim: Color(4286960104),
      onSecondaryFixedVariant: Color(4278210142),
      tertiaryFixed: Color(4288606206),
      onTertiaryFixed: Color(4278198052),
      tertiaryFixedDim: Color(4286764001),
      onTertiaryFixedVariant: Color(4278210392),
      surfaceDim: Color(4292336351),
      surfaceBright: Color(4294376190),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293981432),
      surfaceContainer: Color(4293652211),
      surfaceContainerHigh: Color(4293257453),
      surfaceContainerHighest: Color(4292862951),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278208613),
      surfaceTint: primaryColor,
      onPrimary: Color(4294967295),
      primaryContainer: Color(4282153887),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278209113),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281040531),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278209107),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4280647564),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294376190),
      onSurface: Color(4279770143),
      onSurfaceVariant: Color(4282205257),
      outline: Color(4284047462),
      outlineVariant: Color(4285889665),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086261),
      inversePrimary: Color(4287811317),
      primaryFixed: Color(4282153887),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4280115844),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281040531),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4278216057),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4280647564),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278216305),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292336351),
      surfaceBright: Color(4294376190),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293981432),
      surfaceContainer: Color(4293652211),
      surfaceContainerHigh: Color(4293257453),
      surfaceContainerHighest: Color(4292862951),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278199607),
      surfaceTint: primaryColor,
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278208613),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278199855),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4278209113),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278200108),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4278209107),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294376190),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280165674),
      outline: Color(4282205257),
      outlineVariant: Color(4282205257),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281086261),
      inversePrimary: Color(4292538367),
      primaryFixed: Color(4278208613),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278202438),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4278209113),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4278202940),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4278209107),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278202937),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292336351),
      surfaceBright: Color(4294376190),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293981432),
      surfaceContainer: Color(4293652211),
      surfaceContainerHigh: Color(4293257453),
      surfaceContainerHighest: Color(4292862951),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4287811317),
      surfaceTint: Color(4287811317),
      onPrimary: Color(4278203467),
      primaryContainer: Color(4278209643),
      onPrimaryContainer: Color(4291225599),
      secondary: Color(4286960104),
      onSecondary: Color(4278203969),
      secondaryContainer: Color(4278210142),
      onSecondaryContainer: Color(4289785087),
      tertiary: Color(4286764001),
      onTertiary: Color(4278203965),
      tertiaryContainer: Color(4278210392),
      onTertiaryContainer: Color(4288606206),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279178263),
      onSurface: Color(4292862951),
      onSurfaceVariant: Color(4290889678),
      outline: Color(4287336856),
      outlineVariant: Color(4282468429),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292862951),
      inversePrimary: primaryColor,
      primaryFixed: Color(4291225599),
      onPrimaryFixed: Color(4278197805),
      primaryFixedDim: Color(4287811317),
      onPrimaryFixedVariant: Color(4278209643),
      secondaryFixed: Color(4289785087),
      onSecondaryFixed: Color(4278198055),
      secondaryFixedDim: Color(4286960104),
      onSecondaryFixedVariant: Color(4278210142),
      tertiaryFixed: Color(4288606206),
      onTertiaryFixed: Color(4278198052),
      tertiaryFixedDim: Color(4286764001),
      onTertiaryFixedVariant: Color(4278210392),
      surfaceDim: Color(4279178263),
      surfaceBright: Color(4281678397),
      surfaceContainerLowest: Color(4278849298),
      surfaceContainerLow: Color(4279770143),
      surfaceContainer: Color(4280033316),
      surfaceContainerHigh: Color(4280691502),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4288074489),
      surfaceTint: Color(4287811317),
      onPrimary: Color(4278196518),
      primaryContainer: Color(4284192700),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4287289069),
      onSecondary: Color(4278196512),
      secondaryContainer: Color(4283276208),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4287027173),
      onTertiary: Color(4278196766),
      tertiaryContainer: Color(4283014313),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279178263),
      onSurface: Color(4294507519),
      onSurfaceVariant: Color(4291152850),
      outline: Color(4288521386),
      outlineVariant: Color(4286416010),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292862951),
      inversePrimary: Color(4278209901),
      primaryFixed: Color(4291225599),
      onPrimaryFixed: Color(4278194974),
      primaryFixedDim: Color(4287811317),
      onPrimaryFixedVariant: Color(4278205011),
      secondaryFixed: Color(4289785087),
      onSecondaryFixed: Color(4278195225),
      secondaryFixedDim: Color(4286960104),
      onSecondaryFixedVariant: Color(4278205512),
      tertiaryFixed: Color(4288606206),
      onTertiaryFixed: Color(4278195223),
      tertiaryFixedDim: Color(4286764001),
      onTertiaryFixedVariant: Color(4278205508),
      surfaceDim: Color(4279178263),
      surfaceBright: Color(4281678397),
      surfaceContainerLowest: Color(4278849298),
      surfaceContainerLow: Color(4279770143),
      surfaceContainer: Color(4280033316),
      surfaceContainerHigh: Color(4280691502),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294507519),
      surfaceTint: Color(4287811317),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4288074489),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294311167),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4287289069),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294114815),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4287027173),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279178263),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294507519),
      outline: Color(4291152850),
      outlineVariant: Color(4291152850),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292862951),
      inversePrimary: Color(4278201666),
      primaryFixed: Color(4291816191),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4288074489),
      onPrimaryFixedVariant: Color(4278196518),
      secondaryFixed: Color(4290637823),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4287289069),
      onSecondaryFixedVariant: Color(4278196512),
      tertiaryFixed: Color(4289524479),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4287027173),
      onTertiaryFixedVariant: Color(4278196766),
      surfaceDim: Color(4279178263),
      surfaceBright: Color(4281678397),
      surfaceContainerLowest: Color(4278849298),
      surfaceContainerLow: Color(4279770143),
      surfaceContainer: Color(4280033316),
      surfaceContainerHigh: Color(4280691502),
      surfaceContainerHighest: Color(4281414969),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
    );
  }

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
