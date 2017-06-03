
#include  "msp430.h"

#define     LED1                  BIT0
#define     LED2                  BIT6


#define     BUTTON                BIT3

#define     TXD                   BIT1                      // TXD on P1.1
#define     RXD                   BIT2                      // RXD on P1.2
#define     ONOFF                 BIT4
#define     PreAppMode            0
#define     RunningMode           1
//   Conditions for 9600/4=2400 Baud SW UART, SMCLK = 1MHz

#define     Bitime                833
// duration of 1 bit, measured in timer A clock cycles.
// main clock 16MHZ timer a at 2 MHz
//For 2400 bits per second, we want 833 timer ticks.

unsigned char BitCnt;
unsigned int TXByte;
unsigned char data;
static volatile int Times[4];
volatile int i = 0;

volatile long velocity = 0;
int capture = 0;
int pulsecount =0 ;
volatile int overflowcounter=0;
volatile unsigned int Mode;   

void ConfigureTimerUart(void);
void InitializeButton(void);
void PreApplicationMode(void); 
void Transmit(void);

void main(void)
{
  

  WDTCTL = WDTPW + WDTHOLD;                 // Stop WDT

   
  BCSCTL1 = CALBC1_16MHZ;                    // Set DCO to 16MHz
  DCOCTL = CALDCO_16MHZ;
  BCSCTL2 &= ~(DIVS_3);                      // SMCLK = DCO = 16MHz
  
  InitializeButton();
  
  // setup port for leds:
  P1DIR |= LED1 + LED2 + ONOFF;                          
  P1OUT &= ~(LED1 + LED2 + ONOFF);  
  
  //set ports for TXD
  P1DIR |= TXD;
  P1OUT |= TXD;
  
  //set ports 
  P2DIR |= BIT1+BIT2+BIT3; // PWM , MAX232A ON/OFF , THRESHOLD
  P2SEL |= BIT1;
  
  Mode = PreAppMode;
  PreApplicationMode();          // Blinks LEDs, waits for button press
  
  
  __delay_cycles(1000);                     // Wait for ADC Ref to settle  
  
  __enable_interrupt();                     // Enable interrupts.

  
  TA1CTL = TASSEL_2 + MC_1 + ID_3; // SMCLK, up mode, with no divider
  TA1CCR0 = 50;
  TA1CCR1 = 25; // Period and Dutycycle for a 25us pulse 
  TA1CCTL1 = OUTMOD_7; // CCR1 reset/set
  

  /* Main Application Loop */
  while(1){

    P2OUT |= BIT2 + BIT3 ;  // Comparator threshold high + turn on sending transmitter
    P1OUT |= ONOFF;   // turn on nand gate
    
    for(pulsecount=0;pulsecount<400;pulsecount++); // wait to generate pulse train
    
    P2OUT &= ~(BIT2);
    P1OUT&= ~(ONOFF);
    P2OUT&= ~(BIT3); //threshold low, Nand low, turn off sending transmitter
    
    capture = 1;	     //  Sending  off
    
    TACTL = TASSEL_2 + MC_2 +ID_3 + TAIE;
    TACCTL1 = CAP + CCIS_0 + CM_3 + CCIE  ;// Enable capture compare for rising and falling edges and timer_A0 interrupts.

    P1SEL |= RXD; // alternate function for capture compare input pin shared with RXD
    
    __bis_SR_register(LPM0_bits + GIE); // Enter Low power mode 0
    
    // set up timer and port for uart.
    capture = 0;
    TACTL &= ~( TAIE);// Disable interrupt. 
    
    ConfigureTimerUart();
    
    // convert to string  and send to host computer
    TXByte = (unsigned char) (velocity);
    Transmit(); 
    
    P1OUT ^= LED1;  // toggle the light every time we make a measurement.
    
    // set up timer to wake us in a while:
    __delay_cycles(50);       
      
  }
  
  
}

void PreApplicationMode(void)
{    
  P1DIR |= LED1 + LED2;
  P1OUT |= LED1;                 // To enable the LED toggling effect
  P1OUT &= ~LED2;
    
  /* these next two lines configure the ACLK signal to come from 
     a secondary oscillator source, called VLO */

  BCSCTL1 |= DIVA_1;             // ACLK is half the speed of the source (VLO)
  BCSCTL3 |= LFXT1S_2;           // ACLK = VLO
  
  /* here we're setting up a timer to fire an interrupt periodically. 
     When the timer 1 hits its limit, the interrupt will toggle the lights 

     We're using ACLK as the timer source, since it lets us go into LPM3
     (where SMCLK and MCLK are turned off). */

  TACCR0 = 1200;                 //  period
  TACTL = TASSEL_1 | MC_1;       // TACLK = ACLK, Up mode.  
  TACCTL1 = CCIE + OUTMOD_3;     // TACCTL1 Capture Compare
  TACCR1 = 600;                  // duty cycle
  __bis_SR_register(LPM3_bits + GIE);   // LPM3 with interrupts enabled
  // in LPM3, MCLCK and SMCLK are off, but ACLK is on.
}

void ConfigureTimerUart(){
  TACCTL0 = OUT;                 // TXD Idle as Mark
  TACTL = TASSEL_2 + MC_2 + ID_3;// set SMCLK as source, divide by 8, continuous mode
  P1SEL |= (TXD+RXD);
  P1DIR |= TXD;                               
}

/* using the serial port requires Transmit(), 
   the TIMERA0_VECTOR, ConfigureTimerUart() 
   and variables Bitcnt, TXbyte, Bitime */

// Function Transmits Character from TXByte 
void Transmit()
{ 

  BitCnt = 0xA;           // Load Bit counter, 8 data + Start/Stop bit
  TXByte |= 0x100;        // Add mark stop bit to TXByte
  TXByte = TXByte << 1;   // Add space start bit

  /*
  // The TI folks originally had the four lines of code below, but why?
  // replace with the single line after the comment ends

  //  Simulate a timer capture event to obtain the value of TAR into 
  //   the TACCR0 register.

  TACCTL0 = CM_1 + CCIS_2  + SCS + CAP + OUTMOD0;  //capture on rising edge, 
  // initially set to GND as input 
  TACCTL0 |= CCIS_3;	//change input to Vcc, rising the edge,
  // triggering the capture action
  while (!(TACCTL0 & CCIFG));	//wait till the interrupt happens.
  TACCR0 += Bitime;                        // Time till first bit
  */

  TACCR0 = TAR+ Bitime;
  TACCTL0 =  CCIS0 + OUTMOD0 + CCIE;   // TXD = mark = idle, enable interrupts
  // OUTMOD0 sets output mode 1: SET which will
  // have the CCR bit (our TX bit) to go high when the timer expires
  while ( TACCTL0 & CCIE );                   // Wait for TX completion
}


// Timer A0 interrupt service routine - 
#if defined(__TI_COMPILER_VERSION__)
#pragma vector=TIMER0_A0_VECTOR
__interrupt void Timer_A (void)
#else
  void __attribute__ ((interrupt(TIMER0_A0_VECTOR))) Timer_A (void)
#endif
{
  TACCR0 += Bitime;                         // Add Offset to TACCR0
  if ( BitCnt == 0){
    P1SEL &= ~(TXD+RXD);
    TACCTL0 &= ~ CCIE ;                   // All bits TXed, disable interrupt
  }  
  else{
    // in here we set up what the next bit will be: when the timer expires
    // next time.
    // In TimerConfigUart, we set OUTMOD0 for output mode 1 (set).
    // Adding OUTMOD2 gives output mode 5 (reset).
      
    // The advantage to doing this is that the bits get set in hardware 
    // when the timer expires so the timing is as accurate as possible.
    TACCTL0 |=  OUTMOD2;                  // puts output unit in 'set' mode
    if (TXByte & 0x01)
      TACCTL0 &= ~ OUTMOD2;               // puts output unit in reset mode
    TXByte = TXByte >> 1; // shift down so the next bit is in place.
    BitCnt --;
  }
}



  

// this gets used in pre-application mode only to toggle the lights:
#if defined(__TI_COMPILER_VERSION__)
#pragma vector=TIMER0_A1_VECTOR
__interrupt void ta1_isr (void)
#else
  void __attribute__ ((interrupt(TIMER0_A1_VECTOR))) ta1_isr (void)
#endif
{
  
  if(TACCTL1 & CCIFG){
    if (capture == 0){
      TACCTL1 &= ~CCIFG; // reset the interrupt flag
      if (Mode == PreAppMode){
	P1OUT ^= (LED1 + LED2); // toggle the two lights.
      }
      else{
	TACCTL1 = 0;                // no more interrupts.
	__bic_SR_register_on_exit(LPM3_bits);        // Restart the cpu
      }
    }
  
    else{
      // if recorded four data points, find delta t and calculate velocity
      if ( i >= 3){

	long delta_total = 0;
	int k;
	long delta_t;
	int m = 0;
	for (k = 0; k + 3<= i; k= k + 2){
	  long delta_a  = Times[k + 1]- Times[k];
	  long delta_b  = Times[k + 3]- Times[k + 2];
	  if (delta_b > delta_a){
	    delta_total += delta_b - delta_a ;
	    m++;
	  }
	  else {
	    delta_total += delta_a - delta_b ;
	    m++;
	  }
	}// calculates delta t for an array of any size
	
	delta_t =  2 *(delta_total)/m;
	velocity = 1000*20000000/(delta_t * 1166); // factor from speed of sound in air (34320 cm/s) and baseline signal of 40kHz to get velocity from doppler effect.
	i = 0;
	m = 0;

       	int delay =0 ;
	for(delay=0;delay<20000;delay++); 
	TACCTL1 &= ~CCIFG;                   // Reset the input flag

	__bic_SR_register_on_exit( LPM0_bits );		// Clear LMP0 bits so we are ruuning normal mode
	
      }
      else{
	TACCTL1 &= ~CCIFG;  // Reset the input flag
	Times[i] = TACCR1;  // Record time measurement
	i++;
      }
    }
    
    
  }
  else{
    TACTL &= ~TAIFG;
    if(overflowcounter<4){
      overflowcounter++;
      
    }else{
      overflowcounter=0;
      velocity = 0;
      TACTL &= ~TAIE;
      __bic_SR_register_on_exit( LPM0_bits ); // If no velocity reading is available, exit low power mode after a count of 4 timer A overflows.
    }
  }
}

void InitializeButton(void)                 // Configure Push Button 
{
  P1DIR &= ~BUTTON;
  P1OUT |= BUTTON;
  P1REN |= BUTTON;
  P1IES |= BUTTON;
  P1IFG &= ~BUTTON;
  P1IE |= BUTTON;
}

/* *************************************************************
 * Port Interrupt for Button Press 
 * 1. During standby mode: to enter application mode
 *
 * *********************************************************** */


#if defined(__TI_COMPILER_VERSION__)
#pragma vector=PORT1_VECTOR
__interrupt void port1_isr(void)
#else
  void __attribute__ ((interrupt(PORT1_VECTOR))) port1_isr (void)
#endif

{   
  
  /* this disables port1 interrupts for a little while so that
  we don't try to respond to two consecutive button pushes right together.
  The watchdog timer interrupt will re-enable port1 interrupts 

  This whole watchdog thing is completely unnecessary here, but its useful 
  to see how it is done.
*/
  P1IFG = 0;  // clear out interrupt flag
  P1IE &= ~BUTTON;         // Disable port 1 interrupts 
  WDTCTL = WDT_ADLY_250;   // set up watchdog timer duration 
  IFG1 &= ~WDTIFG;         // clear interrupt flag 
  IE1 |= WDTIE;            // enable watchdog interrupts
    
  TACCTL1 = 0;             // turn off timer 1 interrupts
  P1OUT &= ~(LED1+LED2);   // turn off the leds
  Mode = RunningMode;
  __bic_SR_register_on_exit(LPM3_bits); // take us out of low power mode
  
}

// WDT Interrupt Service Routine used to de-bounce button press

#if defined(__TI_COMPILER_VERSION__)
#pragma vector=WDT_VECTOR
__interrupt void wdt_isr(void)
#else
  void __attribute__ ((interrupt(WDT_VECTOR))) wdt_isr (void)
#endif

{
    IE1 &= ~WDTIE;                   /* disable watchdog interrupt */
    IFG1 &= ~WDTIFG;                 /* clear interrupt flag */
    WDTCTL = WDTPW + WDTHOLD;        /* put WDT back in hold state */
    P1IE |= BUTTON;             /* Debouncing complete - reenable port 1 interrupts*/
}

