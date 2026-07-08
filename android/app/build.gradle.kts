import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// 1. تحميل خصائص ملف key.properties
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.kasem.quiz_game"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.kasem.quiz_game" 
        
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // 2. إعدادات التوقيع (Signing Configs) الآمنة بلغة Kotlin DSL
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as? String ?: ""
            keyPassword = keystoreProperties["keyPassword"] as? String ?: ""
            storePassword = keystoreProperties["storePassword"] as? String ?: ""
            
            val storeFilePath = keystoreProperties["storeFile"] as? String
            storeFile = if (!storeFilePath.isNullOrEmpty()) file(storeFilePath) else null
        }
    }

    buildTypes {
        release {
            // 3. استخدام إعدادات التوقيع الخاصة بـ release بدلاً من debug
            signingConfig = signingConfigs.getByName("release")
            
            // تفعيل حماية وتقليص حجم التطبيق (اختياري ومستحسن للمتجر)
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

flutter {
    source = "../.."
}