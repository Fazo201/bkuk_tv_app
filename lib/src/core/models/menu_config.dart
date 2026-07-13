import 'package:flutter/material.dart';

class MenuConfig {
  final int id;

  final String title;

  final String folder;

  final IconData icon;

  final bool? singleItem;

  final Future<List<dynamic>> Function() getItems;

  final Future<void> Function({
    required String title,
    required String description,
    String? imagePath,
    String? pdfPath,
    required DateTime createdAt,
  }) createItem;

  final Future<void> Function({
    required int id,
    required String title,
    required String description,
    String? imagePath,
    String? pdfPath,
  }) updateItem;


  final Future<void> Function(int id) deleteItem;

  const MenuConfig({
    required this.id,
    required this.title,
    required this.folder,
    required this.icon,
    this.singleItem = false,
    required this.getItems,
    required this.createItem,
    required this.updateItem,
    required this.deleteItem,
  });
}