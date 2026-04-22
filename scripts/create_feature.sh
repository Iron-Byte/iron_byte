#!/bin/bash

set -e

FEATURE_NAME=$1

if [ -z "$FEATURE_NAME" ]; then
  echo "❌ Please provide a feature name"
  echo "👉 Example: ./scripts/create_feature.sh auth"
  exit 1
fi

# Capitalize first letter
CLASS_NAME="$(tr '[:lower:]' '[:upper:]' <<< ${FEATURE_NAME:0:1})${FEATURE_NAME:1}"

# Always resolve project root (no matter where script is run from)
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BASE_DIR="$PROJECT_ROOT/lib/features/$FEATURE_NAME"

echo "🚀 Creating feature: $FEATURE_NAME"
echo "📁 Location: $BASE_DIR"

# Create folders
mkdir -p "$BASE_DIR/presentation/screens"
mkdir -p "$BASE_DIR/presentation/widgets"
mkdir -p "$BASE_DIR/presentation/bloc"

mkdir -p "$BASE_DIR/domain/entities"
mkdir -p "$BASE_DIR/domain/repositories"
mkdir -p "$BASE_DIR/domain/usecases"

mkdir -p "$BASE_DIR/data/models"
mkdir -p "$BASE_DIR/data/datasources"
mkdir -p "$BASE_DIR/data/repositories"

# ------------------------
# 📦 FEATURE EXPORT
# ------------------------
cat <<EOL > "$BASE_DIR/$FEATURE_NAME.dart"
export 'presentation/screens/${FEATURE_NAME}_screen.dart';
EOL

# ------------------------
# 🖥 SCREEN
# ------------------------
cat <<EOL > "$BASE_DIR/presentation/screens/${FEATURE_NAME}_screen.dart"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/${FEATURE_NAME}_bloc.dart';

class ${CLASS_NAME}Screen extends StatelessWidget {
  const ${CLASS_NAME}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('$CLASS_NAME')),
      body: BlocBuilder<${CLASS_NAME}Bloc, ${CLASS_NAME}State>(
        builder: (context, state) {
          return const Center(child: Text('$CLASS_NAME Screen'));
        },
      ),
    );
  }
}
EOL

# ------------------------
# 🧠 BLOC
# ------------------------
cat <<EOL > "$BASE_DIR/presentation/bloc/${FEATURE_NAME}_bloc.dart"
import 'package:flutter_bloc/flutter_bloc.dart';
import '${FEATURE_NAME}_event.dart';
import '${FEATURE_NAME}_state.dart';

class ${CLASS_NAME}Bloc extends Bloc<${CLASS_NAME}Event, ${CLASS_NAME}State> {
  ${CLASS_NAME}Bloc() : super(const ${CLASS_NAME}State.initial()) {
    on<Load${CLASS_NAME}>((event, emit) async {
      emit(const ${CLASS_NAME}State.loading());

      try {
        // TODO: call usecase
        emit(const ${CLASS_NAME}State.success());
      } catch (e) {
        emit(${CLASS_NAME}State.error(e.toString()));
      }
    });
  }
}
EOL

# ------------------------
# 📩 EVENT
# ------------------------
cat <<EOL > "$BASE_DIR/presentation/bloc/${FEATURE_NAME}_event.dart"
abstract class ${CLASS_NAME}Event {}

class Load${CLASS_NAME} extends ${CLASS_NAME}Event {}
EOL

# ------------------------
# 📊 STATE (FREEZED)
# ------------------------
cat <<EOL > "$BASE_DIR/presentation/bloc/${FEATURE_NAME}_state.dart"
import 'package:freezed_annotation/freezed_annotation.dart';

part '${FEATURE_NAME}_state.freezed.dart';

@freezed
class ${CLASS_NAME}State with _\$${CLASS_NAME}State {
  const factory ${CLASS_NAME}State.initial() = _Initial;
  const factory ${CLASS_NAME}State.loading() = _Loading;
  const factory ${CLASS_NAME}State.success() = _Success;
  const factory ${CLASS_NAME}State.error(String message) = _Error;
}
EOL

# ------------------------
# 🧩 ENTITY
# ------------------------
cat <<EOL > "$BASE_DIR/domain/entities/${FEATURE_NAME}.dart"
class ${CLASS_NAME} {
  final String id;

  ${CLASS_NAME}({required this.id});
}
EOL

# ------------------------
# 📦 REPOSITORY (ABSTRACT)
# ------------------------
cat <<EOL > "$BASE_DIR/domain/repositories/${FEATURE_NAME}_repository.dart"
abstract class ${CLASS_NAME}Repository {
  Future<void> get${CLASS_NAME}();
}
EOL

# ------------------------
# ⚙️ USECASE
# ------------------------
cat <<EOL > "$BASE_DIR/domain/usecases/get_${FEATURE_NAME}.dart"
import '../repositories/${FEATURE_NAME}_repository.dart';

class Get${CLASS_NAME} {
  final ${CLASS_NAME}Repository repository;

  Get${CLASS_NAME}(this.repository);

  Future<void> call() async {
    return repository.get${CLASS_NAME}();
  }
}
EOL

# ------------------------
# 🧾 MODEL
# ------------------------
cat <<EOL > "$BASE_DIR/data/models/${FEATURE_NAME}_model.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/${FEATURE_NAME}.dart';

part '${FEATURE_NAME}_model.freezed.dart';
part '${FEATURE_NAME}_model.g.dart';

@freezed
class ${CLASS_NAME}Model with _\$${CLASS_NAME}Model {
  const factory ${CLASS_NAME}Model({
    required String id,
  }) = _${CLASS_NAME}Model;

  factory ${CLASS_NAME}Model.fromJson(Map<String, dynamic> json) =>
      _\$${CLASS_NAME}ModelFromJson(json);
}

extension ${CLASS_NAME}Mapper on ${CLASS_NAME}Model {
  ${CLASS_NAME} toEntity() {
    return ${CLASS_NAME}(id: id);
  }
}
EOL

# ------------------------
# 🌐 DATASOURCE
# ------------------------
cat <<EOL > "$BASE_DIR/data/datasources/${FEATURE_NAME}_remote_datasource.dart"
abstract class ${CLASS_NAME}RemoteDataSource {
  Future<void> fetch${CLASS_NAME}();
}
EOL

# ------------------------
# 🔌 REPOSITORY IMPL
# ------------------------
cat <<EOL > "$BASE_DIR/data/repositories/${FEATURE_NAME}_repository_impl.dart"
import '../../domain/repositories/${FEATURE_NAME}_repository.dart';

class ${CLASS_NAME}RepositoryImpl implements ${CLASS_NAME}Repository {
  @override
  Future<void> get${CLASS_NAME}() async {
    // TODO: implement API call
  }
}
EOL

echo "✅ Feature '$FEATURE_NAME' created successfully!"
echo "👉 Next: flutter pub run build_runner build --delete-conflicting-outputs"
