	.file	"main.c"
	.arch msp430g2553
	.cpu 430
	.mpy none

	.text
.Ltext0:
	.comm BitCnt,1
	.comm TXByte,2,2
	.comm data,1
	.local Times
	.comm Times,8,2
.global	i
.global	i
	.section	.bss
	.type	i,@object
	.size	i,2
i:
	.skip 2,0
.global	velocity
.global	velocity
	.type	velocity,@object
	.size	velocity,4
velocity:
	.skip 4,0
.global	capture
.global	capture
	.type	capture,@object
	.size	capture,2
capture:
	.skip 2,0
.global	pulsecount
.global	pulsecount
	.type	pulsecount,@object
	.size	pulsecount,2
pulsecount:
	.skip 2,0
.global	overflowcounter
.global	overflowcounter
	.type	overflowcounter,@object
	.size	overflowcounter,2
overflowcounter:
	.skip 2,0
	.comm Mode,2,2
	.section	.init9,"ax",@progbits
	.p2align 1,0
.global	main
	.type	main,@function
/***********************
 * Function `main' 
 ***********************/
main:
.LFB0:
	.file 1 "main.c"
	.loc 1 40 0
	.loc 1 43 0
	mov	#23168, &__WDTCTL
	.loc 1 46 0
	mov.b	&__CALBC1_16MHZ, r15
	mov.b	r15, &__BCSCTL1
	.loc 1 47 0
	mov.b	&__CALDCO_16MHZ, r15
	mov.b	r15, &__DCOCTL
	.loc 1 48 0
	mov.b	&__BCSCTL2, r15
	and.b	#llo(-7), r15
	mov.b	r15, &__BCSCTL2
	.loc 1 50 0
	call	#InitializeButton
	.loc 1 53 0
	mov.b	&__P1DIR, r15
	bis.b	#81, r15
	mov.b	r15, &__P1DIR
	.loc 1 54 0
	mov.b	&__P1OUT, r15
	and.b	#llo(-82), r15
	mov.b	r15, &__P1OUT
	.loc 1 57 0
	mov.b	&__P1DIR, r15
	bis.b	#2, r15
	mov.b	r15, &__P1DIR
	.loc 1 58 0
	mov.b	&__P1OUT, r15
	bis.b	#2, r15
	mov.b	r15, &__P1OUT
	.loc 1 61 0
	mov.b	&__P2DIR, r15
	bis.b	#14, r15
	mov.b	r15, &__P2DIR
	.loc 1 62 0
	mov.b	&__P2SEL, r15
	bis.b	#2, r15
	mov.b	r15, &__P2SEL
	.loc 1 64 0
	mov	#0, &Mode
	.loc 1 65 0
	call	#PreApplicationMode
	.loc 1 68 0
	mov	#332, r15
.L2:
	dec	r15
	cmp	#0, r15
	jne	.L2
	nop
	nop
	.loc 1 70 0
	eint
	.loc 1 73 0
	mov	#720, &__TA1CTL
	.loc 1 74 0
	mov	#50, &__TA1CCR0
	.loc 1 75 0
	mov	#25, &__TA1CCR1
	.loc 1 76 0
	mov	#224, &__TA1CCTL1
.L6:
	.loc 1 82 0
	mov.b	&__P2OUT, r15
	bis.b	#12, r15
	mov.b	r15, &__P2OUT
	.loc 1 83 0
	mov.b	&__P1OUT, r15
	bis.b	#16, r15
	mov.b	r15, &__P1OUT
	.loc 1 85 0
	mov	#0, &pulsecount
	jmp	.L3
.L4:
	.loc 1 85 0 is_stmt 0 discriminator 2
	mov	&pulsecount, r15
	add	#1, r15
	mov	r15, &pulsecount
.L3:
	.loc 1 85 0 discriminator 1
	mov	&pulsecount, r15
	cmp	#400, r15
	jl	.L4
	.loc 1 87 0 is_stmt 1
	mov.b	&__P2OUT, r15
	and.b	#llo(-5), r15
	mov.b	r15, &__P2OUT
	.loc 1 88 0
	mov.b	&__P1OUT, r15
	and.b	#llo(-17), r15
	mov.b	r15, &__P1OUT
	.loc 1 89 0
	mov.b	&__P2OUT, r15
	and.b	#llo(-9), r15
	mov.b	r15, &__P2OUT
	.loc 1 91 0
	mov	#1, &capture
	.loc 1 93 0
	mov	#738, &__TA0CTL
	.loc 1 94 0
	mov	#llo(-16112), &__TA0CCTL1
	.loc 1 96 0
	mov.b	&__P1SEL, r15
	bis.b	#4, r15
	mov.b	r15, &__P1SEL
	.loc 1 98 0
	bis	#24, r2
	.loc 1 101 0
	mov	#0, &capture
	.loc 1 102 0
	mov	&__TA0CTL, r15
	and	#llo(-3), r15
	mov	r15, &__TA0CTL
	.loc 1 104 0
	call	#ConfigureTimerUart
	.loc 1 107 0
	mov	&velocity, r14
	mov	&velocity+2, r15
	mov.b	r14, r15
	mov.b	r15, r15
	mov	r15, &TXByte
	.loc 1 108 0
	call	#Transmit
	.loc 1 110 0
	mov.b	&__P1OUT, r15
	xor.b	#1, r15
	mov.b	r15, &__P1OUT
	.loc 1 113 0
	mov	#1, r15
.L5:
	dec	r15
	cmp	#0, r15
	jne	.L5
	nop
	.loc 1 115 0
	jmp	.L6
.LIRD0:
.LFE0:
.Lfe1:
	.size	main,.Lfe1-main
;; End of function 

	.text
	.p2align 1,0
.global	PreApplicationMode
	.type	PreApplicationMode,@function
/***********************
 * Function `PreApplicationMode' 
 ***********************/
PreApplicationMode:
.LFB1:
	.loc 1 121 0
	.loc 1 122 0
	mov.b	&__P1DIR, r15
	bis.b	#65, r15
	mov.b	r15, &__P1DIR
	.loc 1 123 0
	mov.b	&__P1OUT, r15
	bis.b	#1, r15
	mov.b	r15, &__P1OUT
	.loc 1 124 0
	mov.b	&__P1OUT, r15
	and.b	#llo(-65), r15
	mov.b	r15, &__P1OUT
	.loc 1 129 0
	mov.b	&__BCSCTL1, r15
	bis.b	#16, r15
	mov.b	r15, &__BCSCTL1
	.loc 1 130 0
	mov.b	&__BCSCTL3, r15
	bis.b	#32, r15
	mov.b	r15, &__BCSCTL3
	.loc 1 138 0
	mov	#1200, &__TA0CCR0
	.loc 1 139 0
	mov	#272, &__TA0CTL
	.loc 1 140 0
	mov	#112, &__TA0CCTL1
	.loc 1 141 0
	mov	#600, &__TA0CCR1
	.loc 1 142 0
	bis	#216, r2
	.loc 1 144 0
	ret
.LFE1:
.Lfe2:
	.size	PreApplicationMode,.Lfe2-PreApplicationMode
;; End of function 

	.p2align 1,0
.global	ConfigureTimerUart
	.type	ConfigureTimerUart,@function
/***********************
 * Function `ConfigureTimerUart' 
 ***********************/
ConfigureTimerUart:
.LFB2:
	.loc 1 146 0
	.loc 1 147 0
	mov	#4, &__TA0CCTL0
	.loc 1 148 0
	mov	#736, &__TA0CTL
	.loc 1 149 0
	mov.b	&__P1SEL, r15
	bis.b	#6, r15
	mov.b	r15, &__P1SEL
	.loc 1 150 0
	mov.b	&__P1DIR, r15
	bis.b	#2, r15
	mov.b	r15, &__P1DIR
	.loc 1 151 0
	ret
.LFE2:
.Lfe3:
	.size	ConfigureTimerUart,.Lfe3-ConfigureTimerUart
;; End of function 

	.p2align 1,0
.global	Transmit
	.type	Transmit,@function
/***********************
 * Function `Transmit' 
 ***********************/
Transmit:
.LFB3:
	.loc 1 159 0
	.loc 1 161 0
	mov.b	#10, &BitCnt
	.loc 1 162 0
	mov	&TXByte, r15
	bis	#256, r15
	mov	r15, &TXByte
	.loc 1 163 0
	mov	&TXByte, r15
	rla	r15
	mov	r15, &TXByte
	.loc 1 180 0
	mov	&__TA0R, r15
	add	#833, r15
	mov	r15, &__TA0CCR0
	.loc 1 181 0
	mov	#4144, &__TA0CCTL0
	.loc 1 184 0
	nop
.L10:
	.loc 1 184 0 is_stmt 0 discriminator 1
	mov	&__TA0CCTL0, r15
	and	#16, r15
	cmp	#0, r15
	jne	.L10
	.loc 1 185 0 is_stmt 1
	ret
.LFE3:
.Lfe4:
	.size	Transmit,.Lfe4-Transmit
;; End of function 

	.p2align 1,0
.global	Timer_A
	.type	Timer_A,@function
/***********************
 * Interrupt Vector 9 Service Routine `Timer_A' 
 ***********************/
Timer_A:
.global	__isr_9
__isr_9:
.LFB4:
	.loc 1 195 0
	push	r15
.LCFI0:
	.loc 1 196 0
	mov	&__TA0CCR0, r15
	add	#833, r15
	mov	r15, &__TA0CCR0
	.loc 1 197 0
	mov.b	&BitCnt, r15
	cmp.b	#0, r15
	jne	.L12
	.loc 1 198 0
	mov.b	&__P1SEL, r15
	and.b	#llo(-7), r15
	mov.b	r15, &__P1SEL
	.loc 1 199 0
	mov	&__TA0CCTL0, r15
	and	#llo(-17), r15
	mov	r15, &__TA0CCTL0
	jmp	.L11
.L12:
	.loc 1 209 0
	mov	&__TA0CCTL0, r15
	bis	#128, r15
	mov	r15, &__TA0CCTL0
	.loc 1 210 0
	mov	&TXByte, r15
	and	#1, r15
	mov.b	r15, r15
	cmp.b	#0, r15
	jeq	.L14
	.loc 1 211 0
	mov	&__TA0CCTL0, r15
	and	#llo(-129), r15
	mov	r15, &__TA0CCTL0
.L14:
	.loc 1 212 0
	mov	&TXByte, r15
	clrc
	rrc	r15
	mov	r15, &TXByte
	.loc 1 213 0
	mov.b	&BitCnt, r15
	add.b	#llo(-1), r15
	mov.b	r15, &BitCnt
.L11:
	.loc 1 215 0
	pop	r15
	reti
.LFE4:
.Lfe5:
	.size	Timer_A,.Lfe5-Timer_A
;; End of function 

	.p2align 1,0
.global	ta1_isr
	.type	ta1_isr,@function
/***********************
 * Interrupt Vector 8 Service Routine `ta1_isr' 
 ***********************/
ta1_isr:
.global	__isr_8
__isr_8:
.LFB5:
	.loc 1 228 0
	push	r15
.LCFI1:
	push	r14
.LCFI2:
	push	r13
.LCFI3:
	push	r12
.LCFI4:
	push	r11
.LCFI5:
	push	r10
.LCFI6:
	add	#llo(-22), r1
.LCFI7:
	.loc 1 230 0
	mov	&__TA0CCTL1, r15
	and	#1, r15
	mov.b	r15, r15
	cmp.b	#0, r15
	jne	1f
	br	#.L16
1:

	.loc 1 231 0
	mov	&capture, r15
	cmp	#0, r15
	jne	.L17
	.loc 1 232 0
	mov	&__TA0CCTL1, r15
	and	#llo(-2), r15
	mov	r15, &__TA0CCTL1
	.loc 1 233 0
	mov	&Mode, r15
	cmp	#0, r15
	jne	.L18
	.loc 1 234 0
	mov.b	&__P1OUT, r15
	xor.b	#65, r15
	mov.b	r15, &__P1OUT
	br	#.L15
.L18:
	.loc 1 237 0
	mov	#0, &__TA0CCTL1
	.loc 1 238 0
	bic	#208, 34(r1)
	br	#.L15
.L17:
	.loc 1 244 0
	mov	&i, r15
	cmp	#3, r15
	jl	.L20
.LBB2:
	.loc 1 246 0
	mov	#0, @r1
	mov	#lhi(0), 2(r1)
	.loc 1 249 0
	mov	#0, 6(r1)
	.loc 1 250 0
	mov	#0, 4(r1)
	jmp	.L21
.L25:
.LBB3:
	.loc 1 251 0
	mov	4(r1), r15
	add	#1, r15
	rla	r15
	add	#Times, r15
	mov	@r15, r14
	mov	4(r1), r15
	rla	r15
	add	#Times, r15
	mov	@r15, r15
	mov	r14, r13
	sub	r15, r13
	mov	r13, r15
	mov	r15, 10(r1)
	mov	10(r1), r15
	swpb	r15
	sxt	r15
	swpb	r15
	sxt	r15
	mov	r15, 12(r1)
	.loc 1 252 0
	mov	4(r1), r15
	add	#3, r15
	rla	r15
	add	#Times, r15
	mov	@r15, r14
	mov	4(r1), r15
	add	#2, r15
	rla	r15
	add	#Times, r15
	mov	@r15, r15
	mov	r14, r13
	sub	r15, r13
	mov	r13, r15
	mov	r15, 14(r1)
	mov	14(r1), r15
	swpb	r15
	sxt	r15
	swpb	r15
	sxt	r15
	mov	r15, 16(r1)
	.loc 1 253 0
	cmp	16(r1), 12(r1)
	jl	.L29
	cmp	12(r1), 16(r1)
	jl	.L22
	cmp	14(r1), 10(r1)
	jhs	.L22
.L29:
	.loc 1 254 0
	mov	14(r1), r14
	mov	14+2(r1), r15
	sub	10(r1), r14
	subc	10+2(r1), r15
	add	r14, @r1
	addc	r15, 2(r1)
	.loc 1 255 0
	add	#1, 6(r1)
	jmp	.L24
.L22:
	.loc 1 258 0
	mov	10(r1), r14
	mov	10+2(r1), r15
	sub	14(r1), r14
	subc	14+2(r1), r15
	add	r14, @r1
	addc	r15, 2(r1)
	.loc 1 259 0
	add	#1, 6(r1)
.L24:
.LBE3:
	.loc 1 250 0
	add	#2, 4(r1)
.L21:
	.loc 1 250 0 is_stmt 0 discriminator 1
	mov	4(r1), r15
	add	#3, r15
	mov	&i, r14
	cmp	r15, r14
	jge	.L25
	.loc 1 263 0 is_stmt 1
	mov	@r1, r14
	mov	2(r1), r15
	rla	r14
	rlc	r15
	mov	6(r1), r11
	mov	r11, r13
	swpb	r13
	sxt	r13
	swpb	r13
	sxt	r13
	mov	r13, r12
	mov	r12, r13
	mov	r11, r12
	call	#__divsi3
	mov	r14, 18(r1)
	mov	r15, 18+2(r1)
	.loc 1 264 0
	mov	18(r1), r10
	mov	18+2(r1), r11
	mov	r10, r12
	mov	r11, r13
	mov	r12, r14
	mov	r13, r15
	rla	r14
	rlc	r15
	rla	r14
	rlc	r15
	rla	r14
	rlc	r15
	mov	r14, r12
	mov	r15, r13
	mov	r12, r14
	mov	r13, r15
	rla	r14
	rlc	r15
	rla	r14
	rlc	r15
	rla	r14
	rlc	r15
	add	r14, r12
	addc	r15, r13
	add	r10, r12
	addc	r11, r13
	mov	r12, r14
	mov	r13, r15
	rla	r14
	rlc	r15
	rla	r14
	rlc	r15
	rla	r14
	rlc	r15
	mov	r14, r12
	mov	r15, r13
	sub	r10, r12
	subc	r11, r13
	mov	r12, r14
	mov	r13, r15
	rla	r14
	rlc	r15
	mov	r14, r12
	mov	r15, r13
	mov	r12, r14
	mov	r13, r15
	mov	r14, r12
	mov	r15, r13
	mov	#llo(160000000), r14
	mov	#lhi(160000000), r15
	call	#__divsi3
	mov	r14, &velocity
	mov	r15, &velocity+2
	.loc 1 265 0
	mov	#0, &i
	.loc 1 266 0
	mov	#0, 6(r1)
	.loc 1 268 0
	mov	#0, 8(r1)
	.loc 1 269 0
	mov	#0, 8(r1)
	jmp	.L26
.L27:
	.loc 1 269 0 is_stmt 0 discriminator 2
	add	#1, 8(r1)
.L26:
	.loc 1 269 0 discriminator 1
	cmp	#20000, 8(r1)
	jl	.L27
	.loc 1 270 0 is_stmt 1
	mov	&__TA0CCTL1, r15
	and	#llo(-2), r15
	mov	r15, &__TA0CCTL1
	.loc 1 272 0
	bic	#16, 34(r1)
	jmp	.L15
.L20:
.LBE2:
	.loc 1 276 0
	mov	&__TA0CCTL1, r15
	and	#llo(-2), r15
	mov	r15, &__TA0CCTL1
	.loc 1 277 0
	mov	&i, r15
	mov	&__TA0CCR1, r14
	rla	r15
	add	#Times, r15
	mov	r14, @r15
	.loc 1 278 0
	mov	&i, r15
	add	#1, r15
	mov	r15, &i
	jmp	.L15
.L16:
	.loc 1 285 0
	mov	&__TA0CTL, r15
	and	#llo(-2), r15
	mov	r15, &__TA0CTL
	.loc 1 286 0
	mov	&overflowcounter, r15
	cmp	#4, r15
	jge	.L28
	.loc 1 287 0
	mov	&overflowcounter, r15
	add	#1, r15
	mov	r15, &overflowcounter
	jmp	.L15
.L28:
	.loc 1 290 0
	mov	#0, &overflowcounter
	.loc 1 291 0
	mov	#0, &velocity
	mov	#lhi(0), &velocity+2
	.loc 1 292 0
	mov	&__TA0CTL, r15
	and	#llo(-3), r15
	mov	r15, &__TA0CTL
	.loc 1 293 0
	bic	#16, 34(r1)
.L15:
	.loc 1 296 0
	add	#22, r1
	pop	r10
	pop	r11
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	reti
.LFE5:
.Lfe6:
	.size	ta1_isr,.Lfe6-ta1_isr
;; End of function 

	.p2align 1,0
.global	InitializeButton
	.type	InitializeButton,@function
/***********************
 * Function `InitializeButton' 
 ***********************/
InitializeButton:
.LFB6:
	.loc 1 299 0
	.loc 1 300 0
	mov.b	&__P1DIR, r15
	and.b	#llo(-9), r15
	mov.b	r15, &__P1DIR
	.loc 1 301 0
	mov.b	&__P1OUT, r15
	bis.b	#8, r15
	mov.b	r15, &__P1OUT
	.loc 1 302 0
	mov.b	&__P1REN, r15
	bis.b	#8, r15
	mov.b	r15, &__P1REN
	.loc 1 303 0
	mov.b	&__P1IES, r15
	bis.b	#8, r15
	mov.b	r15, &__P1IES
	.loc 1 304 0
	mov.b	&__P1IFG, r15
	and.b	#llo(-9), r15
	mov.b	r15, &__P1IFG
	.loc 1 305 0
	mov.b	&__P1IE, r15
	bis.b	#8, r15
	mov.b	r15, &__P1IE
	.loc 1 306 0
	ret
.LFE6:
.Lfe7:
	.size	InitializeButton,.Lfe7-InitializeButton
;; End of function 

	.p2align 1,0
.global	port1_isr
	.type	port1_isr,@function
/***********************
 * Interrupt Vector 2 Service Routine `port1_isr' 
 ***********************/
port1_isr:
.global	__isr_2
__isr_2:
.LFB7:
	.loc 1 322 0
	push	r15
.LCFI8:
	.loc 1 331 0
	mov.b	#0, &__P1IFG
	.loc 1 332 0
	mov.b	&__P1IE, r15
	and.b	#llo(-9), r15
	mov.b	r15, &__P1IE
	.loc 1 333 0
	mov	#23069, &__WDTCTL
	.loc 1 334 0
	mov.b	&__IFG1, r15
	and.b	#llo(-2), r15
	mov.b	r15, &__IFG1
	.loc 1 335 0
	mov.b	&__IE1, r15
	bis.b	#1, r15
	mov.b	r15, &__IE1
	.loc 1 337 0
	mov	#0, &__TA0CCTL1
	.loc 1 338 0
	mov.b	&__P1OUT, r15
	and.b	#llo(-66), r15
	mov.b	r15, &__P1OUT
	.loc 1 339 0
	mov	#1, &Mode
	.loc 1 340 0
	bic	#208, 2(r1)
	.loc 1 342 0
	pop	r15
	reti
.LFE7:
.Lfe8:
	.size	port1_isr,.Lfe8-port1_isr
;; End of function 

	.p2align 1,0
.global	wdt_isr
	.type	wdt_isr,@function
/***********************
 * Interrupt Vector 10 Service Routine `wdt_isr' 
 ***********************/
wdt_isr:
.global	__isr_10
__isr_10:
.LFB8:
	.loc 1 353 0
	push	r15
.LCFI9:
	.loc 1 354 0
	mov.b	&__IE1, r15
	and.b	#llo(-2), r15
	mov.b	r15, &__IE1
	.loc 1 355 0
	mov.b	&__IFG1, r15
	and.b	#llo(-2), r15
	mov.b	r15, &__IFG1
	.loc 1 356 0
	mov	#23168, &__WDTCTL
	.loc 1 357 0
	mov.b	&__P1IE, r15
	bis.b	#8, r15
	mov.b	r15, &__P1IE
	.loc 1 358 0
	pop	r15
	reti
.LFE8:
.Lfe9:
	.size	wdt_isr,.Lfe9-wdt_isr
;; End of function 

	.section	.debug_frame,"",@progbits
.Lframe0:
	.4byte	.LECIE0-.LSCIE0
.LSCIE0:
	.4byte	0xffffffff
	.byte	0x1
	.string	""
	.uleb128 0x1
	.sleb128 -2
	.byte	0
	.byte	0xc
	.uleb128 0x1
	.uleb128 0x2
	.byte	0x80
	.uleb128 0x1
	.p2align 1,0
.LECIE0:
.LSFDE0:
	.4byte	.LEFDE0-.LASFDE0
.LASFDE0:
	.4byte	.Lframe0
	.2byte	.LFB0
	.2byte	.LFE0-.LFB0
	.p2align 1,0
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.2byte	.LFB1
	.2byte	.LFE1-.LFB1
	.p2align 1,0
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.2byte	.LFB2
	.2byte	.LFE2-.LFB2
	.p2align 1,0
.LEFDE4:
.LSFDE6:
	.4byte	.LEFDE6-.LASFDE6
.LASFDE6:
	.4byte	.Lframe0
	.2byte	.LFB3
	.2byte	.LFE3-.LFB3
	.p2align 1,0
.LEFDE6:
.LSFDE8:
	.4byte	.LEFDE8-.LASFDE8
.LASFDE8:
	.4byte	.Lframe0
	.2byte	.LFB4
	.2byte	.LFE4-.LFB4
	.byte	0x4
	.4byte	.LCFI0-.LFB4
	.byte	0xe
	.uleb128 0x4
	.byte	0x8f
	.uleb128 0x2
	.p2align 1,0
.LEFDE8:
.LSFDE10:
	.4byte	.LEFDE10-.LASFDE10
.LASFDE10:
	.4byte	.Lframe0
	.2byte	.LFB5
	.2byte	.LFE5-.LFB5
	.byte	0x4
	.4byte	.LCFI1-.LFB5
	.byte	0xe
	.uleb128 0x4
	.byte	0x8f
	.uleb128 0x2
	.byte	0x4
	.4byte	.LCFI2-.LCFI1
	.byte	0xe
	.uleb128 0x6
	.byte	0x8e
	.uleb128 0x3
	.byte	0x4
	.4byte	.LCFI3-.LCFI2
	.byte	0xe
	.uleb128 0x8
	.byte	0x8d
	.uleb128 0x4
	.byte	0x4
	.4byte	.LCFI4-.LCFI3
	.byte	0xe
	.uleb128 0xa
	.byte	0x8c
	.uleb128 0x5
	.byte	0x4
	.4byte	.LCFI5-.LCFI4
	.byte	0xe
	.uleb128 0xc
	.byte	0x8b
	.uleb128 0x6
	.byte	0x4
	.4byte	.LCFI6-.LCFI5
	.byte	0xe
	.uleb128 0xe
	.byte	0x8a
	.uleb128 0x7
	.byte	0x4
	.4byte	.LCFI7-.LCFI6
	.byte	0xe
	.uleb128 0x24
	.p2align 1,0
.LEFDE10:
.LSFDE12:
	.4byte	.LEFDE12-.LASFDE12
.LASFDE12:
	.4byte	.Lframe0
	.2byte	.LFB6
	.2byte	.LFE6-.LFB6
	.p2align 1,0
.LEFDE12:
.LSFDE14:
	.4byte	.LEFDE14-.LASFDE14
.LASFDE14:
	.4byte	.Lframe0
	.2byte	.LFB7
	.2byte	.LFE7-.LFB7
	.byte	0x4
	.4byte	.LCFI8-.LFB7
	.byte	0xe
	.uleb128 0x4
	.byte	0x8f
	.uleb128 0x2
	.p2align 1,0
.LEFDE14:
.LSFDE16:
	.4byte	.LEFDE16-.LASFDE16
.LASFDE16:
	.4byte	.Lframe0
	.2byte	.LFB8
	.2byte	.LFE8-.LFB8
	.byte	0x4
	.4byte	.LCFI9-.LFB8
	.byte	0xe
	.uleb128 0x4
	.byte	0x8f
	.uleb128 0x2
	.p2align 1,0
.LEFDE16:
	.text
.Letext0:
	.file 2 "c:\\users\\gachiri\\documents\\phys319\\mspgcc-20120406-p20120911\\bin\\../lib/gcc/msp430/4.6.3/../../../../msp430/include/msp430g2553.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x418
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x2
	.uleb128 0x1
	.4byte	.LASF80
	.byte	0x1
	.4byte	.LASF81
	.4byte	.LASF82
	.2byte	0
	.2byte	0
	.4byte	.Ldebug_ranges0+0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF10
	.uleb128 0x3
	.byte	0x1
	.4byte	.LASF0
	.byte	0x1
	.byte	0x27
	.byte	0x1
	.2byte	.LFB0
	.2byte	.LFE0
	.byte	0x2
	.byte	0x71
	.sleb128 0
	.uleb128 0x3
	.byte	0x1
	.4byte	.LASF1
	.byte	0x1
	.byte	0x78
	.byte	0x1
	.2byte	.LFB1
	.2byte	.LFE1
	.byte	0x2
	.byte	0x71
	.sleb128 2
	.uleb128 0x3
	.byte	0x1
	.4byte	.LASF2
	.byte	0x1
	.byte	0x92
	.byte	0x1
	.2byte	.LFB2
	.2byte	.LFE2
	.byte	0x2
	.byte	0x71
	.sleb128 2
	.uleb128 0x3
	.byte	0x1
	.4byte	.LASF3
	.byte	0x1
	.byte	0x9e
	.byte	0x1
	.2byte	.LFB3
	.2byte	.LFE3
	.byte	0x2
	.byte	0x71
	.sleb128 2
	.uleb128 0x4
	.byte	0x1
	.4byte	.LASF4
	.byte	0x1
	.byte	0xc1
	.byte	0x1
	.2byte	.LFB4
	.2byte	.LFE4
	.4byte	.LLST0
	.uleb128 0x5
	.byte	0x1
	.4byte	.LASF83
	.byte	0x1
	.byte	0xe2
	.byte	0x1
	.2byte	.LFB5
	.2byte	.LFE5
	.4byte	.LLST1
	.4byte	0xfe
	.uleb128 0x6
	.2byte	.LBB2
	.2byte	.LBE2
	.uleb128 0x7
	.4byte	.LASF5
	.byte	0x1
	.byte	0xf6
	.4byte	0xfe
	.byte	0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x8
	.string	"k"
	.byte	0x1
	.byte	0xf7
	.4byte	0x105
	.byte	0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x7
	.4byte	.LASF6
	.byte	0x1
	.byte	0xf8
	.4byte	0xfe
	.byte	0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x8
	.string	"m"
	.byte	0x1
	.byte	0xf9
	.4byte	0x105
	.byte	0x2
	.byte	0x91
	.sleb128 -30
	.uleb128 0x9
	.4byte	.LASF7
	.byte	0x1
	.2byte	0x10c
	.4byte	0x105
	.byte	0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x6
	.2byte	.LBB3
	.2byte	.LBE3
	.uleb128 0x7
	.4byte	.LASF8
	.byte	0x1
	.byte	0xfb
	.4byte	0xfe
	.byte	0x2
	.byte	0x91
	.sleb128 -26
	.uleb128 0x7
	.4byte	.LASF9
	.byte	0x1
	.byte	0xfc
	.4byte	0xfe
	.byte	0x2
	.byte	0x91
	.sleb128 -22
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF11
	.uleb128 0xa
	.byte	0x2
	.byte	0x5
	.string	"int"
	.uleb128 0xb
	.byte	0x1
	.4byte	.LASF12
	.byte	0x1
	.2byte	0x12a
	.byte	0x1
	.2byte	.LFB6
	.2byte	.LFE6
	.byte	0x2
	.byte	0x71
	.sleb128 2
	.uleb128 0xc
	.byte	0x1
	.4byte	.LASF13
	.byte	0x1
	.2byte	0x13f
	.byte	0x1
	.2byte	.LFB7
	.2byte	.LFE7
	.4byte	.LLST2
	.uleb128 0xc
	.byte	0x1
	.4byte	.LASF14
	.byte	0x1
	.2byte	0x15e
	.byte	0x1
	.2byte	.LFB8
	.2byte	.LFE8
	.4byte	.LLST3
	.uleb128 0xd
	.4byte	0x105
	.4byte	0x151
	.uleb128 0xe
	.4byte	0x25
	.byte	0x3
	.byte	0
	.uleb128 0x7
	.4byte	.LASF15
	.byte	0x1
	.byte	0x19
	.4byte	0x160
	.byte	0x3
	.byte	0x3
	.2byte	Times
	.uleb128 0xf
	.4byte	0x141
	.uleb128 0x10
	.string	"IE1"
	.byte	0x2
	.byte	0x87
	.4byte	.LASF84
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0xf
	.4byte	0x17b
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF16
	.uleb128 0x11
	.4byte	.LASF17
	.byte	0x2
	.byte	0x8e
	.4byte	.LASF85
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF18
	.byte	0x2
	.2byte	0x122
	.4byte	.LASF20
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF19
	.byte	0x2
	.2byte	0x124
	.4byte	.LASF21
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF22
	.byte	0x2
	.2byte	0x126
	.4byte	.LASF23
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF24
	.byte	0x2
	.2byte	0x128
	.4byte	.LASF25
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF26
	.byte	0x2
	.2byte	0x1d8
	.4byte	.LASF27
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF28
	.byte	0x2
	.2byte	0x1da
	.4byte	.LASF29
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF30
	.byte	0x2
	.2byte	0x1dc
	.4byte	.LASF31
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF32
	.byte	0x2
	.2byte	0x1de
	.4byte	.LASF33
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF34
	.byte	0x2
	.2byte	0x1e0
	.4byte	.LASF35
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF36
	.byte	0x2
	.2byte	0x1e2
	.4byte	.LASF37
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF38
	.byte	0x2
	.2byte	0x1e6
	.4byte	.LASF39
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF40
	.byte	0x2
	.2byte	0x1eb
	.4byte	.LASF41
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF42
	.byte	0x2
	.2byte	0x1ed
	.4byte	.LASF43
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF44
	.byte	0x2
	.2byte	0x1f5
	.4byte	.LASF45
	.4byte	0x176
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF46
	.byte	0x2
	.2byte	0x215
	.4byte	.LASF47
	.4byte	0x2a1
	.byte	0x1
	.byte	0x1
	.uleb128 0xf
	.4byte	0x25
	.uleb128 0x12
	.4byte	.LASF48
	.byte	0x2
	.2byte	0x217
	.4byte	.LASF49
	.4byte	0x2a1
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF50
	.byte	0x2
	.2byte	0x219
	.4byte	.LASF51
	.4byte	0x2a1
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF52
	.byte	0x2
	.2byte	0x21d
	.4byte	.LASF53
	.4byte	0x2a1
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF54
	.byte	0x2
	.2byte	0x21f
	.4byte	.LASF55
	.4byte	0x2a1
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF56
	.byte	0x2
	.2byte	0x221
	.4byte	.LASF57
	.4byte	0x2a1
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF58
	.byte	0x2
	.2byte	0x28f
	.4byte	.LASF59
	.4byte	0x2a1
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF60
	.byte	0x2
	.2byte	0x293
	.4byte	.LASF61
	.4byte	0x2a1
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF62
	.byte	0x2
	.2byte	0x299
	.4byte	.LASF63
	.4byte	0x2a1
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF64
	.byte	0x2
	.2byte	0x29b
	.4byte	.LASF65
	.4byte	0x2a1
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF66
	.byte	0x2
	.2byte	0x386
	.4byte	.LASF67
	.4byte	0x2a1
	.byte	0x1
	.byte	0x1
	.uleb128 0x12
	.4byte	.LASF68
	.byte	0x2
	.2byte	0x3b6
	.4byte	.LASF69
	.4byte	0x36c
	.byte	0x1
	.byte	0x1
	.uleb128 0x13
	.4byte	0x176
	.uleb128 0x12
	.4byte	.LASF70
	.byte	0x2
	.2byte	0x3b8
	.4byte	.LASF71
	.4byte	0x36c
	.byte	0x1
	.byte	0x1
	.uleb128 0x14
	.4byte	.LASF72
	.byte	0x1
	.byte	0x16
	.4byte	0x17b
	.byte	0x1
	.byte	0x3
	.byte	0x3
	.2byte	BitCnt
	.uleb128 0x14
	.4byte	.LASF73
	.byte	0x1
	.byte	0x17
	.4byte	0x25
	.byte	0x1
	.byte	0x3
	.byte	0x3
	.2byte	TXByte
	.uleb128 0x14
	.4byte	.LASF74
	.byte	0x1
	.byte	0x18
	.4byte	0x17b
	.byte	0x1
	.byte	0x3
	.byte	0x3
	.2byte	data
	.uleb128 0x15
	.string	"i"
	.byte	0x1
	.byte	0x1a
	.4byte	0x3c1
	.byte	0x1
	.byte	0x3
	.byte	0x3
	.2byte	i
	.uleb128 0xf
	.4byte	0x105
	.uleb128 0x14
	.4byte	.LASF75
	.byte	0x1
	.byte	0x1c
	.4byte	0x3d6
	.byte	0x1
	.byte	0x3
	.byte	0x3
	.2byte	velocity
	.uleb128 0xf
	.4byte	0xfe
	.uleb128 0x14
	.4byte	.LASF76
	.byte	0x1
	.byte	0x1d
	.4byte	0x105
	.byte	0x1
	.byte	0x3
	.byte	0x3
	.2byte	capture
	.uleb128 0x14
	.4byte	.LASF77
	.byte	0x1
	.byte	0x1e
	.4byte	0x105
	.byte	0x1
	.byte	0x3
	.byte	0x3
	.2byte	pulsecount
	.uleb128 0x14
	.4byte	.LASF78
	.byte	0x1
	.byte	0x1f
	.4byte	0x3c1
	.byte	0x1
	.byte	0x3
	.byte	0x3
	.2byte	overflowcounter
	.uleb128 0x14
	.4byte	.LASF79
	.byte	0x1
	.byte	0x20
	.4byte	0x2a1
	.byte	0x1
	.byte	0x3
	.byte	0x3
	.2byte	Mode
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x2007
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x2007
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x2007
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.2byte	.LFB4
	.2byte	.LCFI0
	.2byte	0x2
	.byte	0x71
	.sleb128 0
	.2byte	.LCFI0
	.2byte	.LFE4
	.2byte	0x2
	.byte	0x71
	.sleb128 2
	.2byte	0
	.2byte	0
.LLST1:
	.2byte	.LFB5
	.2byte	.LCFI1
	.2byte	0x2
	.byte	0x71
	.sleb128 0
	.2byte	.LCFI1
	.2byte	.LCFI2
	.2byte	0x2
	.byte	0x71
	.sleb128 2
	.2byte	.LCFI2
	.2byte	.LCFI3
	.2byte	0x2
	.byte	0x71
	.sleb128 4
	.2byte	.LCFI3
	.2byte	.LCFI4
	.2byte	0x2
	.byte	0x71
	.sleb128 6
	.2byte	.LCFI4
	.2byte	.LCFI5
	.2byte	0x2
	.byte	0x71
	.sleb128 8
	.2byte	.LCFI5
	.2byte	.LCFI6
	.2byte	0x2
	.byte	0x71
	.sleb128 10
	.2byte	.LCFI6
	.2byte	.LCFI7
	.2byte	0x2
	.byte	0x71
	.sleb128 12
	.2byte	.LCFI7
	.2byte	.LFE5
	.2byte	0x2
	.byte	0x71
	.sleb128 34
	.2byte	0
	.2byte	0
.LLST2:
	.2byte	.LFB7
	.2byte	.LCFI8
	.2byte	0x2
	.byte	0x71
	.sleb128 0
	.2byte	.LCFI8
	.2byte	.LFE7
	.2byte	0x2
	.byte	0x71
	.sleb128 2
	.2byte	0
	.2byte	0
.LLST3:
	.2byte	.LFB8
	.2byte	.LCFI9
	.2byte	0x2
	.byte	0x71
	.sleb128 0
	.2byte	.LCFI9
	.2byte	.LFE8
	.2byte	0x2
	.byte	0x71
	.sleb128 2
	.2byte	0
	.2byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x14
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x2
	.byte	0
	.2byte	.Ltext0
	.2byte	.Letext0-.Ltext0
	.2byte	.LFB0
	.2byte	.LFE0-.LFB0
	.2byte	0
	.2byte	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.2byte	.Ltext0
	.2byte	.Letext0
	.2byte	.LFB0
	.2byte	.LFE0
	.2byte	0
	.2byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF4:
	.string	"Timer_A"
.LASF54:
	.string	"TA0CCR0"
.LASF17:
	.string	"IFG1"
.LASF44:
	.string	"P2SEL"
.LASF5:
	.string	"delta_total"
.LASF45:
	.string	"__P2SEL"
.LASF67:
	.string	"__WDTCTL"
.LASF18:
	.string	"DCOCTL"
.LASF58:
	.string	"TA1CTL"
.LASF73:
	.string	"TXByte"
.LASF32:
	.string	"P1IES"
.LASF80:
	.string	"GNU C 4.6.3 20120301 (mspgcc LTS 20120406 patched to 20120502)"
.LASF51:
	.string	"__TA0CCTL1"
.LASF76:
	.string	"capture"
.LASF29:
	.string	"__P1DIR"
.LASF83:
	.string	"ta1_isr"
.LASF38:
	.string	"P1REN"
.LASF37:
	.string	"__P1SEL"
.LASF61:
	.string	"__TA1CCTL1"
.LASF34:
	.string	"P1IE"
.LASF31:
	.string	"__P1IFG"
.LASF74:
	.string	"data"
.LASF52:
	.string	"TA0R"
.LASF7:
	.string	"delay"
.LASF16:
	.string	"unsigned char"
.LASF62:
	.string	"TA1CCR0"
.LASF64:
	.string	"TA1CCR1"
.LASF84:
	.string	"__IE1"
.LASF35:
	.string	"__P1IE"
.LASF19:
	.string	"BCSCTL1"
.LASF22:
	.string	"BCSCTL2"
.LASF24:
	.string	"BCSCTL3"
.LASF56:
	.string	"TA0CCR1"
.LASF49:
	.string	"__TA0CCTL0"
.LASF82:
	.string	"C:\\Users\\Gachiri\\OneDrive\\Workspace\\PHYS319\\Project"
.LASF9:
	.string	"delta_b"
.LASF43:
	.string	"__P2DIR"
.LASF46:
	.string	"TA0CTL"
.LASF27:
	.string	"__P1OUT"
.LASF78:
	.string	"overflowcounter"
.LASF0:
	.string	"main"
.LASF55:
	.string	"__TA0CCR0"
.LASF12:
	.string	"InitializeButton"
.LASF75:
	.string	"velocity"
.LASF28:
	.string	"P1DIR"
.LASF71:
	.string	"__CALBC1_16MHZ"
.LASF6:
	.string	"delta_t"
.LASF79:
	.string	"Mode"
.LASF10:
	.string	"unsigned int"
.LASF25:
	.string	"__BCSCTL3"
.LASF30:
	.string	"P1IFG"
.LASF66:
	.string	"WDTCTL"
.LASF36:
	.string	"P1SEL"
.LASF57:
	.string	"__TA0CCR1"
.LASF15:
	.string	"Times"
.LASF53:
	.string	"__TA0R"
.LASF14:
	.string	"wdt_isr"
.LASF26:
	.string	"P1OUT"
.LASF3:
	.string	"Transmit"
.LASF1:
	.string	"PreApplicationMode"
.LASF47:
	.string	"__TA0CTL"
.LASF70:
	.string	"CALBC1_16MHZ"
.LASF81:
	.string	"main.c"
.LASF42:
	.string	"P2DIR"
.LASF48:
	.string	"TA0CCTL0"
.LASF20:
	.string	"__DCOCTL"
.LASF77:
	.string	"pulsecount"
.LASF41:
	.string	"__P2OUT"
.LASF21:
	.string	"__BCSCTL1"
.LASF23:
	.string	"__BCSCTL2"
.LASF63:
	.string	"__TA1CCR0"
.LASF33:
	.string	"__P1IES"
.LASF60:
	.string	"TA1CCTL1"
.LASF13:
	.string	"port1_isr"
.LASF11:
	.string	"long int"
.LASF68:
	.string	"CALDCO_16MHZ"
.LASF40:
	.string	"P2OUT"
.LASF50:
	.string	"TA0CCTL1"
.LASF39:
	.string	"__P1REN"
.LASF85:
	.string	"__IFG1"
.LASF59:
	.string	"__TA1CTL"
.LASF65:
	.string	"__TA1CCR1"
.LASF8:
	.string	"delta_a"
.LASF72:
	.string	"BitCnt"
.LASF69:
	.string	"__CALDCO_16MHZ"
.LASF2:
	.string	"ConfigureTimerUart"
