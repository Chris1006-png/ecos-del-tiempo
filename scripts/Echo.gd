extends CharacterBody2D

var registro_acciones = []
var indice_accion = 0
var tiempo_nacimiento = 0.0
var activo = true
var sprite: Sprite2D
var tiempo_vida = 8.0
var tipo_eco = "normal"  # normal, rapido, pesado, explosivo, congelador

func _ready():
	tiempo_nacimiento = Time.get_ticks_msec() / 1000.0
	
	# Crear sprite fantasma
	sprite = Sprite2D.new()
	var imagen = Image.create(16, 16, false, Image.FORMAT_RGBA8)
	
	# Cambiar color según tipo de eco
	match tipo_eco:
		"rapido":
			imagen.fill(Color(1, 1, 0, 0.5))  # Amarillo
			tiempo_vida = 5.0
		"pesado":
			imagen.fill(Color(0.5, 0.5, 0.5, 0.5))  # Gris
			tiempo_vida = 10.0
		"explosivo":
			imagen.fill(Color(1, 0.5, 0, 0.5))  # Naranja
			tiempo_vida = 6.0
		"congelador":
			imagen.fill(Color(0, 1, 1, 0.5))  # Cian
			tiempo_vida = 7.0
		_:
			imagen.fill(Color(0, 0.8, 0.8, 0.5))  # Cian por defecto
	
	# Ojos fantasma
	imagen.set_pixel(5, 5, Color(0.5, 1, 1))
	imagen.set_pixel(10, 5, Color(0.5, 1, 1))
	
	sprite.texture = ImageTexture.create_from_image(imagen)
	sprite.scale = Vector2(3, 3)
	sprite.modulate = Color(0, 1, 1, 0.7)
	add_child(sprite)
	
	# Colisión
	var collision = CollisionShape2D.new()
	var forma = RectangleShape2D.new()
	forma.size = Vector2(12, 12)
	collision.shape = forma
	add_child(collision)
	
	# Autoeliminar después de tiempo_vida segundos
	await get_tree().create_timer(tiempo_vida).timeout
	destruir()

func _physics_process(delta):
	if not activo or registro_acciones.is_empty():
		return
	
	var tiempo_actual = (Time.get_ticks_msec() / 1000.0) - tiempo_nacimiento
	
	while indice_accion < registro_acciones.size() and registro_acciones[indice_accion]["tiempo"] <= tiempo_actual:
		var accion = registro_acciones[indice_accion]
		global_position = accion["posicion"]
		velocity = accion["velocidad"]
		if accion.has("direccion"):
			sprite.flip_h = accion["direccion"] < 0
		indice_accion += 1
	
	if not is_on_floor():
		velocity.y += 600.0 * delta
	
	move_and_slide()

func set_registro_acciones(acciones: Array):
	registro_acciones = acciones

func set_tipo_eco(tipo: String):
	tipo_eco = tipo

func destruir():
	activo = false
	# Efecto de desvanecimiento
	var tween = create_tween()
	tween.tween_property(sprite, "modulate:a", 0.0, 0.5)
	await tween.finished
	queue_free()

func get_tipo_eco():
	return tipo_eco
