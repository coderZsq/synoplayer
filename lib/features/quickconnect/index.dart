// QuickConnect 功能模块统一导出文件

// 领域层
export 'domain/entities/quickconnect_entity.dart';
export 'domain/repositories/quickconnect_repository.dart';
export 'domain/usecases/resolve_address_usecase.dart';
export 'domain/usecases/login_usecase.dart';

// 数据层
export 'data/models/quickconnect_model.dart';
export 'data/datasources/quickconnect_remote_datasource.dart';
export 'data/datasources/quickconnect_local_datasource.dart';
export 'data/repositories/quickconnect_repository_impl.dart';

// 表现层
export 'presentation/providers/quickconnect_providers.dart';
