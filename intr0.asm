cwd             	; "clear" DX for perfect alignment
hlt					; sync to timer1
mov 	al,0x13
X: 		int 0x10	; set video mode AND draw pixel
mov 	ax,cx		; get column in AH
add		ax,di		; offset by framecounter
xor 	al,ah		; the famous XOR pattern
and 	al,32+8		; a more interesting variation of it
mov 	ah,0x0C		; set subfunction "set pixel" for int 0x10
loop 	X			; loop 65536 times
inc bx				; increment counter for sound
mov ax,bx			; get current value in counter
xor  al,0x4B		; melody pattern + 2LSB for speaker link
out 0x42,al 		; set new coutdown for timer 2 (2 passes)
out 0x61,al 		; link timer2 to pc speaker (2 lbs are 1)
inc 	di			; increment framecounter
in 		al,0x60		; check keyboard ...
dec 	al			; ... for ESC
jnz 	X			; rinse and repeat
ret					; quit program