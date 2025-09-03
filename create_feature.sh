#!/bin/bash

if [ -z "$1" ]; then
  echo "❌ Usage: $0 <feature_name>"
  exit 1
fi

# get feature name
FEATURE_NAME=$1
BASE_DIR="./lib/feature/$FEATURE_NAME"

# change feature name to class name
CLASS_NAME="$(tr '[:lower:]' '[:upper:]' <<< ${FEATURE_NAME:0:1})${FEATURE_NAME:1}"

# -----------------------------
# create dir
# -----------------------------
mkdir -p "$BASE_DIR/blocs"
mkdir -p "$BASE_DIR/models"
mkdir -p "$BASE_DIR/page"
mkdir -p "$BASE_DIR/widgets"

# -----------------------------
# create file page
# -----------------------------
PAGE_FILE="$BASE_DIR/page/${FEATURE_NAME}_page.dart"

cat > "$PAGE_FILE" <<EOF
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ${CLASS_NAME}Page extends StatelessWidget {
  const ${CLASS_NAME}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
EOF

echo "✅ Feature '$FEATURE_NAME' created at $BASE_DIR"
echo "👉 Page file: $PAGE_FILE"
