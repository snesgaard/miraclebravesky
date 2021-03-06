using Godot;
using System;

public class InputHandler : Node2D
{
    [Export]
    public float MaxSpeed{get;set;} = 100;
    [Export]
    public float MoveSpeed{get;set;} = 5;
    [Export]
    public float JumpSpeed{get;set;} = 100;

   public override void _Input(InputEvent evt){
     if(evt is InputEventKey key){
       if(key.Scancode == (int)KeyList.Control){
          var kin = this.GetParent() as KinematicBody2D;
      
          (kin.GetNode("Gun") as Gun).Fire();       }
       
     }
   }

  public override void _Process(float delta)
  {
      var kin = this.GetParent() as KinematicBody2D;
      var foot = kin.GetNode("foot2") as foot2;
      float MaxSpeed = this.MaxSpeed;
      if(foot.IsTouching == false){
        //MaxSpeed = 50;
      }
      float addedSpeed = 0;
      if(Input.IsKeyPressed((int)KeyList.Left))
          addedSpeed += -1;
      
      if(Input.IsKeyPressed((int)KeyList.Right))
          addedSpeed += 1;

      if(addedSpeed == 0){
        kin.velocity.x *= 0.4f;
      }
    
      if(addedSpeed < 0){
        (kin.GetNode("Gun") as Gun).Direction = true;
        }else if (addedSpeed > 0){
         (kin.GetNode("Gun") as Gun).Direction = false;    
      }
    
    
      if(Input.IsKeyPressed((int) KeyList.Space) && foot.IsTouching){
        kin.velocity.y = -JumpSpeed;
        kin.TouchingGround = false;
      }
      addedSpeed *= MoveSpeed;
      var absSpeed = addedSpeed + kin.velocity.x;
      if(absSpeed > MaxSpeed && kin.velocity.x < MaxSpeed){
        kin.velocity.x = MaxSpeed;
      }else if(absSpeed < -MaxSpeed && kin.velocity.x > -MaxSpeed){
        kin.velocity.x = -MaxSpeed;
      }else if( Math.Abs(kin.velocity.x) < MaxSpeed){
        kin.velocity.x += addedSpeed;
      }
  
  }
}
