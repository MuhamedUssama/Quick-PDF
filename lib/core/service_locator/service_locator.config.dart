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

import '../../features/pdf_generator/data/data_sources/pdf_generator_remote_data_source.dart'
    as _i193;
import '../../features/pdf_generator/data/data_sources/pdf_generator_remote_data_source_impl.dart'
    as _i564;
import '../../features/pdf_generator/data/repositories/pdf_generator_repository_impl.dart'
    as _i948;
import '../../features/pdf_generator/domain/repositories/pdf_generator_repository.dart'
    as _i546;
import '../../features/pdf_generator/domain/usecases/extract_arabic_text_usecase.dart'
    as _i863;
import '../../features/scanner/data/data_sources/scanner_local_data_source.dart'
    as _i529;
import '../../features/scanner/data/data_sources/scanner_local_data_source_impl.dart'
    as _i683;
import '../../features/scanner/data/repositories/scanner_repository_impl.dart'
    as _i419;
import '../../features/scanner/domain/repositories/scanner_repository.dart'
    as _i816;
import '../../features/scanner/domain/usecases/add_image_to_group_usecase.dart'
    as _i214;
import '../../features/scanner/domain/usecases/create_group_usecase.dart'
    as _i733;
import '../../features/scanner/domain/usecases/delete_group_usecase.dart'
    as _i112;
import '../../features/scanner/domain/usecases/get_all_groups_usecase.dart'
    as _i867;
import '../../features/scanner/domain/usecases/update_image_extracted_text_usecase.dart'
    as _i37;
import '../../features/scanner/presentation/cubit/scanner_cubit.dart' as _i659;
import '../services/network_info.dart' as _i1;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i193.PdfGeneratorRemoteDataSource>(
      () => const _i564.PdfGeneratorRemoteDataSourceImpl(),
    );
    gh.factory<_i529.ScannerLocalDataSource>(
      () => const _i683.ScannerLocalDataSourceImpl(),
    );
    gh.factory<_i1.NetworkInfo>(() => const _i1.NetworkInfoImpl());
    gh.factory<_i546.PdfGeneratorRepository>(
      () => _i948.PdfGeneratorRepositoryImpl(
        gh<_i193.PdfGeneratorRemoteDataSource>(),
        gh<_i1.NetworkInfo>(),
      ),
    );
    gh.factory<_i816.ScannerRepository>(
      () => _i419.ScannerRepositoryImpl(gh<_i529.ScannerLocalDataSource>()),
    );
    gh.factory<_i214.AddImageToGroupUseCase>(
      () => _i214.AddImageToGroupUseCase(gh<_i816.ScannerRepository>()),
    );
    gh.factory<_i733.CreateGroupUseCase>(
      () => _i733.CreateGroupUseCase(gh<_i816.ScannerRepository>()),
    );
    gh.factory<_i112.DeleteGroupUseCase>(
      () => _i112.DeleteGroupUseCase(gh<_i816.ScannerRepository>()),
    );
    gh.factory<_i867.GetAllGroupsUseCase>(
      () => _i867.GetAllGroupsUseCase(gh<_i816.ScannerRepository>()),
    );
    gh.factory<_i37.UpdateImageExtractedTextUseCase>(
      () => _i37.UpdateImageExtractedTextUseCase(gh<_i816.ScannerRepository>()),
    );
    gh.factory<_i863.ExtractArabicTextUseCase>(
      () => _i863.ExtractArabicTextUseCase(gh<_i546.PdfGeneratorRepository>()),
    );
    gh.factory<_i659.ScannerCubit>(
      () => _i659.ScannerCubit(
        gh<_i733.CreateGroupUseCase>(),
        gh<_i214.AddImageToGroupUseCase>(),
      ),
    );
    return this;
  }
}
