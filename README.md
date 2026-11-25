# Hello APK — минимальный Android-проект на Kotlin

Шаблон-заготовка: один экран со счётчиком нажатий. Собран **без Android Studio**,
через Gradle из командной строки.

## Готовый APK

```
HelloApk-debug.apk
```

(копия файла `app/build/outputs/apk/debug/app-debug.apk`)

| Параметр | Значение |
| --- | --- |
| package | `com.example.helloapk` |
| versionName / versionCode | 1.0 / 1 |
| minSdk | 24 (Android 7.0) |
| targetSdk / compileSdk | 34 (Android 14) |
| подпись | debug keystore (ставится на устройство без правки) |
| размер | ~5.3 МБ |

## Как установить на телефон

1. Скопировать `HelloApk-debug.apk` на телефон (USB, кабель, облако, мессенджер).
2. Открыть файл в файловом менеджере.
3. Разрешить установку из этого источника, если Android попросит.
4. Если подключаете телефон по USB с отладкой:
   ```
   C:\Android\sdk\platform-tools\adb.exe install -r HelloApk-debug.apk
   ```

## Как пересобрать

Двойной клик по `build.cmd` (или из терминала):

```
build.cmd
```

Скрипт сам подставит JDK, Android SDK и Gradle. Результат — `HelloApk-debug.apk`.

Вручную то же самое:

```
set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.21.10002-hotspot"
set "ANDROID_HOME=C:\Android\sdk"
set "GRADLE_USER_HOME=C:\Android\gradle-home"
C:\Android\gradle\gradle-8.7\bin\gradle.bat assembleDebug --no-daemon
```

Через `gradlew.bat` тоже можно, но он скачает ещё одну копию Gradle (~130 МБ) —
`build.cmd` быстрее, потому что использует уже распакованный Gradle.

## Структура

```
HelloApk/
├── settings.gradle.kts          # модули и репозитории (google, mavenCentral)
├── build.gradle.kts             # версии AGP 8.5.2 и Kotlin 1.9.24
├── gradle.properties            # JVM-память, AndroidX
├── local.properties             # путь к Android SDK (не коммитить в git)
├── build.cmd                    # сборка одной командой
└── app/
    ├── build.gradle.kts         # namespace, sdk-версии, зависимости
    └── src/main/
        ├── AndroidManifest.xml
        ├── java/com/example/helloapk/MainActivity.kt
        └── res/
            ├── layout/activity_main.xml
            ├── values/{strings,colors,themes}.xml
            ├── drawable/ic_launcher_foreground.xml
            ├── mipmap-anydpi-v26/ic_launcher.xml   # адаптивная иконка (API 26+)
            └── mipmap-*/ic_launcher.png            # иконки для API 24-25
```

## Куда добавлять свой код

- **Экран** — `app/src/main/res/layout/activity_main.xml` (ViewBinding включён,
  в коде доступен как `ActivityMainBinding`).
- **Логика** — `app/src/main/java/com/example/helloapk/MainActivity.kt`.
- **Тексты** — `app/src/main/res/values/strings.xml` (не хардкодить в layout).
- **Новые экраны** — создать `XxxActivity.kt` + layout, зарегистрировать в
  `AndroidManifest.xml`, при необходимости добавить `<intent-filter>`.
- **Зависимости** — блок `dependencies` в `app/build.gradle.kts`
  (уже подключены `core-ktx`, `appcompat`, `material`).
- **Разрешения** — теги `<uses-permission>` в `AndroidManifest.xml`
  (камера, интернет, геолокация и т.д.).

## Release-сборка (для раздачи/публикации)

1. Создать ключ:
   ```
   keytool -genkeypair -v -keystore my-release.keystore -alias app -keyalg RSA -keysize 2048 -validity 10000
   ```
2. Добавить `signingConfigs` в `app/build.gradle.kts`.
3. `gradle assembleRelease`.

Для Google Play нужен не APK, а AAB (`bundleRelease`) и аккаунт разработчика.

## Тулчейн на этой машине

| Компонент | Расположение |
| --- | --- |
| JDK 17 (Temurin) | `C:\Program Files\Eclipse Adoptium\jdk-17.0.21.10002-hotspot` |
| Android SDK | `C:\Android\sdk` (platform-tools, platforms/android-34, build-tools/34.0.0) |
| Gradle 8.7 | `C:\Android\gradle\gradle-8.7` |
| Кэш Gradle | `C:\Android\gradle-home` |

`JAVA_HOME`, `ANDROID_HOME`, `ANDROID_SDK_ROOT` прописаны в переменные окружения
пользователя, так что новые терминалы их подхватят.
