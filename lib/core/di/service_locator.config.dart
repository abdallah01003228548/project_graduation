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
import 'package:project_graduation/feature/auth/data/repo/auth_data_source_imp.dart'
    as _i1071;
import 'package:project_graduation/feature/auth/data/repo/auth_repo_imp.dart'
    as _i82;
import 'package:project_graduation/feature/auth/domain/repo/auth_data_source.dart'
    as _i192;
import 'package:project_graduation/feature/auth/domain/repo/auth_repo_interface.dart'
    as _i405;
import 'package:project_graduation/feature/auth/domain/use_case/login_use_case.dart'
    as _i199;
import 'package:project_graduation/feature/auth/presentation/view_model/cubit/login/login_cubit.dart'
    as _i812;
import 'package:project_graduation/feature/cart/data/data_source/cart_remote_data_source.dart'
    as _i103;
import 'package:project_graduation/feature/cart/data/data_source/cart_remote_data_source_imp.dart'
    as _i912;
import 'package:project_graduation/feature/cart/domain/repo/cart_repo_imp.dart'
    as _i937;
import 'package:project_graduation/feature/cart/domain/repo/cart_repo_interface.dart'
    as _i104;
import 'package:project_graduation/feature/cart/domain/use_case/add_cart_use_case.dart'
    as _i799;
import 'package:project_graduation/feature/cart/domain/use_case/delete_cart_use_case.dart'
    as _i772;
import 'package:project_graduation/feature/cart/domain/use_case/get_cart_use_case.dart'
    as _i934;
import 'package:project_graduation/feature/cart/presentation/view_model/cart/cart_cubit.dart'
    as _i572;
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
import 'package:project_graduation/feature/search/data/data_source/search_remote_data_source.dart'
    as _i587;
import 'package:project_graduation/feature/search/data/data_source/search_remote_data_source_imp.dart'
    as _i803;
import 'package:project_graduation/feature/search/data/repo/search_repo_imp.dart'
    as _i545;
import 'package:project_graduation/feature/search/domain/repo/search_repo_interface.dart'
    as _i293;
import 'package:project_graduation/feature/search/domain/use_case/search_products_use_case.dart'
    as _i422;
import 'package:project_graduation/feature/search/presentation/view_model/search_cubit.dart'
    as _i1047;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i983.NetworkModule>(() => _i983.NetworkModule());
    gh.factory<_i587.SearchRemoteDataSource>(
      () => _i803.SearchRemoteDataSourceImp(gh<_i983.NetworkModule>()),
    );
    gh.factory<_i192.AuthDataSource>(() => _i1071.AuthDataSourceImp());
    gh.factory<_i405.AuthRepoInterface>(
      () => _i82.AuthRepoImp(gh<_i192.AuthDataSource>()),
    );
    gh.factory<_i947.HomeRemoteDataSource>(
      () => _i947.HomeRemoteDataSourceImp(gh<_i983.NetworkModule>()),
    );
    gh.lazySingleton<_i103.CartRemoteDataSource>(
      () => _i912.CartRemoteDataSourceImp(
        networkModule: gh<_i983.NetworkModule>(),
      ),
    );
    gh.lazySingleton<_i104.CartRepoInterface>(
      () => _i937.CartRepoImp(
        cartRemoteDataSource: gh<_i103.CartRemoteDataSource>(),
      ),
    );
    gh.factory<_i199.LoginUseCase>(
      () => _i199.LoginUseCase(gh<_i405.AuthRepoInterface>()),
    );
    gh.factory<_i293.SearchRepoInterface>(
      () => _i545.SearchRepoImp(gh<_i587.SearchRemoteDataSource>()),
    );
    gh.factory<_i812.LoginCubit>(
      () => _i812.LoginCubit(gh<_i199.LoginUseCase>()),
    );
    gh.factory<_i603.HomeRepository>(
      () => _i1009.HomeRepoImp(gh<_i947.HomeRemoteDataSource>()),
    );
    gh.factory<_i799.AddCartUseCase>(
      () => _i799.AddCartUseCase(
        cartRepoInterface: gh<_i104.CartRepoInterface>(),
      ),
    );
    gh.factory<_i772.DeleteCartUseCase>(
      () => _i772.DeleteCartUseCase(gh<_i104.CartRepoInterface>()),
    );
    gh.factory<_i934.GetCartUseCase>(
      () => _i934.GetCartUseCase(gh<_i104.CartRepoInterface>()),
    );
    gh.factory<_i192.GetCategoriesUseCase>(
      () => _i192.GetCategoriesUseCase(gh<_i603.HomeRepository>()),
    );
    gh.factory<_i422.SearchProductsUseCase>(
      () => _i422.SearchProductsUseCase(gh<_i293.SearchRepoInterface>()),
    );
    gh.factory<_i1047.SearchCubit>(
      () => _i1047.SearchCubit(gh<_i422.SearchProductsUseCase>()),
    );
    gh.factory<_i572.CartCubit>(
      () => _i572.CartCubit(
        gh<_i934.GetCartUseCase>(),
        gh<_i799.AddCartUseCase>(),
        gh<_i772.DeleteCartUseCase>(),
      ),
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
