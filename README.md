# Oxygen-Labs

![Oxygen Labs logo](oxygen-labs.png)

Oxygen-Labs is an umbrella project for experimental Oxygen-related desktop
work. 
A place were serious experimentation on all things UI will occur, nothing is to silly 
to not be seriously experimented. in here...  

## Maturity tiers

The directories tell you what to expect before trying something, not just how
long it has been around:

- **experimental/**: things that are almost guaranteed to break something.
  This is where we try ideas, throw away approaches and find out what is
  possible. Expect unfinished code, changing interfaces and broken workflows.
  Use a disposable test environment, not a desktop you depend on.
- **testing/**: things that kind of work. The main idea is implemented and
  useful enough to try, but rough edges, regressions and missing cases are
  still expected. This is where we need testing and feedback. Keep backups
  and a way to undo the installation.
- **ready/**: things we think are ready to leave the lab. The intended
  behaviour is documented, relevant checks pass and known limitations are
  stated. The work should be ready for upstream review or integration, but
  it is not a promise of perfection or a substitute for KDE review.

Components move forward when the evidence supports it, and can move back if
new problems turn up. These are Oxygen-Labs development stages, not KDE
approval or release status. Moving a component between tiers does not enable
it automatically; installation remains an explicit choice.

## Current components

[oxygen-weather](experimental/oxygen-weather/) is in **experimental/**:
a separate weather applet based on KDE Weather Report and its original
authors' work, with an experimental Oxygen-oriented layout. Enable it explicitly
with `-DBUILD_OXYGEN_WEATHER=ON`; it does not replace the upstream applet.

[plasma-icon-configuration](testing/plasma-icon-configuration/) is in
**testing/**: Plasma Workspace **v6.7.4** KCM integration, opt-in CMake
build/installer and rollback instructions. The implementation currently lives
in a patch against the pinned Workspace source, not a standalone replacement
KCM. Oxygen artwork and theme metadata remain in the separate
[Oxygen Icons project](https://invent.kde.org/frameworks/oxygen-icons).

## Building the umbrella project

The default build downloads nothing and installs nothing. Enable the icon
configuration component explicitly:

```bash
cmake -S /path/to/Oxygen-Labs -B build -G Ninja \
    -DINSTALL_PATCHED_ICON_SETTINGS=ON -DBUILD_TESTING=ON \
    -DCMAKE_INSTALL_PREFIX=/path/to/test-prefix
cmake --build build
QT_QPA_PLATFORM=offscreen ctest --test-dir build -R themeconfigtest --output-on-failure
cmake --install build --component IconConfiguration
```

The component can also be configured directly from its own directory. Read its
dependency, installation-path and rollback instructions before installing.
Oxygen artwork is maintained separately and is not installed by this project.

The Plasma patch is based on commit
`fd05f4c88ab093aee23ce137bf6f2412437c9bba`. Read the
[build and installation instructions](testing/plasma-icon-configuration/README.md)
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
## Licensing

Oxygen-Labs uses the GNU General Public License, version 2 or later
([COPYING](COPYING)), except where individual files specify another license.
Existing upstream copyright and license notices remain authoritative.
SPDX license texts are provided in [LICENSES/](LICENSES/), including the
LGPL-2.0-or-later and BSD-3-Clause licenses used by some weather applet files.
