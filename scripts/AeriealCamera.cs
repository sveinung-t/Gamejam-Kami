using Godot;

public partial class AeriealCamera : Node3D
{
	private const float DragSpeed = 0.01f;
	
	private Camera3D _cam;
	
	private float _screenRatio;
	private bool _dragging;
	private Vector3 _rightVec, _forwardVec;
	
	public override void _Ready()
	{
		_cam = GetNode<Camera3D>("Camera3D");
		Vector2 screenSize = GetViewport().GetVisibleRect().Size;
		_screenRatio = screenSize.Y / screenSize.X;
		_GetMoveVectors();
	}
	
	private void _GetMoveVectors()
	{
		Vector3 offset = _cam.GlobalPosition - GlobalPosition;
		_rightVec = _cam.Transform.Basis.X;
		_forwardVec = new Vector3(offset.X, 0, offset.Z).Normalized();
	}

	public override void _Input(InputEvent @event)
	{
		if (@event is InputEventMouseButton e)
		{	
			if (e.Pressed) 
			{	_dragging = true; }
			else
			{	_dragging = false; }
		}
		else if (@event is InputEventMouseMotion m && _dragging) 
		{
			GlobalPosition +=
				_rightVec * -m.Relative.X * DragSpeed +
				_forwardVec * -m.Relative.Y * DragSpeed / _screenRatio;
		}
	}
}
