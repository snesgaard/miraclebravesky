using Godot;
using System;

public class DoJump : Node, IState
{
    public void Activate()
    {
        var platformBody = GetParent().GetParentOrNull<PlatformBody>();
        platformBody.DoJump();
    }

    public void Deactivate()
    {
        
    }

    public bool IsActive()
    {
        var parent = GetParentOrNull<StateMachine>();
        return parent.Active("Jump") && parent.Active("TouchingGround");
    }

    public void Update(float delta)
    {
        
    }
}
