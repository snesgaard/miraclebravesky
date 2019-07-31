using Godot;
using System;
using System.Diagnostics;

public class AttackAnimation : Node, IState
{
    float time;
    int sequence;
    bool animationRunning = false;
    IState currentNode;

    [Export]
    public string Activation{get;set;} = "Attack";
    public void Activate()
    {
        animationRunning = true;
        sequence = -1;
    }

    public void Deactivate()
    {

    }

    public bool IsActive()
    {
        return GetParentOrNull<StateMachine>().Active(Activation) || animationRunning;
    }

    public void Update(float delta)
    {
        int count = GetChildCount();
        
        while(!(currentNode?.IsActive() ?? false) && sequence < count){
            sequence += 1;
            Debug.WriteLine("Seq: " + sequence);
            if(currentNode != null)
                currentNode.Deactivate();
            if(sequence < count){
                currentNode = GetChild(sequence) as IState;
                currentNode.Activate();
            }
        }

        if(sequence == count){
            currentNode = null;
            sequence = -1;
            animationRunning = false;
        }else{
            currentNode.Update(delta);
        }
    }
}
