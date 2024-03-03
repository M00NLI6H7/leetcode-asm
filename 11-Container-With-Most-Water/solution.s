.intel_syntax noprefix;

.global _maxArea

_maxArea:                                  // int maxArea(int* heights, int heightsSize)
    push rbp                               // {
    mov rbp, rsp                           //

    mov r8, -2147483648                    //   int maxArea = INT_MIN;
    mov r9, 0                              //   int l = 0;
    mov r10, rsi                           //   int r;
    sub r10, 1                             //   r = heightsSize - 1;

.WHILE_LOOP:                               //   while (
    cmp r10, r9                            //          r > l
    jle .WHILE_LOOP_EXIT                   //   )
                                           //   {
    mov r11, r10                           //     int length = r;
    sub r11, r9                            //     length -= l;
    mov r12d, dword ptr [rdi + r9 * 4]     //     int lheight = heights[l];
    mov r13d, dword ptr [rdi + r10 * 4]    //     int rheight = heights[r];
                                           //     int hight = lheight;
    cmp r12d, r13d                         //     if (heights[l] >= heights[r]) {
    jle .L_LESS_THAN_R                     //
                                           //
    mov r12d, r13d                         //       hight = rheight;
    sub r10, 1                             //       r--;
    jmp .CALCULATE_AREA                    //     }

.L_LESS_THAN_R:                            //     else {
    add r9, 1                              //       l++;
    jmp .CALCULATE_AREA                    //     }

.CALCULATE_AREA:
    imul r11, r12                          //     int area = hight * length
    cmp r11, r8                            //     if (area > maxArea) {
    jg .SET_NEW_MAX_AREA                   //
    jmp .WHILE_LOOP                        //

.SET_NEW_MAX_AREA:
    mov r8, r11                            //       maxArea = area;
    jmp .WHILE_LOOP                        //     }

.WHILE_LOOP_EXIT:                          //   } // while
    mov eax, r8d                           //   int returnValue = maxArea;
    pop rbp                                //   return returnValue;
    ret                                    // }