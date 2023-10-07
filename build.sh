set -eux

CFLAGS="-Os -march=armv5te -mtune=arm946e-s -ffreestanding -ffunction-sections -nostdlib -Wall -Werror"

arm-none-eabi-as -g header.s -o header.o
arm-none-eabi-as -g start.s -o start.o
arm-none-eabi-gcc $CFLAGS -g crt0.c -c -o crt0.o
arm-none-eabi-gcc $CFLAGS -g main.c -c -o main.o
arm-none-eabi-ld -T main.lds header.o start.o crt0.o main.o -o main.elf
arm-none-eabi-objcopy -O binary main.elf main.nds

python patch.py main.nds
