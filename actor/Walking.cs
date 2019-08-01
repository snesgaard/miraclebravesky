using Godot;
using System;
using System.Diagnostics;

public class Walking : Node, IState
{
    int direction = 0;
    
    [Export]
    public float MaxRunSpeed {get;set;} = 200;

    public void Activate()
    {
        var parent = (StateMachine)GetParent();
        direction = parent.Active("WalkLeft") ? 1 : -1;
        Debug.WriteLine("Start " + this.Name);
    }

    public void Deactivate()
    {
        Debug.WriteLine("End " + this.Name);
    }

    public bool IsActive()
    {
        var parent = (StateMachine)GetParent();
        return parent.Active("WalkLeft") ^ parent.Active("WalkRight");
    }

    public void Update(float delta)
    {
        var root = GetParent().GetParent() as PlatformBody;
        var sprite = root.GetChild(0) as Sprite;
        
	    root.UpdateMotion(delta, MaxRunSpeed * direction);        
    }

}
