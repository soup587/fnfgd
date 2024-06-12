extends Node2D

@export_enum("0","1","3","4") var dir = "0"
var sprite
var speed = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $ArrowSprite
	match dir:
		"0":
			sprite.rotation_degrees = 270
		"1":
			sprite.rotation_degrees = 180
		"2":
			sprite.rotation_degrees = 0
		"3":
			sprite.rotation_degrees = 90

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= speed * delta
	
func hit():
	queue_free()
