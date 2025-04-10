using Godot;
using System.Collections.Generic;

public partial class CursorManager : Node
{
	public enum CursorType
	{
		Default,
		Grab,
		Select
	}

    public void SetCursorFromString(string type)
    {
        switch (type.ToLower())
        {
            case "default":
                default:
                SetCursor(CursorType.Default);
                break;
            case "grab":
                SetCursor(CursorType.Grab);
                break;
            case "select":
                SetCursor(CursorType.Select);
                break;
        }
    }

	private Dictionary<CursorType, Texture2D> _cursors = new Dictionary<CursorType, Texture2D>();

	public override void _Ready()
	{
		_cursors[CursorType.Default] = LoadCursor("hand_open.png");
		_cursors[CursorType.Grab] = LoadCursor("hand_closed.png");
        _cursors[CursorType.Select] = LoadCursor("hand_point.png");

        SetCursor(CursorType.Default);
	}

	private Texture2D LoadCursor(string name)
	{
		return ResourceLoader.Load<Texture2D>($"res://Sprites/Cursor Pack/{name}");
	}

	public void SetCursor(CursorType type)
	{
		if (_cursors.TryGetValue(type, out var texture))
		{   Input.SetCustomMouseCursor(texture); }
	}
}
