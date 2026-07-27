// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:project_graduation/core/di/network_module.dart' as _i983;
import 'package:project_graduation/feature/home/data/models/data_source/home_remote_data_source_imp.dart'
    as _i947;
import 'package:project_graduation/feature/home/data/repo/home_repo_imp.dart'
    as _i1009;
import 'package:project_graduation/feature/home/domain/repo/home_repo_interface.dart'
    as _i603;
import 'package:project_graduation/feature/home/domain/use_case/get_categories_use_case.dart'
    as _i192;
import 'package:project_graduation/feature/home/domain/use_case/get_products_use_case.dart'
    as _i313;
import 'package:project_graduation/feature/home/presentation/view_model/home/home_cubit.dart'
    as _i1002;
import 'package:project_graduation/feature/products_by_category/domain/use_case/get_products_by_category_use_case.dart'
    as _i551;
import 'package:project_graduation/feature/products_by_category/presentation/view_model/products_by_category_cubit.dart'
    as _i72;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i983.NetworkModule>(() => _i983.NetworkModule());
    gh.factory<_i947.HomeRemoteDataSource>(
      () => _i947.HomeRemoteDataSourceImp(gh<_i983.NetworkModule>()),
    );
    gh.factory<_i603.HomeRepository>(
      () => _i1009.HomeRepoImp(gh<_i947.HomeRemoteDataSource>()),
    );
    gh.factory<_i192.GetCategoriesUseCase>(
      () => _i192.GetCategoriesUseCase(gh<_i603.HomeRepository>()),
    );
    gh.factory<_i313.GetProductsUseCase>(
      () => _i313.GetProductsUseCase(gh<_i603.HomeRepository>()),
    );
    gh.factory<_i551.GetProductsByCategoryUseCase>(
      () => _i551.GetProductsByCategoryUseCase(gh<_i603.HomeRepository>()),
    );
    gh.factory<_i1002.HomeCubit>(
      () => _i1002.HomeCubit(
        gh<_i192.GetCategoriesUseCase>(),
        gh<_i313.GetProductsUseCase>(),
      ),
    );
    gh.factory<_i72.ProductsByCategoryCubit>(
      () => _i72.ProductsByCategoryCubit(
        gh<_i551.GetProductsByCategoryUseCase>(),
      ),
    );
    return this;
  }
}
