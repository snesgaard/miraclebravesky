using System.Diagnostics;
using Godot;

public class StartSwing : Node, IState
{
    
    [Export]
    public string Animation{get;set;}
    bool isActive = false;
    float time;
    public void Activate()
    {
        Debug.WriteLine("Start " + this.Name);
        var anim = FindParent("root").GetChild(1) as AnimationPlayer;
        anim.Play(Animation);
        time = anim.CurrentAnimationLength;
        isActive = true;
    }

    public void Deactivate()
    {
        Debug.WriteLine("Stop " + this.Name);
        //var anim = FindParent("root").GetChild(1) as AnimationPlayer;
        //anim.Stop();
    }

    public bool IsActive() => isActive;

    public void Update(float delta)
    {
        time -= delta;
        if(time < 0){
            isActive = false;
        }
        
    }
}
