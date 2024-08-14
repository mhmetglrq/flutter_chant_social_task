extension StringExtension on String {
  String get capitalize => "${this[0].toUpperCase()}${substring(1)}";
  String get capitalizeFirstofEach =>
      split(' ').map((str) => str.capitalize).join(' ');
  String get capitalizeFirstofEachWord => splitMapJoin(' ',
      onMatch: (m) => m.group(0)!.capitalize, onNonMatch: (m) => m);

  String get toCamelCase => split(' ').map((str) => str.capitalize).join('');
  String get toCamelCaseFirstofEach =>
      split(' ').map((str) => str.capitalize).join('');
  String get toCamelCaseFirstofEachWord => splitMapJoin(' ',
      onMatch: (m) => m.group(0)!.capitalize, onNonMatch: (m) => m);

  String get toTitleCase => split(' ').map((str) => str.capitalize).join(' ');
  String get toTitleCaseFirstofEach =>
      split(' ').map((str) => str.capitalize).join(' ');
  String get toTitleCaseFirstofEachWord => splitMapJoin(' ',
      onMatch: (m) => m.group(0)!.capitalize, onNonMatch: (m) => m);

  String get toSnakeCase => toLowerCase().split(' ').join('_');
  String get toSnakeCaseFirstofEach => toLowerCase().split(' ').join('_');
  String get toSnakeCaseFirstofEachWord => toLowerCase().split(' ').join('_');

  String get toKebabCase => toLowerCase().split(' ').join('-');
  String get toKebabCaseFirstofEach => toLowerCase().split(' ').join('-');
  String get toKebabCaseFirstofEachWord => toLowerCase().split(' ').join('-');

  String get toConstantCase => toUpperCase().split(' ').join('_');
  String get toConstantCaseFirstofEach => toUpperCase().split(' ').join('_');
  String get toConstantCaseFirstofEachWord =>
      toUpperCase().split(' ').join('_');
}
