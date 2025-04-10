using Godot;

public partial class AeriealCamera : Node3D
{
	private CursorManager _cursorManager;
	private bool _hoveringOverSomethingLastFrame = false;
	
	private const float DragSpeed = 0.01f;
	
	private Camera3D _cam;
	
	private float _screenRatio;
	private bool _dragging;
	private bool _draggingLeft;
	private Vector3 _rightVec, _forwardVec;
	
	public override void _Ready()
	{
		_cursorManager = GetParent().GetNode<CursorManager>("CursorManager");
		_cam = GetNode<Camera3D>("Camera3D");
		Vector2 screenSize = GetViewport().GetVisibleRect().Size;
		_screenRatio = screenSize.Y / screenSize.X;
		_GetMoveVectors();
	}
	
	private void _GetMoveVectors()
	{
		Vector3 offset = _cam.GlobalPosition - GlobalPosition;
		_forwardVec = new Vector3(offset.X, 0, offset.Z).Normalized();
		_rightVec = new Vector3(_forwardVec.Z, 0, -_forwardVec.X).Normalized();
	}

	public override void _Input(InputEvent @event)
	{
		if (@event is InputEventMouseButton e)
		{	
			if (e.ButtonIndex == MouseButton.WheelUp || e.ButtonIndex == MouseButton.WheelDown)
			{ //Zoom
				if (_dragging) { return; }

				float newZoomSize = _cam.Size + 0.3f *
				(e.ButtonIndex == MouseButton.WheelUp ? -1f : 1f);
				_cam.Size = Mathf.Clamp(newZoomSize, 3f, 15f);
			}
			else
			{ //Pan
				if (e.Pressed) 
				{	
					_dragging = true;
					_draggingLeft = e.ButtonIndex == MouseButton.Left;
					_cursorManager.SetCursor(CursorManager.CursorType.Grab);
				}
				else
				{	
					_dragging = false;

					if (!IsMouseOverVoid())
					{	_cursorManager.SetCursor(CursorManager.CursorType.Select); }
					else
					{	_cursorManager.SetCursor(CursorManager.CursorType.Default); }	
				}
			}
		}
		else if (@event is InputEventMouseMotion m && _dragging) 
		{ //Rotate
			if  (_draggingLeft)
			{
				GlobalPosition +=
					_rightVec * -m.Relative.X * DragSpeed +
					_forwardVec * -m.Relative.Y * DragSpeed / _screenRatio;
			}
			else
			{
				RotateY(-m.Relative.X * 0.5f * DragSpeed);
				_GetMoveVectors();
			}
		}
	}

	private bool IsMouseOverVoid()
	{
		var mousePos = GetViewport().GetMousePosition();

		var spaceState = GetWorld3D().DirectSpaceState;
		var from = _cam.ProjectRayOrigin(mousePos);
		var to = from + _cam.ProjectRayNormal(mousePos) * 10000;

		var query = PhysicsRayQueryParameters3D.Create(from, to);
		query.CollideWithAreas = false; // optional
		query.CollideWithBodies = true;

		var result = spaceState.IntersectRay(query);

		return result.Count == 0;
	}

	public override void _Process(double delta)
	{
		// Only check when not dragging
		if (_dragging)
			return;

		bool isHovering = !IsMouseOverVoid();

		// Only update cursor if the state changed
		if (isHovering != _hoveringOverSomethingLastFrame)
		{
			_hoveringOverSomethingLastFrame = isHovering;

			if (isHovering)
				_cursorManager.SetCursor(CursorManager.CursorType.Select);
			else
				_cursorManager.SetCursor(CursorManager.CursorType.Default);
		}
	}

}
