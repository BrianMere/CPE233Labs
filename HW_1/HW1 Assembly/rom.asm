addi  x9,  x0, 0x064
addi  x10, x0, 0x014
sltiu x5,  x9, 0x0AA
slli  x5,  x5, 0x01F
sra   x6,  x5, x10
xor   x7,  x6, x9
start: jal   x0,  start
