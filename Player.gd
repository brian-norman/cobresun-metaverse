extends KinematicBody2D

export (int) var run_speed = 100
export (int) var jump_speed = -400
export (int) var gravity = 1200

var velocity = Vector2()
var jumping = false

const upDirection = Vector2(0, -1)

puppet var puppet_pos = Vector2()
puppet var puppet_velocity = Vector2()


func _ready():
	puppet_pos = position


func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed('ui_select')

	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed


func _physics_process(delta):
	if is_network_master():
		get_input()
		velocity.y += gravity * delta
		if jumping and is_on_floor():
			jumping = false
		
		rset("puppet_velocity", velocity)
		rset("puppet_pos", position)
	else:
		position = puppet_pos
		velocity = puppet_velocity
	
	if velocity.x < 0:
		$AnimatedSprite.play("left")
	elif velocity.x > 0:
		$AnimatedSprite.play("right")
	else:
		$AnimatedSprite.play("idle")
	
	velocity = move_and_slide(velocity, upDirection)
	
	if not is_network_master():
		puppet_pos = position # To avoid jitter


func set_player_name(name):
	$Name.text = name
