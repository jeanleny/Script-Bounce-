extends Area2D



func _on_area_entered(area):
	if area.name == ("ball_Hitbox") :
		print(Balle.rebond)
		Balle.rebond += 1
		if Balle.rebond >= 2 :
			Balle.rebond = 0
			Balle.combo = 0
			Balle.veloce = Vector2 (2500,-2000)
			Balle.damp = -0.01
			$Fail.play()

