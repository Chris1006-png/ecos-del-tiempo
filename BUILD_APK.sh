#!/bin/bash

# Script para compilar Ecos del Tiempo como APK
# Requiere: Godot 4.3+, Java 11+, Android SDK, Gradle

echo "=== Compilando Ecos del Tiempo ==="
echo ""

# Verificar Godot
if ! command -v godot &> /dev/null; then
    echo "❌ Godot no está instalado"
    echo "Descárgalo desde: https://godotengine.org/download"
    exit 1
fi

echo "✓ Godot encontrado: $(godot --version)"

# Verificar Java
if ! command -v java &> /dev/null; then
    echo "❌ Java no está instalado"
    echo "Instala Java 11+: sudo apt-get install openjdk-11-jdk"
    exit 1
fi

echo "✓ Java encontrado: $(java -version 2>&1 | head -1)"

# Verificar Android SDK
if [ -z "$ANDROID_SDK_ROOT" ]; then
    echo "❌ ANDROID_SDK_ROOT no está configurado"
    echo "Configúralo: export ANDROID_SDK_ROOT=/path/to/android-sdk"
    exit 1
fi

echo "✓ Android SDK: $ANDROID_SDK_ROOT"

# Compilar
echo ""
echo "Exportando a APK..."
godot --export-release Android ./ecos-del-tiempo.apk

if [ -f "./ecos-del-tiempo.apk" ]; then
    echo ""
    echo "✅ ¡APK compilado exitosamente!"
    echo "Archivo: ./ecos-del-tiempo.apk"
    echo ""
    echo "Para instalar en tu celular:"
    echo "  adb install ecos-del-tiempo.apk"
else
    echo "❌ Error durante la compilación"
    exit 1
fi
