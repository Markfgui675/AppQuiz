import 'package:appquiz/database/category_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryListProvider = StateNotifierProvider((ref) => new CategoryList([]));