extends CharacterBody2D

signal health_changed

var run_speed = 200
var attacking = false
var sprint_speed = run_speed * 2
var health = 5

func _physics_process(delta):
	var input = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("sprint"):
		velocity = input * sprint_speed
	else:
		velocity = input * run_speed
	if attacking:
		velocity = Vector2.ZERO
		return
	move_and_slide()
	#pick which animation
	if velocity.length() > 0:
		$AnimationPlayer.play("run")
	else:
		$AnimationPlayer.play("idle")
	#handle flipping direction
	if velocity.x != 0:
		transform.x.x = sign(velocity.x)

func _input(event):
	if event.is_action_pressed("attack"):
		attack()

func attack():
	$AnimationPlayer.play("attack")
	attacking = true
	await $AnimationPlayer.animation_finished
	attacking = false

func _on_hurtbox_body_entered(body):
	body.hurt(1, position.direction_to(body.position))
	
