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
        Debug.WriteLine("Start " + this.Name);
        
       }
    public void Deactivate()
    {
        Debug.WriteLine("Stop " + this.Name);
        
    }

    public void Update(float dt){

    }
    
}

