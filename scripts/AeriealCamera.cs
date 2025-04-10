using Godot;

public partial class AeriealCamera : Node3D
{
	private const float DragSpeed = 0.01f;
	
	private Camera3D _cam;
	
	private float _screenRatio;
	private bool _dragging;
	private bool _draggingLeft;
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
		_forwardVec = new Vector3(offset.X, 0, offset.Z).Normalized();
		_rightVec = new Vector3(_forwardVec.Z, 0, -_forwardVec.X).Normalized();
	}

	public override void _Input(InputEvent @event)
	{
		if (@event is InputEventMouseButton e)
		{	
			if (e.Pressed) 
			{	
				_dragging = true;
				_draggingLeft = e.ButtonIndex == MouseButton.Left;
			}
			else
			{	_dragging = false; }
		}
		else if (@event is InputEventMouseMotion m && _dragging) 
		{
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
}
