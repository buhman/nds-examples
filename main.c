#include <stdint.h>

#define DISPCNT__DISPLAY_ON   (1 << 16)
#define DISPCNT__FORCED_BLANK (1 << 7)
#define DISPCNT 0x000

void main()
{
  //volatile uint32_t * io_reg = (volatile uint32_t *)0x4000000;
  volatile uint16_t * pram = (volatile uint16_t *)0x5000000;

  uint16_t color = (7 << 10) | (31 << 5) | (31 << 0);
  pram[0] = color;

  while (1) { asm volatile ("nop"); };
}
