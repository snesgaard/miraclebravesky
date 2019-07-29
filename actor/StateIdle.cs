using Godot;
using System;

public class StateIdle : Node, IState
{
    public bool IsActive() => true;
    public void Activate() {}
    public void Deactivate() {}
    
    public void Update(){}
}

public interface IState
{
    bool IsActive();
    void Activate();
    void Update();
    void Deactivate();
}
