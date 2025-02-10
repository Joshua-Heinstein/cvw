//a0 = x[]
//a1 = c[]
//a2 = y[]
//a3 = n
//a4 = m


.global fir
fir:
    addi sp, sp, -32
    sd s0, 0(sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    
    li s0, 0           # j = 0
forj: 
    bge s0, a3, donej  # branch if j >= n
    li s2, 0           # sum = 0
    li s1, 0           # i = 0
    
fori:
    bge s1, a4, donei  # branch if i >= m
    
    add t0, s0, a4     # j + m
    addi t0, t0, -1    # j + (m-1)
    sub t0, t0, s1     # j + (m-1) - i
    slli t0, t0, 2     # Convert to bytes
    add t0, a0, t0     # Get address
    lw t1, 0(t0)       # Load x value
    
    slli t2, s1, 2     # Convert i to bytes
    add t2, a1, t2     # Get address
    lw t3, 0(t2)       # Load c value
    
    mul t4, t1, t3     # Multiply values
    srai t4, t4, 31    # Arithmetic shift right by 31
    add s2, s2, t4     # Add to sum
    
    addi s1, s1, 1     # i++
    j fori
    
donei:
    slli t0, s0, 2     # Convert j to bytes
    add t0, a2, t0     # Get address
    sw s2, 0(t0)       # Store sum in y[j]
    
    addi s0, s0, 1     # j++
    j forj
    
donej:
    ld s0, 0(sp)
    ld s1, 8(sp)
    ld s2, 16(sp)
    addi sp, sp, 32
    ret