using Godot;
using System.Diagnostics;

public class TouchingGround : Node, IState
{
    public void Activate()
    {
        Debug.WriteLine("Touching Ground!");
    }

    public void Deactivate()
    {
        Debug.WriteLine("Not touching Ground!");
    }

    public bool IsActive() => GetParent().GetParentOrNull<KinematicBody2D>().IsOnFloor();

    public void Update(float delta)
    {
        
    }
}
