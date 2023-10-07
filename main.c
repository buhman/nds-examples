#include <stdint.h>

#define DISPCNT__DISPLAY__GRAPHICS (0b01 << 16)
#define DISPCNT__FORCED_BLANK (1 << 7)
#define DISPCNT__BG1 (1 << 9)
#define DISPCNT__BG0 (1 << 8)
#define DISPCNT__BG_MODE_0 (0b000 << 0)
#define DISPCNT 0x000

#define DB_DISPCNT 0x1000

#define BGxCNT__COLOR_MODE__16 (0b0 << 7)
#define BGxCNT__SCREEN_SIZE__256x256 (0b00 << 14)
#define BGxCNT__SCREEN_BASE_BLOCK(n) (((n) & 0b11111) << 8)
#define BGxCNT__CHARACTER_BASE_BLOCK(n) (((n) & 0b1111) << 2)
#define BG0CNT 0x008
#define BG1CNT 0x00a

void main()
{
  volatile uint32_t * io_reg32 = (volatile uint32_t *)0x04000000;
  volatile uint16_t * io_reg16 = (volatile uint16_t *)0x04000000;
  volatile uint16_t * bg_pram_a = (volatile uint16_t *)0x05000000;
  volatile uint16_t * bg_pram_b = (volatile uint16_t *)0x05000400;

  volatile uint32_t * bg_vram_a = (volatile uint32_t *)0x06000000;
  //volatile uint8_t * bg_vram_b = (volatile uint8_t *)0x06200000;

  bg_pram_a[0] = (31 << 10) | (0 << 5) | (31 << 0);
  bg_pram_a[1] = (31 << 10) | (0 << 5) | (3 << 0);

  bg_pram_b[0] = (31 << 10) | (14 << 5) | (14 << 0);

  io_reg32[DISPCNT / 4] = DISPCNT__DISPLAY__GRAPHICS
                        | DISPCNT__BG1
                        | DISPCNT__BG_MODE_0;

  io_reg16[BG1CNT / 2] = BGxCNT__SCREEN_SIZE__256x256
                       | BGxCNT__SCREEN_BASE_BLOCK(31)
                       | BGxCNT__COLOR_MODE__16
                       | BGxCNT__CHARACTER_BASE_BLOCK(0);

  // define character number 1 in character base block 0
  uint32_t character_size = 8 * 8 / 2; // in bytes (8x8 @ 4bpp)
  volatile uint32_t * character = &bg_vram_a[character_size];
  for (int i = 0; i < (character_size / 4); i++) {
    character[i] = (1 << 4) | (1 << 0); // set color index 1, two pixels at a time
  }

  // screen
  //volatile uint16_t * screen_base_block = (volatile uint16_t *)(bg_vram_a + (31 * 0x800));
  // show character number 1 at the top-left corner

  *((volatile uint16_t *)0x0600f800) = 1;

  while (1) {};
}
