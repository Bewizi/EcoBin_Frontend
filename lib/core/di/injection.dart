import 'package:ecobin/core/data/services/api_client.dart';
import 'package:ecobin/features/auth/data/data_sources/auth_remote_datasource_impl.dart';
import 'package:ecobin/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecobin/features/auth/domain/auth_repository.dart';
import 'package:ecobin/features/auth/presentation/state/bloc/login_bloc.dart';
import 'package:ecobin/features/auth/presentation/state/bloc/register_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Injection {
  static ApiClient? _apiClient;
  static SharedPreferences? _sharedPreferences;
  static AuthRepository? _authRepository;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _apiClient = ApiClient();
  }

  static ApiClient get apiClient {
    if (_apiClient == null) {
      throw Exception('ApiClient not initialized. Call Injection.init() first');
    }
    return _apiClient!;
  }

  static SharedPreferences get sharedPreferences {
    if (_sharedPreferences == null) {
      throw Exception(
        'SharedPreference not initialized. Call Injection.init() first',
      );
    }
    return _sharedPreferences!;
  }

  static AuthRepository get authRepository {
    if (_authRepository == null) {
      final remoteDatasource = AuthRemoteDatasourceImpl(apiClient: apiClient);

      _authRepository = AuthRepositoryImpl(
        remoteDatasource: remoteDatasource,
        sharedPreferences: sharedPreferences,
        apiClient: apiClient,
      );
    }
    return _authRepository!;
  }

  static AuthBloc get authBloc {
    return AuthBloc(repository: authRepository);
  }

  static RegisterBloc get registerBloc {
    return RegisterBloc(repository: authRepository);
  }
}
