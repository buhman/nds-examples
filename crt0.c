#include <stdint.h>

extern uint32_t __bss_link_start __asm("__bss_link_start");
extern uint32_t __bss_link_end __asm("__bss_link_end");

extern void main();

void start(void)
{
  uint32_t * start;
  uint32_t * end;

  start = &__bss_link_start;
  end = &__bss_link_end;
  while (start < end) {
    *start++ = 0;
  }

  main();

  while (1);
}
