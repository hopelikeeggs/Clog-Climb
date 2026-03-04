extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -500.0
const TRASH_GOAL = 1
const DRAIN_GOAL = 1

@onready var animated_sprite = $AnimatedSprite2D
@onready var interaction_area = $InteractionArea
@onready var anim = $AnimatedSprite2D

#Sound_Effects

@onready var run_sound = $runsound
@onready var jump_sound = $jumpsound
@onready var pickup_sound = $pickupsound


var pipe_fall := false
var is_picking_up := false
var trash_collected := 0
var drain_cleaned := 0
var can_take_damage := true
var max_health = 3
var health = 3 
var can_move = true

func start_pipe_fall():
	pipe_fall = true

func _ready():
	add_to_group("player")
	
	if animated_sprite.has_signal("animation_finished"):
		animated_sprite.animation_finished.connect(_on_anim_finished)

	await get_tree().process_frame 
	get_tree().call_group("ui", "update_hearts", health)
	get_tree().call_group("ui", "update_trash_count", trash_collected, TRASH_GOAL)
	get_tree().call_group("ui", "update_drain_count", drain_cleaned, DRAIN_GOAL)


func play_clean_animation():
	anim.play("drain_cleaning")
func _on_anim_finished():
	if animated_sprite.animation == "pick_up_trash":
		is_picking_up = false
		if pickup_sound.playing:
			pickup_sound.stop()
	if animated_sprite.animation == "drain_cleaning":
		is_picking_up = false

func _physics_process(delta: float) -> void:

	# TRASH = F
	if Input.is_action_just_pressed("pick_up") and is_on_floor() and not is_picking_up:
		check_for_trash()

	# DRAIN = W
	if Input.is_action_just_pressed("drain_pick_up") and is_on_floor() and not is_picking_up:
		check_for_drain()

	if is_picking_up:
		velocity.x = 0
		move_and_slide()
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	if not can_move:
		return

	var direction := Input.get_axis("move_Left", "move_Right")

	if direction > 0:
		animated_sprite.flip_h = false
		interaction_area.scale.x = 1
	elif direction < 0:
		animated_sprite.flip_h = true
		interaction_area.scale.x = -1

	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
			run_sound.stop()
		else:
			animated_sprite.play("run")
			if not run_sound.playing:
				run_sound.play()
	else:
		animated_sprite.play("jump")
		run_sound.stop()

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func check_for_trash():
	var targets = interaction_area.get_overlapping_areas()
	for area in targets:
		if area.is_in_group("trash"):
			is_picking_up = true
			velocity = Vector2.ZERO
			animated_sprite.play("pick_up_trash")
			
			if area.has_method("play_pickup"):
				area.play_pickup()
				
				await area.tree_exited
				
				is_picking_up = false
				animated_sprite.play("idle")
				trash_collected += 1
				get_tree().call_group("ui", "update_trash_count",trash_collected, TRASH_GOAL)
				print("Trash picked up! Total: ", trash_collected)
				
			
			break

func check_for_drain():
	var targets = interaction_area.get_overlapping_areas()
	
	for area in targets:
		if area.is_in_group("drain_trash"):
			is_picking_up = true
			velocity = Vector2.ZERO
			animated_sprite.play("drain_cleaning")
			
			if area.has_method("clean_drain"):
				area.clean_drain()
				
				await area.tree_exited
				
				is_picking_up = false
				animated_sprite.play("idle")
				get_tree().call_group("ui", "update_drain_count",drain_cleaned,DRAIN_GOAL)
				print("Drain cleaned!")
				
			
			break
func die():
	get_tree().paused = true
	get_tree().call_group("ui", "show_game_over")
	
func take_damage(amount: int):
	if not can_take_damage: return
	can_take_damage = false
	health -= amount
	get_tree().call_group("ui", "update_hearts", health)
	if health <= 0:
		die()
	else:
		animated_sprite.modulate = Color(1, 0, 0)
		await get_tree().create_timer(1.0).timeout
		animated_sprite.modulate = Color(1, 1, 1)
		can_take_damage = true
