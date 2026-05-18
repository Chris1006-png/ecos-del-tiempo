extends StaticBody2D

var abierta = false
var sprite: Sprite2D
var collision: CollisionShape2D

func _ready():
	add_to_group("puerta")
	
	# Crear sprite de la puerta
	sprite = Sprite2D.new()
	var imagen = Image.create(20, 20, false, Image.FORMAT_RGBA8)
	imagen.fill(Color(0.6, 0.4, 0.2))
	
	# Barrotes
	for i in range(0, 20, 4):
		imagen.set_pixel(i, 10, Color(0.3, 0.2, 0.1))
		imagen.set_pixel(i, 11, Color(0.3, 0.2, 0.1))
	
	sprite.texture = ImageTexture.create_from_image(imagen)
	sprite.scale = Vector2(2, 2)
	add_child(sprite)
	
	# Colisión
	collision = CollisionShape2D.new()
	var forma = RectangleShape2D.new()
	forma.size = Vector2(20, 20)
	collision.shape = forma
	add_child(collision)

func abrir():
	if not abierta:
		abierta = true
		
		# Animación de apertura
		var tween = create_tween()
		tween.tween_property(sprite, "modulate", Color.GREEN, 0.3)
		tween.tween_callback(func(): sprite.visible = false)
		tween.tween_callback(func(): collision.disabled = true)
		
		# Mostrar mensaje
		var label = Label.new()
		label.text = "¡Nivel superado!"
		label.position = Vector2(100, 80)
		label.add_theme_color_override("font_color", Color.GREEN)
		get_parent().add_child(label)
		
		await get_tree().create_timer(2.0).timeout
		get_tree().reload_current_scene()

func reset():
	abierta = false
	sprite.visible = true
	sprite.modulate = Color.WHITE
	collision.disabled = false
