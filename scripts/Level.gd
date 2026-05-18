extends Node2D

var jugador: CharacterBody2D
var tilemap: TileMap
var nivel_numero = 1

func _ready():
	crear_fondo()
	crear_suelo()
	crear_jugador()
	crear_interfaz_tactil()
	
	# Cargar elementos específicos del nivel
	match nivel_numero:
		1:
			crear_nivel_1()
		2:
			crear_nivel_2()
		3:
			crear_nivel_3()
		_:
			crear_nivel_1()

func crear_fondo():
	var fondo = ColorRect.new()
	fondo.color = Color(0.05, 0.05, 0.1)
	fondo.size = Vector2(360, 640)
	fondo.position = Vector2.ZERO
	fondo.z_index = -10
	add_child(fondo)

func crear_suelo():
	# Crear suelo simple
	var suelo = StaticBody2D.new()
	suelo.position = Vector2(180, 600)
	
	var sprite = Sprite2D.new()
	var imagen = Image.create(360, 40, false, Image.FORMAT_RGBA8)
	imagen.fill(Color(0.3, 0.2, 0.1))
	
	# Textura de pasto
	for x in range(360):
		for y in range(5):
			imagen.set_pixel(x, y, Color(0.2, 0.5, 0.1))
	
	sprite.texture = ImageTexture.create_from_image(imagen)
	sprite.scale = Vector2(1, 1)
	suelo.add_child(sprite)
	
	var collision = CollisionShape2D.new()
	var forma = RectangleShape2D.new()
	forma.size = Vector2(360, 40)
	collision.shape = forma
	suelo.add_child(collision)
	
	add_child(suelo)

func crear_jugador():
	jugador = load("res://scenes/Player.tscn").instantiate()
	if not jugador:
		# Crear manualmente si no existe la escena
		jugador = CharacterBody2D.new()
		jugador.name = "Player"
		jugador.position = Vector2(50, 500)
		jugador.set_script(load("res://scripts/Player.gd"))
	else:
		jugador.position = Vector2(50, 500)
	
	add_child(jugador)

func crear_nivel_1():
	# Nivel 1: Tutorial simple
	var puerta = load("res://scenes/Door.tscn").instantiate()
	if not puerta:
		puerta = StaticBody2D.new()
		puerta.name = "Door"
		puerta.position = Vector2(300, 550)
		puerta.set_script(load("res://scripts/Door.gd"))
	else:
		puerta.position = Vector2(300, 550)
	
	add_child(puerta)
	
	var boton = load("res://scenes/Button.tscn").instantiate()
	if not boton:
		boton = Area2D.new()
		boton.name = "Button"
		boton.position = Vector2(150, 550)
		boton.set_script(load("res://scripts/Button.gd"))
	else:
		boton.position = Vector2(150, 550)
	
	add_child(boton)

func crear_nivel_2():
	# Nivel 2: Con enemigo
	var puerta = load("res://scenes/Door.tscn").instantiate()
	if not puerta:
		puerta = StaticBody2D.new()
		puerta.position = Vector2(300, 550)
		puerta.set_script(load("res://scripts/Door.gd"))
	else:
		puerta.position = Vector2(300, 550)
	
	add_child(puerta)
	
	var enemigo = load("res://scenes/Enemy.tscn").instantiate()
	if not enemigo:
		enemigo = CharacterBody2D.new()
		enemigo.position = Vector2(180, 550)
		enemigo.set_script(load("res://scripts/Enemy.gd"))
	else:
		enemigo.position = Vector2(180, 550)
	
	add_child(enemigo)

func crear_nivel_3():
	# Nivel 3: Múltiples botones
	var puerta = load("res://scenes/Door.tscn").instantiate()
	if not puerta:
		puerta = StaticBody2D.new()
		puerta.position = Vector2(300, 550)
		puerta.set_script(load("res://scripts/Door.gd"))
	else:
		puerta.position = Vector2(300, 550)
	
	add_child(puerta)
	
	for i in range(3):
		var boton = load("res://scenes/Button.tscn").instantiate()
		if not boton:
			boton = Area2D.new()
			boton.set_script(load("res://scripts/Button.gd"))
		
		boton.position = Vector2(80 + i * 60, 550)
		add_child(boton)

func crear_interfaz_tactil():
	if OS.get_name() != "Android" and OS.get_name() != "iOS":
		return
	
	var canvas = CanvasLayer.new()
	
	# Crear botones táctiles
	var botones_info = [
		{"pos": Vector2(30, 580), "action": "move_left", "texto": "◀"},
		{"pos": Vector2(90, 580), "action": "move_right", "texto": "▶"},
		{"pos": Vector2(240, 580), "action": "jump", "texto": "▲"},
		{"pos": Vector2(300, 580), "action": "crear_eco", "texto": "E"}
	]
	
	for info in botones_info:
		var btn = TouchScreenButton.new()
		btn.position = info["pos"]
		btn.action = info["action"]
		btn.shape = RectangleShape2D.new()
		btn.shape.size = Vector2(50, 50)
		
		var label = Label.new()
		label.text = info["texto"]
		label.add_theme_color_override("font_color", Color.WHITE)
		label.position = Vector2(15, 15)
		btn.add_child(label)
		
		canvas.add_child(btn)
	
	add_child(canvas)
