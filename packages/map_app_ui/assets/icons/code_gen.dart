import 'dart:io';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

// Short name of our package
const shortName = 'UI';
const lightColor = 'black';
const darkColor = 'white';

void main() async {
  // Get a list of all .svg file names in the current directory.
  List<String> fileNames = Directory('.').listSync().where((file) => file.path.endsWith('.svg')).map((file) => file.path).toList();

  // Create a new file to write the SVG file names to.
  File icons = File('icons.txt');
  File iconsLight = File('iconsLight.txt');
  File iconsDark = File('iconsDark.txt');

  String iconsSVG(String name) {
    return 'SvgPicture $name({double? size, Color? color}) { '
        'return Assets.icons.$name.svg( '
        'color: color, height: size ?? 14, width: size ?? 14,); }\n';
  }

  String iconsSVGLight(String name) {
    return '@override \n '
        'SvgPicture $name({double? size, Color? color}) { '
        'return super.$name( '
        'color: color ?? ${shortName}Colors.$lightColor, '
        'size: size ?? 14,);}';
  }

  String iconsSVGDark(String name) {
    return '@override \n '
        'SvgPicture $name({double? size, Color? color}) { '
        'return super.$name( '
        'color: color ?? ${shortName}Colors.$darkColor, '
        'size: size ?? 14,);}';
  }

  String snakeToCamel(String text) {
    // check for empty string
    if (text.isEmpty) return text;

    // regexp to match the "_a" or "_A"
    final exp = RegExp('_[a-zA-Z0-9]');
    text = text.replaceAllMapped(exp, (m) => '${m.group(0)?[1].toUpperCase()}');

    // minuscule first letter
    return "${text[0].toLowerCase()}${text.substring(1)}";
  }

  StringBuffer bufferIcons = StringBuffer();
  StringBuffer bufferIconsLight = StringBuffer();
  StringBuffer bufferIconsDark = StringBuffer();

  for (String path in fileNames) {
    var fileName = path.substring(2);
    fileName = fileName.split(".")[0];
    var name = snakeToCamel(fileName);

    bufferIcons.writeln(
      iconsSVG(name),
    );
    bufferIconsLight.writeln(
      iconsSVGLight(name),
    );
    bufferIconsDark.writeln(
      iconsSVGDark(name),
    );
  }

  icons.writeAsStringSync(bufferIcons.toString());
  iconsLight.writeAsStringSync(bufferIconsLight.toString());
  iconsDark.writeAsStringSync(bufferIconsDark.toString());
}



// to run go to the current directory and dart `function.dart`