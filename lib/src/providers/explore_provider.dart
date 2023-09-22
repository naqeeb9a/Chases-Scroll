import 'package:chases_scroll/src/repositories/explore_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/event_model.dart';

//this provide is to get the list of top event
final eventListFutureProvider = FutureProvider<List<ContentEvent>>((ref) {
  final repository = ref.read(repositoryProvider);
  return repository.getTopEvents();
});
