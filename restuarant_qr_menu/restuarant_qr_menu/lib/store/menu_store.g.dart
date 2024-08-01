// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MenuStore on MenuStoreBase, Store {
  final _$selectedCategoryDataAtom =
      Atom(name: 'MenuStoreBase.selectedCategoryData');

  @override
  CategoryModel? get selectedCategoryData {
    _$selectedCategoryDataAtom.reportRead();
    return super.selectedCategoryData;
  }

  @override
  set selectedCategoryData(CategoryModel? value) {
    _$selectedCategoryDataAtom.reportWrite(value, super.selectedCategoryData,
        () {
      super.selectedCategoryData = value;
    });
  }

  final _$MenuStoreBaseActionController =
      ActionController(name: 'MenuStoreBase');

  @override
  void setSelectedCategoryData(CategoryModel? image) {
    final _$actionInfo = _$MenuStoreBaseActionController.startAction(
        name: 'MenuStoreBase.setSelectedCategoryData');
    try {
      return super.setSelectedCategoryData(image);
    } finally {
      _$MenuStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCategoryData: ${selectedCategoryData}
    ''';
  }
}
