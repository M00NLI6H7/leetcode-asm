# [11. Container With Most Water](https://leetcode.com/problems/container-with-most-water/)

### Solution:

1. Initialize resulting variable as minimal 4 bytes integer value: `maxArea = INT_MIN`
2. Initialize left (`l`) and right (`r`) pointer (indexes) into `heights`array as 0 and`heightsSize` respectively
3. Make while loop where condition is the following: `r < l`
   1. Initialize integer variable that will represent the length as following: `length = r - l`
   2. Store current `height` value that `l` index is points to as `lHeight`
   3. Store current `height` value that `r` index is points to as `rHeight`
   4. Initialize `height` variable with `lHeight`
   5. If `lHeight` is less than `rHeight`
      1. Increase `l` index by one
   6. else
      1. Assign `rHeight` to `height`
      2. Decrease `r` index by one
   7. Calculate area by multiplying `height` with `length`
   8. Check if `area` is bigger than `maxArea` and if so - assign `area` to `maxArea`
4. return `maxArea`

### ASM -> C Line by line

```ASM
_maxArea:                                 ; int maxArea(int* heights, int heightsSize)
    push rbp                              ; {
    mov rbp, rsp                          ;

    sub rsp, 8                            ;   // allocate 8 bytes on the stack
    mov qword ptr [rsp + 0], rdi          ;   int* arr = heights;

    mov r8d, 0x00000080                   ;   int maxArea = INT_MIN;
    mov r9, 0                             ;   int l = 0;
    mov r10, rsi                          ;   int r = heightsSize;
    sub r10, 1                            ;   r--;

.WHILE_LOOP:                              ;   while (
    cmp r10, r9                           ;     r > l
    jle .WHILE_LOOP_EXIT                  ;   )
                                          ;   {
    mov r11, r10                          ;      int length = r;
    sub r11, r9                           ;      length -= l;
  
    mov rax, qword ptr [rsp + 0]          ;      // move int* arr base address into rax register
    mov eax, dword ptr [rax + r9 * 4]     ;      // load value from arr with [rax + r9 * 4] offset into eax
    mov esi, eax                          ;      int lheight = heights[l];

    mov rax, qword ptr [rsp + 0]          ;      // move int* arr base address into rax register
    mov eax, dword ptr [rax + r10 * 4]    ;      // load value from arr with [rax + r10 * 4] offset into eax
    mov edi, eax                          ;      int rheight = heights[r];
                                          ;      int hight = lheight;
    cmp esi, edi                          ;      if (lheight >= rheight) {
    jle .L_LESS_THAN_R                    ;
    mov esi, edi                          ;        hight = rheight;
    sub r10, 1                            ;        r--;
    jmp .CALCULATE_AREA                   ;      }

.L_LESS_THAN_R:                           ;      else {
    add r9, 1                             ;        l++;
    jmp .CALCULATE_AREA                   ;      }

.CALCULATE_AREA:                          ;
    imul rsi, r11                         ;     int area = hight * length;
    cmp rsi, r8                           ;     if (area > maxArea) {
    jg .SET_NEW_MAX_AREA                  ;
    jmp .WHILE_LOOP                       ;

.SET_NEW_MAX_AREA:                        ;
    mov r8, rsi                           ;       maxArea = area;
    jmp .WHILE_LOOP                       ;     }

.WHILE_LOOP_EXIT:                         ;   }
    mov eax, r8d                          ;   int returnValue = maxArea;
    add rsp, 8                            ;
    pop rbp                               ;
    ret                                   ;   return returnValue;
                                          ; }
```

### Leetcode acceptable code

<details>
 <summary>Spoiler</summary>

```C
#define LEETCODE_INTEL_ASM_BEGIN __asm__(".intel_syntax noprefix; \n"
#define LEETCODE_ASM_LINE(args...) #args "\n"
#define LEETCODE_INTEL_ASM_END ".att_syntax;" : :);

__attribute__((naked)) int maxArea(int* heights, int heightsSize)
{
    LEETCODE_INTEL_ASM_BEGIN
    LEETCODE_ASM_LINE(push rbp)
    LEETCODE_ASM_LINE(mov rbp, rsp)

    LEETCODE_ASM_LINE(sub rsp, 8)
    LEETCODE_ASM_LINE(mov qword ptr [rsp + 0], rdi)

    LEETCODE_ASM_LINE(mov r8, 0x00000080)
    LEETCODE_ASM_LINE(xor r9, r9)
    LEETCODE_ASM_LINE(mov r10, rsi)
    LEETCODE_ASM_LINE(sub r10, 1)
    
    LEETCODE_ASM_LINE(.WHILE_LOOP:)
    LEETCODE_ASM_LINE(cmp r10, r9)
    LEETCODE_ASM_LINE(jle .WHILE_LOOP_EXIT)

    LEETCODE_ASM_LINE(mov r11, r10)
    LEETCODE_ASM_LINE(sub r11, r9)
    
    LEETCODE_ASM_LINE(mov rax, qword ptr [rsp + 0])
    LEETCODE_ASM_LINE(mov eax, dword ptr [rax + r9 * 4])
    LEETCODE_ASM_LINE(mov esi, eax)

    LEETCODE_ASM_LINE(mov rax, qword ptr [rsp + 0])
    LEETCODE_ASM_LINE(mov eax, dword ptr [rax + r10 * 4])
    LEETCODE_ASM_LINE(mov edi, eax)

    LEETCODE_ASM_LINE(cmp esi, edi)
    LEETCODE_ASM_LINE(jle .L_LESS_THAN_R)
    LEETCODE_ASM_LINE(mov esi, edi)
    LEETCODE_ASM_LINE(sub r10, 1)
    LEETCODE_ASM_LINE(jmp .CALCULATE_AREA)
    LEETCODE_ASM_LINE(.L_LESS_THAN_R:)
    LEETCODE_ASM_LINE(add r9, 1)
    LEETCODE_ASM_LINE(jmp .CALCULATE_AREA)
    
    LEETCODE_ASM_LINE(.CALCULATE_AREA:)
    LEETCODE_ASM_LINE(imul rsi, r11)
    LEETCODE_ASM_LINE(cmp rsi, r8)
    LEETCODE_ASM_LINE(jg .SET_NEW_MAX_AREA)
    LEETCODE_ASM_LINE(jmp .WHILE_LOOP)
    LEETCODE_ASM_LINE(.SET_NEW_MAX_AREA:)
    LEETCODE_ASM_LINE(mov r8, rsi)
    LEETCODE_ASM_LINE(jmp .WHILE_LOOP)
    
    LEETCODE_ASM_LINE(.WHILE_LOOP_EXIT:)
    LEETCODE_ASM_LINE(mov rax, r8)
    LEETCODE_ASM_LINE(add rsp, 8)
    LEETCODE_ASM_LINE(pop rbp)
    LEETCODE_ASM_LINE(ret)
    LEETCODE_INTEL_ASM_END
}
```
</details>
