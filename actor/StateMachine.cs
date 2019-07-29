using Godot;
using System;
using System.Linq;
using System.Collections.Generic;
public class StateMachine : Godot.Node
{
  HashSet<int> nodes = new HashSet<int>();

  public override void _Process(float delta)
  {
    foreach(Node node in this.GetChildren())
    {
        if(node is IState state){
            var id = node.GetInstanceId();
            bool wasActive = nodes.Contains(id);
            if(state.IsActive()){
                if(!wasActive){
                    state.Activate();
                    nodes.Add(id);
                }
                state.Update();
            }else{
                if(wasActive){
                    state.Deactivate();
                    nodes.Remove(id);
                }
            }
        }
    }
  }
}
