#!/bin/bash

VERSION=$(grep 'version:' pubspec.yaml | awk '{print $2}' | cut -d '+' -f 1)


if [ -z "$VERSION" ]; then
    echo "can't get version from pubspec.yaml please check"
    exit 1
fi


flutter build apk


if [ $? -eq 0 ]; then
    mv build/app/outputs/flutter-apk/app-release.apk build/app/outputs/flutter-apk/pinto_pos-alpha-${VERSION}.apk
    echo "<| Build Success => mobile_app_standard-${VERSION}.apk |>"
else
    echo "<| build APK failed |>"
    exit 1
fi