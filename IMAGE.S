; Afficher une image en assembleur sur Atari ST
; Par Vretrocomputing, 2019.

	clr.w	-(sp)		;Basse r�solution
	move.l	#-1,-(sp)	;Ne pas changer l'adresse physique
	move.l	#-1,-(sp)	;Ne pas changer l'adresse logique
	move.w	#5,-(sp)	;Setscreen
	trap	#14		;XBIOS
	add.l	#12,sp

	DC.W	$a00a		;Line A 10 : Cacher souris

	move.l	#pi1+2,-(sp)	;Nouvelle palette
	move.w	#6,-(sp)	;Setpalette
	trap	#14		;XBIOS
	addq.l	#6,sp

	move.w	#3,-(sp)	;Logbase
	trap	#14		;XBIOS
	addq.l	#2,sp

	move.l	d0,a3		;Adresse du framebuffer

	move.l	#pi1+34,a0	;source
	move.l	a3,a1		;destination

	move.w	#32000/4-1,d0	;nombre de longs - 1
copie:
	move.l	(a0)+,(a1)+	;copier un long
	dbf	d0,copie

	move.w	#8,-(sp)	;Cnecin
	trap	#1		;GEMDOS
	addq.l	#2,sp

	clr.w	-(sp)		;Pterm0
	trap	#1		;GEMDOS

pi1:
	INCBIN	lenna.pi1