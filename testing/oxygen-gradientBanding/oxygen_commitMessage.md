liboxygen: dither window background gradients to avoid banding

Oxygen's window background gradient only changes by a few color steps
over hundreds of pixels, so rounding to 8 bits produces wide visible
bands, especially with dark color schemes.

The vertical gradient is now computed directly at full precision and the
radial glow is painted at 16 bits per channel; both are then reduced to
8 bits with ordered (Bayer) dithering. Colors that fit exactly in 8 bits
are left untouched, so only the gradients get a fine, practically
invisible grain.

The gradient stops are rounded to 8 bits first, so the gradient ends on
exactly the color of the flat area below it and the two meet without a
visible step. Since the window decoration uses the same helper, this
fixes both the titlebar and the window contents.
