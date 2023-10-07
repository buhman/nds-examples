	.section .text.9start

        ldr r0, =#0x04000000 /* IO_REG */
        mov r1, #0x0
        //orr r1, r1, #(1 << 7) /* DISPCNT__FORCED_BLANK */
	orr r1, r1, #(1 << 16) /* DISPCNT__DISPLAY_ON */
        str r1, [r0, #0x000] /* DISPCNT */

	ldr r0, =#0x05000000
	ldr r1, =#((7 << 10) | (10 << 5) | (19 << 0))
	strh r1, [r0, #0x000]

	ldr r0, =#(0x027E0000 + 0x400 - 4)
	mov sp, r0

start9:
        b start

	.section .text.7start
start7:
forever7:
	mov r1, #0x7
	b forever7
