extends CharacterBody2D

const VELOCIDAD = 120.0
const FUERZA_SALTO = -200.0
const GRAVEDAD = 600.0

var grabando = false
var registro_acciones = []
var tiempo_inicio_grabacion = 0.0
var puede_crear_eco = true
var eco_activo = false
var sprite: Sprite2D
var timer_grabacion: Timer
var ecos_creados = 0

func _ready():
	# Crear sprite pixel art del jugador
	sprite = Sprite2D.new()
	var imagen = Image.create(16, 16, false, Image.FORMAT_RGBA8)
	imagen.fill(Color(0.2, 0.4, 0.8))
	
	# Ojos
	imagen.set_pixel(5, 5, Color.WHITE)
	imagen.set_pixel(10, 5, Color.WHITE)
	
	# Boca
	imagen.set_pixel(7, 2, Color(0.8, 0.2, 0.2))
	imagen.set_pixel(8, 2, Color(0.8, 0.2, 0.2))
	
	sprite.texture = ImageTexture.create_from_image(imagen)
	sprite.scale = Vector2(3, 3)
	add_child(sprite)
	
	# Colisión
	var collision = CollisionShape2D.new()
	var forma = RectangleShape2D.new()
	forma.size = Vector2(12, 12)
	collision.shape = forma
	add_child(collision)
	
	# Cámara
	var camara = Camera2D.new()
	camara.position_smoothing_enabled = true
	camara.position_smoothing_speed = 5.0
	add_child(camara)
	
	# Timer para grabación
	timer_grabacion = Timer.new()
	timer_grabacion.wait_time = 4.0
	timer_grabacion.one_shot = true
	timer_grabacion.name = "TimerGrabacion"
	add_child(timer_grabacion)
	timer_grabacion.timeout.connect(_on_timer_timeout)
	
	# Optimizar para móvil
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		Engine.max_fps = 30

func _physics_process(delta):
	# Gravedad
	if not is_on_floor():
		velocity.y += GRAVEDAD * delta
	
	# Movimiento
	var direccion = Input.get_axis("move_left", "move_right")
	if direccion:
		velocity.x = direccion * VELOCIDAD
		sprite.flip_h = direccion < 0
	else:
		velocity.x = move_toward(velocity.x, 0, VELOCIDAD)
	
	# Salto
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = FUERZA_SALTO
	
	# Crear eco
	if Input.is_action_just_pressed("crear_eco") and puede_crear_eco and not grabando and not eco_activo:
		iniciar_grabacion()
	
	move_and_slide()
	
	# Registrar acciones durante grabación
	if grabando:
		var tiempo_actual = (Time.get_ticks_msec() - tiempo_inicio_grabacion) / 1000.0
		registro_acciones.append({
			"tiempo": tiempo_actual,
			"posicion": position,
			"velocidad": velocity,
			"direccion": direccion,
			"en_aire": not is_on_floor()
		})

func iniciar_grabacion():
	grabando = true
	registro_acciones = []
	tiempo_inicio_grabacion = Time.get_ticks_msec()
	puede_crear_eco = false
	sprite.modulate = Color(0.5, 0.5, 1.0)
	
	# Feedback táctil
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		Input.vibrate_handheld(30)
	
	timer_grabacion.start()

func _on_timer_timeout():
	if grabando:
		finalizar_grabacion()

func finalizar_grabacion():
	grabando = false
	sprite.modulate = Color.WHITE
	
	# Crear la escena del eco
	var eco_scene = load("res://scenes/Echo.tscn")
	if eco_scene:
		var eco = eco_scene.instantiate()
		eco.position = position
		eco.set_registro_acciones(registro_acciones.duplicate(true))
		get_parent().add_child(eco)
		eco_activo = true
		ecos_creados += 1
		
		await get_tree().create_timer(2.0).timeout
		puede_crear_eco = true
		eco_activo = false

func get_ecos_creados():
	return ecos_creados

func reset():
	grabando = false
	puede_crear_eco = true
	eco_activo = false
	ecos_creados = 0
	sprite.modulate = Color.WHITE
	velocity = Vector2.ZERO
