using Godot;
using System;
using System.Diagnostics;
public class StateWalking : Node, IState
{
    [Export]
    public string Activation{get;set;}
        public bool IsActive() =>  Input.IsActionPressed(Activation);
    public void Activate() 
    {
        Debug.WriteLine("Start Walking");
        
       }
    public void Deactivate()
    {
        Debug.WriteLine("Stop Walking");
        
    }

    public void Update(float dt){

    }
    
}

