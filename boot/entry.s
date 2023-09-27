#include "MemoryMap.h"
#include "ARMv7AR.h"


.text    
    .thumb
   
    .global vector_start
    .global vector_end

    vector_start:
        LDR r0, reset_handler_addr
        BX r0

        LDR r0, undef_handler_addr
        BX r0

        LDR r0, svc_handler_addr
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

        reset_handler_addr:     .word reset_handler
        undef_handler_addr:     .word dummy_handler
        svc_handler_addr:       .word dummy_handler
        pftch_abt_handler_addr: .word dummy_handler
        data_abt_handler_addr:  .word dummy_handler
        irq_handler_addr:       .word dummy_handler
        fiq_handler_addr:       .word dummy_handler
        
    vector_end:

    reset_handler:
        MRS r0, CONTROL
        LDR r2, #0x1f
        BIC r1, r0, r2
        LDR r2, #ARM_MODE_BIT_SVC
        ORR r1, r1, r2
        MSR CPSR, r1
        LDR sp, =SVC_STACK_TOP 

    dummy_handler:
            B .

.end