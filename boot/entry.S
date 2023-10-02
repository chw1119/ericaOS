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
        
    reset_handler:

    dummy_handler:
            B .

.end