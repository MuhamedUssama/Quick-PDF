// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/pdf_generator/data/data_sources/pdf_generator_remote_data_source.dart'
    as _i3;
import '../../features/pdf_generator/data/data_sources/pdf_generator_remote_data_source_impl.dart'
    as _i4;
import '../../features/pdf_generator/data/repositories/pdf_generator_repository_impl.dart'
    as _i5;
import '../../features/pdf_generator/domain/repositories/pdf_generator_repository.dart'
    as _i6;
import '../../features/pdf_generator/domain/usecases/extract_arabic_text_usecase.dart'
    as _i7;
import '../../features/scanner/data/data_sources/scanner_local_data_source.dart'
    as _i8;
import '../../features/scanner/data/data_sources/scanner_local_data_source_impl.dart'
    as _i9;
import '../../features/scanner/data/repositories/scanner_repository_impl.dart'
    as _i10;
import '../../features/scanner/domain/repositories/scanner_repository.dart'
    as _i11;
import '../../features/scanner/domain/usecases/add_image_to_group_usecase.dart'
    as _i12;
import '../../features/scanner/domain/usecases/create_group_usecase.dart'
    as _i13;
import '../../features/scanner/domain/usecases/delete_group_usecase.dart'
    as _i14;
import '../../features/scanner/domain/usecases/get_all_groups_usecase.dart'
    as _i15;
import '../../features/scanner/domain/usecases/update_image_extracted_text_usecase.dart'
    as _i16;
import '../services/network_info.dart' as _i17;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i17.NetworkInfo>(() => const _i17.NetworkInfoImpl());
    gh.factory<_i3.PdfGeneratorRemoteDataSource>(
        () => const _i4.PdfGeneratorRemoteDataSourceImpl());
    gh.factory<_i8.ScannerLocalDataSource>(
        () => const _i9.ScannerLocalDataSourceImpl());
    gh.factory<_i6.PdfGeneratorRepository>(() => _i5.PdfGeneratorRepositoryImpl(
          gh<_i3.PdfGeneratorRemoteDataSource>(),
          gh<_i17.NetworkInfo>(),
        ));
    gh.factory<_i11.ScannerRepository>(
        () => _i10.ScannerRepositoryImpl(gh<_i8.ScannerLocalDataSource>()));
    gh.factory<_i7.ExtractArabicTextUseCase>(
        () => _i7.ExtractArabicTextUseCase(gh<_i6.PdfGeneratorRepository>()));
    gh.factory<_i12.AddImageToGroupUseCase>(
        () => _i12.AddImageToGroupUseCase(gh<_i11.ScannerRepository>()));
    gh.factory<_i13.CreateGroupUseCase>(
        () => _i13.CreateGroupUseCase(gh<_i11.ScannerRepository>()));
    gh.factory<_i14.DeleteGroupUseCase>(
        () => _i14.DeleteGroupUseCase(gh<_i11.ScannerRepository>()));
    gh.factory<_i15.GetAllGroupsUseCase>(
        () => _i15.GetAllGroupsUseCase(gh<_i11.ScannerRepository>()));
    gh.factory<_i16.UpdateImageExtractedTextUseCase>(() =>
        _i16.UpdateImageExtractedTextUseCase(gh<_i11.ScannerRepository>()));
    return this;
  }
}
