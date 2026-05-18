extends CharacterBody2D

const VELOCIDAD = 45.0
var direccion = 1
var sprite: Sprite2D
var tiempo_cambio = 2.0

func _ready():
	# Crear sprite del enemigo
	sprite = Sprite2D.new()
	var imagen = Image.create(16, 16, false, Image.FORMAT_RGBA8)
	imagen.fill(Color(1, 0.2, 0.2))
	
	# Ojos
	imagen.set_pixel(4, 5, Color.BLACK)
	imagen.set_pixel(11, 5, Color.BLACK)
	
	sprite.texture = ImageTexture.create_from_image(imagen)
	sprite.scale = Vector2(3, 3)
	add_child(sprite)
	
	# Colisión
	var collision = CollisionShape2D.new()
	var forma = RectangleShape2D.new()
	forma.size = Vector2(14, 14)
	collision.shape = forma
	add_child(collision)
	
	crear_patrulla()

func crear_patrulla():
	# Cambiar dirección cada 2 segundos
	while true:
		await get_tree().create_timer(tiempo_cambio).timeout
		direccion *= -1
		sprite.flip_h = direccion < 0

func _physics_process(delta):
	velocity.x = direccion * VELOCIDAD
	move_and_slide()
	
	# Daño al jugador
	for i in get_slide_collision_count():
		var colision = get_slide_collision(i)
		if colision.get_collider().name == "Player":
			reiniciar_nivel()

func reiniciar_nivel():
	get_tree().reload_current_scene()

func reset():
	direccion = 1
	sprite.flip_h = false
	velocity = Vector2.ZERO
