; CONFIG1
  CONFIG  FOSC = INTOSCIO       
  CONFIG  WDTE = OFF            
  CONFIG  PWRTE = ON            
  CONFIG  MCLRE = ON            
  CONFIG  BOREN = ON            
  CONFIG  LVP = OFF              
  CONFIG  CPD = OFF             
  CONFIG  WRT = OFF             
  CONFIG  CCPMX = RB0           
  CONFIG  CP = OFF              
; CONFIG2
  CONFIG  FCMEN = OFF           
  CONFIG  IESO = OFF   
  
  ; definitions des switches
  #define SW1 PORTB,6
  #define SW2 PORTB,7
  #define LED1 PORTB,3
  #define LED2 PORTB,4


#include <xc.inc>

PSECT reset_Vec,class=CODE,delta=2,abs,ovrld
ORG 0x000
goto start

PSECT int, class=CODE, delta=2, abs,ovrld
ORG 0x004
intVec:
    retfie

PSECT main, class=CODE, delta=2
start:
  call INIT_PIC
  goto loop
  
loop:
    banksel(PORTB)
    btfss SW1
    call RLed1
    btfss SW2
    call RLed2
    goto loop

RLed1:
    bsf LED1
    return

RLed2:
    bsf LED2
    return
  
INIT_PIC:
    banksel(OSCCON)
    movlw 01111000B
    movwf OSCCON

    banksel(TRISB)
    movlw 11100111B
    movwf TRISB
    
    banksel(TRISA)
    movlw 11111111B
    movwf TRISA
    
    banksel(INTCON)
    clrf    INTCON 
    
    banksel(ANSEL)
    clrf    ANSEL                  
    return
    

  
; --- RAM ---
psect udata_bank0
SelectLed: ds 1
d1: ds 1
d2: ds 1

end


