liboxygen: dither window background gradients to avoid banding

Oxygen's window background and group box gradients only change by a few
color steps over hundreds of pixels, so rounding to 8 bits produces wide
visible bands, especially with dark color schemes.

These gradients are now computed at full precision (or painted at 16 bits
per channel) and reduced to 8 bits with ordered (Bayer) dithering. Colors
that fit exactly in 8 bits are left untouched, so only the gradients get a
fine, practically invisible grain. This covers the vertical window
gradient, the radial glow at the top, and the group box fill along with
its bottom fade.

The window gradient's stops are rounded to 8 bits first, so it ends on
exactly the color of the flat area below it and the two meet without a
visible step. Since the window decoration uses the same helper, this fixes
both the titlebar and the window contents.
