# Ecos del Tiempo - Juego Godot para Móvil

Un juego 2D pixel art donde controlas a un personaje que puede dejar "ecos" de sí mismo para resolver puzzles creativos.

## 📱 Instalación en Celular

### Opción 1: Godot Mobile (Recomendado)

1. Descarga **Godot Mobile** desde Google Play Store (búsca "Godot Engine")
2. Descarga este proyecto como ZIP
3. En Godot Mobile, selecciona "Open Project" → "Import"
4. Selecciona la carpeta del proyecto
5. ¡Listo! El juego se abrirá automáticamente

### Opción 2: Compilar como APK

Si tienes Godot en tu PC:
1. Abre el proyecto en Godot 4.3+
2. Ve a Proyecto → Exportar
3. Configura Android (necesitas Android SDK)
4. Exporta como APK
5. Transfiere el APK a tu celular e instala

## 🎮 Controles

- **◀ ▶**: Movimiento izquierda/derecha
- **▲**: Saltar
- **E**: Crear eco (graba 4 segundos de tus acciones)

## 🎯 Mecánica

1. Presiona **E** para comenzar a grabar un eco
2. Tienes **4 segundos** para moverte, saltar y activar botones
3. Después de 4 segundos, aparecerá un **eco azul** que repetirá exactamente tus movimientos
4. Usa los ecos para:
   - Activar botones simultáneamente
   - Distraer enemigos
   - Formar plataformas temporales
   - Resolver puzzles

## 📁 Estructura del Proyecto

```
ecos-godot/
├── project.godot          # Configuración del proyecto
├── scripts/               # Todos los scripts GDScript
│   ├── Player.gd         # Lógica del jugador
│   ├── Echo.gd           # Lógica de los ecos
│   ├── Level.gd          # Lógica del nivel
│   ├── Button.gd         # Botones interactivos
│   ├── Door.gd           # Puertas
│   └── Enemy.gd          # Enemigos
└── scenes/               # Escenas TSCN
    ├── Player.tscn
    ├── Echo.tscn
    ├── Level1.tscn
    ├── Button.tscn
    ├── Door.tscn
    └── Enemy.tscn
```

## 🎨 Características

- ✅ Gráficos pixel art minimalistas
- ✅ Controles simples y responsivos
- ✅ Mecánica de ecos temporal
- ✅ Niveles progresivos
- ✅ Optimizado para móviles de bajos recursos
- ✅ Interfaz táctil adaptada
- ✅ Física simple pero efectiva

## 🚀 Próximas Mejoras

- Más niveles con dificultad progresiva
- Habilidades especiales de eco (rápido, pesado, explosivo, congelador)
- Sistema de puntuación y logros
- Música y sonidos ambientales
- Efectos visuales mejorados
- Menú principal y pausa

## 📝 Notas Técnicas

- **Motor**: Godot 4.3+
- **Lenguaje**: GDScript
- **Plataformas**: Android, iOS, PC
- **Tamaño**: ~5MB
- **Requisitos**: Android 9.0+ o iOS 12.0+

## 🎓 Cómo Modificar

Todos los scripts están comentados y son fáciles de editar:

1. Abre el proyecto en Godot
2. Edita los scripts en `scripts/`
3. Prueba presionando F5 (o el botón Play)
4. Guarda cambios

## ⚠️ Troubleshooting

**El juego no abre en Godot Mobile:**
- Asegúrate de tener Godot Mobile v4.0+
- Verifica que todos los archivos estén en la carpeta correcta
- Intenta eliminar la carpeta `.godot` y reimportar

**Los controles no funcionan:**
- Verifica que el archivo `project.godot` esté en la raíz
- Revisa que las acciones de entrada estén configuradas

**El juego va lento:**
- Reduce la resolución en `project.godot`
- Cierra otras apps en tu celular
- Verifica que tengas suficiente almacenamiento

---

¡Disfruta jugando Ecos del Tiempo! 🎮✨
