using Godot;

public class PlatformBody : KinematicBody2D
{

    Vector2 speed = new Vector2(0, 0);
    float JUMP_TIME = 0.20f;
    float JUMP_HEIGHT = 50.0f;

    float JUMP_SPEED => 2 * JUMP_HEIGHT / JUMP_TIME;
    float JUMP_GRAVITY => -JUMP_SPEED / (2 * JUMP_TIME);
    public void UpdateMotion(float dt, float speed)
    {
        UpdateMotion(dt, speed, new Vector2(0, -JUMP_GRAVITY));
    }

    public void UpdateMotion(float dt, float Speed, Vector2 gravity)
    {
        this.speed = speed + gravity * dt;
        speed = MoveAndSlide(speed, new Vector2(0, -1));
        if (this.IsOnFloor())
            speed.y = 0;
        if (this.IsOnWall())
            speed.x = 0;
    }

    public void DoJump(){
        System.Diagnostics.Debug.WriteLine("DoJump");
        this.speed.y -= 800;
    }
}
