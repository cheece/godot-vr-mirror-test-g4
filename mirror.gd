extends MeshInstance3D

@export var left_camera: Camera3D
@export var right_camera: Camera3D 
@export var origin: XROrigin3D
@export var leftvp:SubViewport  
@export var rightvp:SubViewport 

@export var text: Texture2D
# Called when the node enters the scene tree for the first time.
func _ready():
	RenderingServer.connect("frame_pre_draw", update_mirror)
	var m = get_surface_override_material(0)
	m.set("shader_parameter/textureL", leftvp.get_texture())
	m.set("shader_parameter/textureR", rightvp.get_texture())
	set_surface_override_material(0, m)
var nbasis:Basis
var ibasis:Basis

var w_scale:float
func update_mirror():
	if(XRServer.primary_interface):
		render_view(0, left_camera)
		render_view(1, right_camera)
		nbasis = global_transform.basis.orthonormalized()
		ibasis = nbasis.inverse()
		w_scale = global_transform.basis.x.length() 
func render_view(view_index, cam: Camera3D):
	var pin = XRServer.primary_interface 
	var tx = pin.get_transform_for_view(view_index, origin.global_transform)

	var p = ibasis*(tx.origin- global_transform.origin)
	p.z*=-1
	cam.global_transform.basis = Basis(-nbasis.x,nbasis.y, -nbasis.z)
	cam.global_transform.origin = global_transform.origin +  nbasis*p
	#print(abs(p.z))
	cam.set_frustum(w_scale,Vector2( p.x,-p.y), abs(p.z),10000)
	
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
