#include "MemoryMap.h"
#include "ARMv7AR.h"


.text    
    .thumb
   
    .global vector_start
    .global vector_end

    vector_start:

        LDR r0, stack_handler_addr
        BX r0

        LDR r0, reset_handler_addr
        BX r0

        LDR r0, nmi_handler_addr
        BX r0

        LDR r0, hardfult_handler_addr
        BX r0

        LDR r0, pftch_abt_handler_addr
        BX r0

        LDR r0, data_abt_handler_addr
        BX r0

        B .
        NOP

        LDR r0, irq_handler_addr
        BX r0

        LDR r0, fiq_handler_addr
        BX r0

        stack_handler_addr:     .word stack_handler
        reset_handler_addr:     .word reset_handler
        nmi_handler_addr:       .word dummy_handler
        hardfult_handler_addr:  .word dummy_handler
        pftch_abt_handler_addr: .word dummy_handler
        data_abt_handler_addr:  .word dummy_handler
        irq_handler_addr:       .word dummy_handler
        fiq_handler_addr:       .word dummy_handler
        
    vector_end:

    stack_handler:
        LDMFD   sp!, {r0-r12, lr}
        SUB     sp, sp, #4
        LDR     lr, [sp]
        ADD     sp, sp, #4
        CPSIE   if
        BX      lr


        
    reset_handler: 
        LDR     r0, =0x40014000 // GPIO Register 주소
        MOV     r1, #0x12345678 // 원하는 GPIO 설정 값
        STR     r1, [r0]        // GPIO 레지스터에 설정 값 저장

        // 예시: UART 초기화
        LDR     r0, =0x4003F000 // UART Register 주소
        MOV     r1, #0x56789ABC // 원하는 UART 설정 값
        STR     r1, [r0]        // UART 레지스터에 설정 값 저장

    dummy_handler:
            B .

.end