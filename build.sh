set -eux

arm-none-eabi-as -g header.s -o header.o
arm-none-eabi-as -g start.s -o start.o
arm-none-eabi-gcc -Os -march=armv5te -mtune=arm946e-s -ffreestanding -ffunction-sections -nostdlib -Wall -Werror -g main.c -c -o main.o
arm-none-eabi-ld -T main.lds header.o start.o main.o -o main.elf
arm-none-eabi-objcopy -O binary main.elf main.nds

python patch.py main.nds
