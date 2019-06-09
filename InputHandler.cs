using Godot;
using System;

public class InputHandler : Node2D
{
    [Export]
    public double MaxSpeed{get;set;} = 100;
    
  public override void _Process(float delta)
  {
      var kin = this.GetParent() as KinematicBody2D;
      if(kin.TouchingGround == false) return;
      float addedSpeed = 0.0f;
      if(Input.IsKeyPressed((int)KeyList.Left))
          addedSpeed -= 5;
      
      if(Input.IsKeyPressed((int)KeyList.Right))
          addedSpeed += 5;
      if(Input.IsKeyPressed((int) KeyList.Space)){
        kin.velocity.y = -100;
        kin.TouchingGround = false;
      }
    float prev = kin.velocity.x;
    kin.velocity.x += addedSpeed;
    
  }
}
