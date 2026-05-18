# 🚀 Guía: Compilar APK Automáticamente con GitHub Actions

Esta guía te enseña cómo usar **GitHub Actions** para compilar el APK automáticamente en la nube, sin necesidad de instalar nada en tu PC.

## ¿Qué es GitHub Actions?

GitHub Actions es un servicio **gratuito** de GitHub que ejecuta código automáticamente cuando haces cambios en tu repositorio. Es perfecto para compilar juegos sin ocupar recursos de tu PC.

## 📋 Requisitos

- Cuenta de GitHub (gratis)
- El proyecto "Ecos del Tiempo" en un repositorio

## 🔧 Pasos para Configurar

### Paso 1: Crear un Repositorio en GitHub

1. Ve a [github.com](https://github.com)
2. Inicia sesión (o crea cuenta gratis)
3. Haz clic en **"+"** → **"New repository"**
4. Nombre: `ecos-del-tiempo`
5. Descripción: `Juego 2D pixel art con mecánica de ecos temporales`
6. Selecciona **"Public"** (para que GitHub Actions sea gratis)
7. Haz clic en **"Create repository"**

### Paso 2: Subir el Proyecto

En tu PC o celular, abre una terminal y ejecuta:

```bash
cd /ruta/a/ecos-godot
git init
git add .
git commit -m "Inicial: Ecos del Tiempo v1.0"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/ecos-del-tiempo.git
git push -u origin main
```

Reemplaza `TU_USUARIO` con tu nombre de usuario de GitHub.

### Paso 3: Verificar que el Workflow Está Configurado

1. Ve a tu repositorio en GitHub
2. Haz clic en la pestaña **"Actions"**
3. Deberías ver un workflow llamado **"Compilar APK - Ecos del Tiempo"**

Si no aparece, asegúrate de que el archivo `.github/workflows/build-apk.yml` está en tu repositorio.

### Paso 4: Ejecutar la Compilación

**Opción A: Automática (Recomendada)**
- Cada vez que hagas `git push`, GitHub Actions compilará automáticamente el APK

**Opción B: Manual**
1. Ve a la pestaña **"Actions"**
2. Selecciona **"Compilar APK - Ecos del Tiempo"**
3. Haz clic en **"Run workflow"**
4. Selecciona la rama **"main"**
5. Haz clic en **"Run workflow"**

### Paso 5: Descargar el APK

1. Ve a la pestaña **"Actions"**
2. Haz clic en el workflow más reciente (aparecerá con un ✓ verde cuando termine)
3. Baja hasta **"Artifacts"**
4. Haz clic en **"ecos-del-tiempo-apk"** para descargar el ZIP
5. Extrae el ZIP y tendrás el archivo `ecos-del-tiempo.apk`

## 📱 Instalar en tu Celular

### Desde tu PC:
```bash
adb install ecos-del-tiempo.apk
```

### Directamente en tu celular:
1. Descarga el APK desde GitHub Actions
2. Abre el archivo con tu gestor de archivos
3. Toca "Instalar"
4. Permite la instalación de apps desconocidas si es necesario

## 🔄 Flujo de Trabajo Típico

```
Haces cambios en el código
        ↓
git add .
git commit -m "Descripción del cambio"
git push
        ↓
GitHub Actions compila automáticamente
        ↓
Descargas el APK
        ↓
Lo instalas en tu celular
```

## 📊 Monitorear la Compilación

En la pestaña **"Actions"**, verás:
- ✓ Verde: Compilación exitosa
- ✗ Roja: Error en la compilación
- ⏳ Amarilla: Compilando...

Haz clic en el workflow para ver los detalles.

## 🐛 Solucionar Problemas

### El workflow no aparece
- Asegúrate de que `.github/workflows/build-apk.yml` está en tu repositorio
- Espera 5 minutos después de hacer push

### La compilación falla
- Haz clic en el workflow fallido
- Lee los logs para ver el error
- Los errores comunes son:
  - Archivos faltantes
  - Sintaxis incorrecta en GDScript
  - Configuración de Android SDK

### El APK no se descarga
- Verifica que el workflow terminó con ✓ verde
- Los artefactos se guardan por 30 días
- Si pasó más tiempo, ejecuta el workflow nuevamente

## 💡 Consejos

1. **Commits descriptivos**: Usa mensajes claros
   ```bash
   git commit -m "Agregar nivel 2 con enemigos"
   ```

2. **Ramas para desarrollo**: Crea ramas para nuevas features
   ```bash
   git checkout -b feature/nuevo-nivel
   git push origin feature/nuevo-nivel
   ```

3. **Releases**: Para versiones finales, crea un tag
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
   Esto creará automáticamente un Release con el APK

## 🎯 Próximos Pasos

- Agrega más niveles y características
- Cada push compilará automáticamente
- Comparte el repositorio con otros desarrolladores
- Usa GitHub Issues para rastrear bugs

## 📚 Recursos

- [Documentación de GitHub Actions](https://docs.github.com/es/actions)
- [Documentación de Godot Export](https://docs.godotengine.org/es/stable/tutorials/export/index.html)
- [Android Debug Bridge (ADB)](https://developer.android.com/studio/command-line/adb)

---

¡Ahora tienes un flujo de trabajo profesional para compilar tu juego! 🎮✨
