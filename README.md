# nx-sftp-mod

*nx-sftp-mod* is a mod for running a SFTP server in NX500/NX1 cameras.

## How To Install

- Prerequisites
 - NX500 firmware version 1.12 or NX1 firmware version 1.41
 - nx-wake-on 1.0x
 - nx-patch 5.2

- Unzip the nx-sftp-mod.zip file to root of your SD card.
- Insert the SD card into your camera and power up the camera.
- Wait. The installation will be completed soon.

## How To Use

- Press the EV + MOBILE buttons to run the app launcher. Then select the 'SFTP Server' from the menu.
 - 'Start SFTP server'
 - 'Open Wi-Fi Settings'
 - 'Change password'
 - 'Show status'

- Use sftp clients to transfer files.

## License

GPL-3

## Emergency Recovery (Samsung NX500)

If installing prerequisites such as `nx-on-wake` leaves your **Samsung NX500** soft-bricked and unable to boot normally, you can enter the built-in firmware recovery mode without disassembly (verified on NX500; **not verified on NX1**):

1. Put an official, unmodified `nx500.bin` firmware file on the root of a clean FAT32 SD card and insert it.
2. Remove the battery, flip the rear display fully upward into the selfie position, and reinsert the battery.
3. Hold **MOBILE (Wi-Fi) + AEL + full Shutter** simultaneously, then switch the camera **ON**.
4. When **Recovery Mode** appears, release the buttons and **hold the shutter button** to flash `nx500.bin` (keep power connected until `Update Finish`).
