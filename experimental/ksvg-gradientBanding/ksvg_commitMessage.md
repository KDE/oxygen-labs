Dither gradients in theme SVGs to avoid banding

Large, subtle gradients in Plasma theme backgrounds (dialogs, panels,
tooltips) show visible banding, because the colors only change by a few
steps over hundreds of pixels and get rounded to 8 bits.

Theme SVGs that contain gradients are now rendered at 16 bits per channel
and then reduced to 8 bits with ordered (Bayer) dithering. Colors that fit
exactly in 8 bits are left untouched, so flat areas look the same as
before; only gradients get a fine, practically invisible grain.

SVGs without gradients and files loaded by absolute path keep using the
old rendering path. The pixmap cache key gets a version suffix so that
already cached, banded renders are replaced once after updating.
