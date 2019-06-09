using Godot;
using System;

public class KinematicBody2D : Godot.KinematicBody2D
{
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        
    }

    public Vector2 velocity = new Vector2(0,0);
    static Vector2 gravity = new Vector2(0,400);
   public bool TouchingGround{get;set;}
//  // Called every frame. 'delta' is the elapsed time since the previous frame.
  public override void _PhysicsProcess(float delta)
  {
      
    velocity += gravity * delta;
    var info = this.MoveAndSlide(velocity);
    var dist = info.Length();
    int slideCount = GetSlideCount();
    velocity = info;
    TouchingGround = false;
    if(slideCount > 0){
      for(int i = 0; i < slideCount; i++){
        KinematicCollision2D col = GetSlideCollision(i);
        if(col.Collider is StaticBody2D collider || col.Collider is TileMap)
        {
            TouchingGround = true;
        }
      }
      
    }
	velocity.x *= 0.99f;
  }
}
