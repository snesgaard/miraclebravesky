using Godot;
using System.Collections.Generic;
public class StateMachine : Godot.Node
{
  HashSet<string> nodes = new HashSet<string>();

  public override void _Process(float delta)
  {
    foreach(Node node in this.GetChildren())
    {
        if(node is IState state){
            var id = node.Name;
            bool wasActive = nodes.Contains(id);
            if(state.IsActive()){
                if(!wasActive){
                    state.Activate();
                    nodes.Add(id);
                }
                state.Update(delta);
            }else{
                if(wasActive){
                    state.Deactivate();
                    nodes.Remove(id);
                }
            }
        }
    }
  }

  public bool Active(string name) => nodes.Contains(name);

}
