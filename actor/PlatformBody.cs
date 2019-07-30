using Godot;
using System;

public class PlatformBody : KinematicBody2D
{

    Vector2 speed = new Vector2(0, 0);
float JUMP_TIME = 0.20f;
float JUMP_HEIGHT = 50.0f;

float JUMP_SPEED => 2 * JUMP_HEIGHT / JUMP_TIME;
float JUMP_GRAVITY => -JUMP_SPEED / (2 * JUMP_TIME);
public void UpdateMotion(float dt, float speed){
    UpdateMotion(dt, speed, new Vector2(0, -JUMP_GRAVITY));
}

public void UpdateMotion(float dt, float Speed, Vector2 gravity)
{
	this.speed = speed + gravity * dt;
	speed = MoveAndSlide(speed,new Vector2(0, -1));
    if(this.IsOnFloor())
        speed.y = 0;
	if(this.IsOnWall())
		speed.x = 0;
}

    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        
    }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
