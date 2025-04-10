using Godot;

public partial class CursorManager : Node
{
	Texture2D _defaultCursor;
	Texture2D _grabCursor;

	public override void _Ready()
	{
		_defaultCursor = ResourceLoader.Load<Texture2D>("res://Sprites/Cursor Pack/Default/hand_point.png");
		_grabCursor = ResourceLoader.Load<Texture2D>("res://Sprites/Cursor Pack/Default/hand_closed.png");

		Input.SetCustomMouseCursor(_defaultCursor);
	}

	public override void _Input(InputEvent @event)
	{
		if (@event is InputEventMouseButton e)
		{
			if (e.Pressed)
			{   Input.SetCustomMouseCursor(_grabCursor); }
			else
			{   Input.SetCustomMouseCursor(_defaultCursor); }
		}
	}
}
