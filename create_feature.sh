#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "❌ Usage: $0 <feature_name>"
  exit 1
fi

FEATURE_NAME="$1"                     # เช่น: login
CLASS_NAME="$(tr '[:lower:]' '[:upper:]' <<< ${FEATURE_NAME:0:1})${FEATURE_NAME:1}"   # Login
PROJECT_PKG="pinto_app"

# โฟลเดอร์ feature
BASE_DIR="./lib/feature/${FEATURE_NAME}"
mkdir -p "$BASE_DIR/blocs" "$BASE_DIR/models" "$BASE_DIR/pages" "$BASE_DIR/widgets"

# ไฟล์เพจ
PAGE_FILE="$BASE_DIR/pages/${FEATURE_NAME}_page.dart"
cat > "$PAGE_FILE" <<EOF
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:$PROJECT_PKG/shared/styles/p_colors.dart';
import 'package:$PROJECT_PKG/shared/widgets/appbar/appbar_custom.dart';
import 'package:$PROJECT_PKG/shared/widgets/appbar/bottombar_custom.dart';

@RoutePage()
class ${CLASS_NAME}Page extends StatelessWidget {
  const ${CLASS_NAME}Page({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRouteName = context.routeData.name;
    return Scaffold(
      bottomNavigationBar: BottomBarCustom(currentRouteName: currentRouteName),
      appBar: AppBarCustom(currentRouteName: currentRouteName),
      backgroundColor: PColor.backgroundColor,
      body: Container(),
    );
  }
}
EOF

echo "✅ Created page: $PAGE_FILE"

# -----------------------------
# อัปเดต router.dart
# -----------------------------
ROUTER_FILE="./lib/router/router.dart"   # ปรับ path นี้ให้ตรงโปรเจกต์คุณ

if [ ! -f "$ROUTER_FILE" ]; then
  echo "❌ Router file not found at $ROUTER_FILE"
  exit 1
fi

# 1) แทรก import (เฉพาะถ้ายังไม่มี)
IMPORT_LINE="import 'package:${PROJECT_PKG}/feature/${FEATURE_NAME}/pages/${FEATURE_NAME}_page.dart';"
if ! grep -Fxq "$IMPORT_LINE" "$ROUTER_FILE"; then
  # แทรกหลังบรรทัด import สุดท้าย (macOS ใช้ sed -i '')
  last_import_line=$(grep -n "^import " "$ROUTER_FILE" | tail -n1 | cut -d: -f1)
  if [ -n "$last_import_line" ]; then
    # แทรกบรรทัดใหม่ถัดจาก import สุดท้าย
    sed -i '' "$((last_import_line)) a\\
$IMPORT_LINE
" "$ROUTER_FILE"
    echo "➕ Added import to router.dart"
  else
    # ถ้าไม่มี import เลย ให้แทรกบนสุด
    sed -i '' "1s;^;${IMPORT_LINE}\n;" "$ROUTER_FILE"
    echo "➕ Added first import to router.dart"
  fi
else
  echo "ℹ️ Import already exists in router.dart"
fi

ROUTE_SNIPPET="        CustomRoute(
          page: ${CLASS_NAME}Route.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),"

if ! grep -q "page: ${CLASS_NAME}Route.page" "$ROUTER_FILE"; then
  # ใช้ awk แทน sed เพื่อความง่าย cross-platform
  awk -v route="$ROUTE_SNIPPET" '
    /List<AutoRoute> get routes => \[/ { print; next }
    /\];/ && !done { print route; done=1 }
    { print }
  ' "$ROUTER_FILE" > "${ROUTER_FILE}.tmp" && mv "${ROUTER_FILE}.tmp" "$ROUTER_FILE"

  echo "➕ Added route entry to router.dart"
else
  echo "ℹ️ Route entry already exists"
fi

rm -rf "${ROUTER_FILE}.tmp"

# สร้างไฟล์ gen
fvm dart run build_runner build -d

echo "✅ Feature '$FEATURE_NAME' wired into router.dart and generated routes."
