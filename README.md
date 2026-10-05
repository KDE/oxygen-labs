# Declarative Oxygen icon configuration

Experimental data-driven icon configuration for KDE Plasma System Settings.
Themes describe their UI and restricted installation rules in JSON; Plasma
provides the shared parser, Qt Widgets dialog and user-local installation engine.

## Contents

- [plasma-icon-configuration](plasma-icon-configuration/): Plasma Workspace
  **v6.7.4** patch, opt-in CMake build/installer and rollback instructions.
- [oxygen-icons/oxygen-icons-widgets.patch](oxygen-icons/oxygen-icons-widgets.patch):
  Oxygen's configuration declaration, JSON settings, installation rule and
  documentation, exported from upstream commit
  [`b33ff8b9`](https://invent.kde.org/frameworks/oxygen-icons/-/commit/b33ff8b9).
  Those theme changes are already in upstream Oxygen Icons; do not apply the
  patch again if your checkout includes that commit.

The Plasma patch is based on commit
`fd05f4c88ab093aee23ce137bf6f2412437c9bba`. Read the
[build and installation instructions](plasma-icon-configuration/README.md)
before enabling `INSTALL_PATCHED_ICON_SETTINGS`.
Installing the Oxygen theme alone does not add configuration to stock Plasma.
Unpatched desktops ignore the extra metadata and continue using Oxygen normally.

Save preserves the theme's identity and applies settings immediately through a
same-ID user override. System artwork is not modified. Theme data cannot execute
scripts, load configuration plugins, choose arbitrary destinations or request
administrator access.

This is a prototype, not an upstream-approved Plasma feature or a prebuilt
distribution package. Installation paths and binary compatibility must match
your distribution. The opt-in installer backs up replaced Plasma components
and provides a checksum-checked rollback command.
