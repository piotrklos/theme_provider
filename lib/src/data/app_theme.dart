import 'package:flutter/material.dart';

///  Main App theme object.
///
/// Usage:
/// ```dart
///  AppTheme<ColorClass>(
///     data: ThemeData(),
///     options: ColorClass(),
///   ),
/// ```
@immutable
class AppTheme<T> {
  /// [ThemeData] associated with the [AppTheme]
  final ThemeData data;

  /// Passed options object. Use this object to pass
  /// additional data that should be associated with the theme.
  ///
  /// eg: If font color on a specific button changes create a class
  /// to encapsulate the value.
  /// ```dart
  /// class ThemeOptions{
  ///   final Color specificButtonColor;
  ///   ThemeOptions(this.specificButtonColor);
  /// }
  /// ```
  ///
  /// Then provide the options with the theme.
  /// ```dart
  /// themes: [
  ///   AppTheme<ThemeOptions>(
  ///     data: ThemeData.light(),
  ///     options: ThemeOptions(Colors.blue),
  ///   ),
  ///   AppTheme<ThemeOptions>(
  ///     data: ThemeData.dark(),
  ///     options: ThemeOptions(Colors.red),
  ///   ),
  /// ]
  /// ```
  ///
  /// Then the option can be retrieved as
  /// `AppThemeOptions.of<ThemeOptions>(context).specificButtonColor`.
  final T options;

  /// Unique ID which defines the theme.
  /// Don't use conflicting strings.
  ///
  /// This has to be a lowercase string seperated by underscores. (can contain numbers)
  ///   * theme_1
  ///   * my_theme
  ///   * dark_extended_theme
  /// 
  /// Don't use very lengthy strings.
  /// Instead use [description] as the field to add description.
  final String id;

  /// Short ddescription which describes the theme. Must be less than 30 characters.
  final String description;

  /// Constructs a [AppTheme].
  /// [data] is required.
  ///
  /// [id] is required and it has to be unique. 
  /// Use _ sereated lowercase strings.
  /// Id cannot have whitespaces.
  ///
  /// [options] can ba any object. Use it to pass
  ///
  /// [description] is optional. If not given it takes default to as 'Light Theme' or 'Dark Theme'.
  AppTheme({
    @required this.id,
    @required ThemeData data,
    String description,
    this.options,
  })  : this.data = data,
        this.description = description ??
            (data.brightness == Brightness.light
                ? "Light Theme"
                : "Dark Theme") {
    assert(
        description.length < 30, "Theme description too long ($id)");
    assert(id.isNotEmpty, "Id cannot be empty");
    assert(id.toLowerCase() == id, "Id has to be a lowercase string");
    assert(!id.contains(" "), "Id cannot contain whitespaces. (Use _ for spaces)");
  }

  /// Default light theme
  factory AppTheme.light({String id}) {
    return AppTheme(
      data: ThemeData.light(),
      id: id ?? "default_light_theme",
      description: "Android Default Light Theme",
    );
  }

  /// Default dark theme
  factory AppTheme.dark({String id}) {
    return AppTheme(
      data: ThemeData.dark(),
      id: id ?? "default_dark_theme",
      description: "Android Default Dark Theme",
    );
  }

  /// Additional purple theme constrcutor
  factory AppTheme.purple({String id}) {
    return AppTheme(
        data: ThemeData.light().copyWith(
          primaryColor: Colors.purple,
          accentColor: Colors.pink,
        ),
        id: id);
  }

  /// Creates a copy of this [AppTheme] but with the given fields replaced with the new values.
  /// Id will be replaced by the given [id].
  AppTheme copyWith({
    @required String id,
    String description,
    ThemeData data,
    T options,
  }) {
    return AppTheme(
      id: id,
      description: description ?? this.description,
      data: data ?? this.data,
      options: options ?? this.options,
    );
  }
}