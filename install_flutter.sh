curl -C - --output flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/${FLUTTER_CHANNEL}/linux/flutter_linux_${FLUTTER_VERSION}-${FLUTTER_CHANNEL}.tar.xz \
        && tar -xf flutter.tar.xz -C /home \
        && rm flutter.tar.xz

flutter config --android-sdk "${ANDROID_SDK_ROOT}" \
        && yes | flutter doctor --android-licenses \
        && flutter config --no-analytics \
        && flutter update-packages