extends Area2D

var activado = false
var sprite: Sprite2D
var puerta_ref: Node = null

func _ready():
	# Crear sprite del botón
	sprite = Sprite2D.new()
	var imagen = Image.create(16, 16, false, Image.FORMAT_RGBA8)
	imagen.fill(Color(1, 0.5, 0))
	imagen.set_pixel(7, 7, Color(0.8, 0.3, 0))
	imagen.set_pixel(8, 8, Color(0.8, 0.3, 0))
	sprite.texture = ImageTexture.create_from_image(imagen)
	sprite.scale = Vector2(2, 2)
	add_child(sprite)
	
	# Colisión
	var collision = CollisionShape2D.new()
	var forma = RectangleShape2D.new()
	forma.size = Vector2(16, 16)
	collision.shape = forma
	add_child(collision)
	
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if not activado and (body.name == "Player" or body.name.contains("Echo")):
		activado = true
		sprite.modulate = Color.GREEN
		
		# Buscar puerta en el nivel
		var nivel = get_parent()
		for hijo in nivel.get_children():
			if hijo.is_in_group("puerta"):
				puerta_ref = hijo
				puerta_ref.abrir()
				break

func reset():
	activado = false
	sprite.modulate = Color(1, 0.5, 0)
