import 'package:chases_scroll/src/models/user_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final communitySearch = StateProvider<String?>((ref) => null);
final hasTappedComment = StateProvider.family<bool, int>((ref, index) => false);
final refreshHomeScreen = StateProvider<bool>((ref) => false);
final userProvider = StateProvider<UserModel?>((ref) => null);
