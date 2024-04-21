import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:project_kepler/core/di/configuration.config.dart';

import 'package:project_kepler/core/di/locator.dart';

@InjectableInit(
  initializerName: r'$configureDependencies',
  preferRelativeImports: true,
  asExtension: false,
)
GetIt configureDependencies() => $configureDependencies(locator);
