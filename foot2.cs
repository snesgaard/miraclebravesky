using Godot;
using System;

public class foot2 : Area2D
{
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        
    }
    public bool IsTouching{get;set;}
    public override void _PhysicsProcess(float delta){
        var areas = GetOverlappingBodies();
        IsTouching = false;
        foreach(var body in areas){
            if(body is TileMap || body is StaticBody2D){
                IsTouching = true;

                break;
            }
         }
    }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
    
}
