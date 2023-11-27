import 'package:diaryapp/services/storage_service.dart';
import 'package:flutter/material.dart';

class StorageServiceProvider extends ChangeNotifier {
  final StorageService storageService = StorageService();

  StorageService get storage => storageService;
}
