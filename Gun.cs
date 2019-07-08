using Godot;
using System;

public class Gun : Godot.Node2D
{
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";
    public bool Direction {get;set;} = true;
    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        
    }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
  public override void _Process(float delta)
  {
    if(Direction){
      this.Transform= new Transform2D(-1,0,0,1,0,0);
    }else{
      this.Transform= new Transform2D(1,0,0,1,0,0);
    }
      
  }
}
