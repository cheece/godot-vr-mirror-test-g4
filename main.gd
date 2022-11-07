extends Node3D


 
var interface : XRInterface

func _pre_draw():
	if(interface):  
		var lp = interface.get_transform_for_view(0, global_transform)
		var rp = interface.get_transform_for_view(1, global_transform)
		print(lp,rp)
func _ready():
	interface = XRServer.find_interface("OpenXR")
	if interface and interface.is_initialized():
		print("OpenXR initialised successfully")
		for p in interface.get_method_list():
			print(p["name"])
			
		get_viewport().use_xr = true
		
		
	else:
		print("OpenXR not initialised, please check if your headset is connected")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
