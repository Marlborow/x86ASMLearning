section .data
format db "%i", 0
string_out db "",0xA, 0

array dd 1,4,3,5,2,6,7
a_size dd 6

;Loop variables
i dd 0
j dd 1

;other vars
int_byte_size dd 4
print_ret dd 0

section .text

global _main
extern _printf
swap:
    mov eax, [i]
    imul eax, [int_byte_size]
    mov ecx, eax 
    mov eax, [array + eax]
    
    mov ebx, [j]
    imul ebx, [int_byte_size]
    mov edx, ebx
    mov ebx, [array + ebx]
    

    mov [array + ecx], ebx
    mov [array + edx], eax
    jmp sort_inc
    
sort_inc:    
    mov eax, [j]
    mov ebx, [a_size]
    cmp eax, ebx
    je inc_i
    jmp inc_j
    
inc_i:
    mov eax, [i]
    add eax, 1
    mov [j],eax
    
    mov eax, [i]
    add eax, 1
    mov [i], eax

    
    mov ebx, [a_size]        
    cmp eax, ebx
    je print_array
    
inc_j:
    mov eax,[j]
    add eax, 1
    mov [j],eax
    
sort:
    mov eax, [i]
    imul eax, [int_byte_size]
    mov eax, [array + eax]
    
    mov ebx, [j]
    imul ebx, [int_byte_size]
    mov ebx, [array + ebx]
    
    cmp eax, ebx
    jg swap

    jmp sort_inc
    
_main:
    mov ebp, esp; for correct debugging
    jmp sort
    
print_array:
    mov eax, 0
    mov [i], eax
print_array_loop:
    mov eax, [i]
    mov ebx, [a_size]
    cmp eax, ebx
    jg fin
    
    imul eax, [int_byte_size]
    mov eax, [array + eax]
    
    push eax
    push format
    call _printf
    add esp, 8
    
    mov eax,[i]
    add eax, 1
    mov [i],eax
    
    jmp print_array_loop
    
fin:
    xor eax, eax
    ret