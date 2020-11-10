; Interrupt vector starts at 0x0000 of asm code chunk
; and should contain addresses of TIC, SCN and OVR functions
; dw <word> (for dump word) emits <word> to cartridge binary
dw TIC ; Store address of TIC symbol
dw SCN ; Store address of SCN symbol
dw OVR ; Store address of OVR symbol

; Some useful constants
; def <name> <value> (for define), defines a named constant
def TRACE_CODE 0 ; A code for trace call
def RAM 0x14E04  ; Starting address of RAM

; Other than interrupt vector asm cartridge contents are arbitrary
; Let's define some data required to print "Hello world" message to console later
; A string to print in a message...
msg_string:
ds "Hello world\0" ; ds "<str>" (for dump string), emits ASCII bytes of <str> to cartridge binary

; ... and its length
def MSG_LENGTH 12

; TIC function
TIC: ; Define TIC symbol to store it at interrupt vector
  ; Let's print hello world to console, each time with new color
  mov TRACE_CODE r0 ; put TRACE_CODE constant to register 0
  mov msg_string r1 ; put address of message string to register 1
  mov MSG_LENGTH r2 ; put length of message string to register 2
  mov 0          r3 ; put color index to register 3
  int               ; call interrupt, TIC will print our colored string
  add 1          r3 ; switch to next color
  ret

; SCN function
SCN: ; Define SCN symbol to store it at interrupt vector
  ret ; SCN function is optional so we do nothing here and just return

; OVR function
OVR: ; Define OVR symbol to store it at interrupt vector
  ret ; OVR function is optional so we do nothing here and just return
