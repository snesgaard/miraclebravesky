using Godot;
using System;
public class Delay : Node, IState
{
    bool isActive = false;
    float time = 0;
    [Export]
    public float DelayValue{get;set;}
    public void Activate()
    {
        isActive = true;
        time = 0;
        System.Diagnostics.Debug.WriteLine("Delay start...");
    }

    public void Deactivate()
    {
        System.Diagnostics.Debug.WriteLine("Delay stop...");
    }

    public bool IsActive() => isActive;

    public void Update(float delta)
    {
        time += delta;
        if(time > DelayValue)
            isActive = false; 
    }
}
