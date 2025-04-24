extends CharacterBody2D

enum PLAYER_STATE {
	ACTIONALBLE
}

const FRICTION = 400
const MAX_SPEED = 100
const ACCEELRATOIN = 300

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

var state = PLAYER_STATE.ACTIONALBLE

func _physics_process(delta: float) -> void:
	match state:
		PLAYER_STATE.ACTIONALBLE:
			run_movement(delta)
			
func run_movement(delta: float) -> void:
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector = inputVector.normalized()
	
	animationTree.set("parameters/Idle/blend_position", inputVector)
	animationTree.set("parameters/Walk/blend_position", inputVector)
	
	
	if(inputVector == Vector2.ZERO):
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
	else:
		animationState.travel("Walk")
		velocity = velocity.move_toward(inputVector * MAX_SPEED, delta * ACCEELRATOIN)
		
	move_and_slide()
