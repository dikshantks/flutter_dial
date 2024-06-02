import 'dart:ui';

extension SizeX on Size {
  Offset get centeroffset => Offset(width / 2, height / 2);
}

extension ListExtenstion<T> on List<T> {
  List<T> addbetween(T seperator) {
    if (length <= 1) {
      return toList();
    }

    final newitem = <T>[];
    for (var i = 0; i < length - 1; i++) {
      newitem.add(this[i]);
      newitem.add(seperator);
    }
    newitem.add(this[length - 1]);

    return newitem;
  }
}
