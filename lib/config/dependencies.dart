import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:scire/data/repositories/auth/auth_repository.dart';
import 'package:scire/data/services/api_service.dart';

List<SingleChildWidget> get providers {
  return [
    Provider(create: (context) => ApiService()),
    Provider(create: (context) => AuthRepository(apiService: context.read()))
  ];
}
