# Oxygen Gradient Banding - Code Mockup Explanation

## What this is for (Simple Terms)
This patch addresses visible color banding artifacts in Oxygen's window background gradients (titlebars and window contents), which otherwise show wide bands due to subtle color steps rounded to 8 bits. By computing gradients at full/16-bit precision and applying ordered (Bayer) dithering down to 8 bits, it removes visible banding and provides a smooth transition while keeping flat areas clean.

## Code Mockup & Validation Status
This implementation is **a code mockup built quickly to test and validate a proposed technical solution** requiring external validation and feedback. It serves as an exploratory prototype to demonstrate feasibility and gather empirical results before any formal upstream design or proposal.
