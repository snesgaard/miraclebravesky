using Godot;
using System;
using System.Diagnostics;
public class StateWalking : Node, IState
{
    public bool IsActive() =>  Input.IsActionPressed("move_right") || Input.IsActionPressed("move_left");
    public void Activate() 
    {
        Debug.WriteLine("Start Walking");
        
       }
    public void Deactivate()
    {
        Debug.WriteLine("Stop Walking");
        
    }

    public void Update(){

    }
    
}

