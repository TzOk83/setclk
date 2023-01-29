# setclk
SETCLK is a tiny executable to set a CPU clock on FE2010A/PT8010AF baset IBM-PC/XT clones.

Please note that configuration register on this chipset is write-only, so this utility is unable to read it's "current" state, so some assumptions had to be made. Presence of the FPU is chcecked in the BIOS Equipment List, and it is assumed that there is no memory parity, and memory operates with 0 Wait States.

Configuration register of FE2010A is at port 63h, and has the following structure:
```
 84218421
 **...... -- CPU Clock (00 = 4.77 MHz, 01 = 7.15 MHz, 10 = 9.54 MHz)
 ..*..... -- No Memory Wait States (1 = 0 WS)
 ...*.*.. -- RAM Size (00 = 640 kB, 01 = 256 kB, 10 = 512 kB)
 ....*... -- Configuration Freeze (0 = no freeze, 1 = only bits 5-7 can be altered)
 ......*. -- FPU Enabled (0 = No FPU, 1 = FPU Present)
 .......* -- Disable Parity Check (0 = Parity Check Enabled, 1 = Parity Check Disabled)
```
