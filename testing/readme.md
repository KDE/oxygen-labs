# Testing Tier (`testing/`)

This directory is for components in the **testing** maturity tier of Oxygen-Labs.

## What acceptable code goes here?
- **Functional Prototypes:** Code where the main idea is fully implemented and useful enough to try out in a real environment.
- **Components Needing Validation:** Prototypes with working core mechanics that require user testing, empirical feedback, and validation of edge cases.
- **Requirements:**
  - Must include clear installation instructions and warnings about expected rough edges or potential regressions.
  - Must provide backup and rollback mechanisms (e.g., automated CMake backup scripts) for any system components replaced.
  - Expect missing features, incomplete error handling, or performance tuning needs.

## Code Quality & Review Policy
- **No Unreviewed AI Code ("Vibecoding"):** No "vibecoded", non-human-reviewed, or un-understood code is allowed past this point. Every line of code must be thoroughly read, understood, and vouched for by a human contributor.
