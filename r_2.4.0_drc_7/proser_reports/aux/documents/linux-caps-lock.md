I figured one good script deserved another, so I began to look into just how that sort of keysym changing really works under the hood. I checked out the man page for xmodmap and found I could access the entire keysym list by entering:

$ xmodmap -pk

That lists the keysyms in hexadecimal; at 7 keysyms per keycode and 255 keycodes, be prepared to scroll if you’re looking for something special. I lucked out: right up at the top is 0x0000, for No symbol – Caps Lock doesn’t do anything. I realized I had found the way those old-time keyboard-altering GUIs worked! On the spot I did my new Caps Lock-disabling script:

!
! Set Caps_Lock to no symbol
!
remove Lock = Caps_Lock
keysym Caps_Lock = 0x0000

and saved it as .killer in the Application Autostart part of the Settings Manager.

xmodmap /home/jorge/.killer

turn on:
xmodmap -e 'keycode 0x42 = Caps_Lock'

xmodmap -e 'keycode 0x00 = Caps_Lock'