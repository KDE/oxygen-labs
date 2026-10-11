# Oxygen-Labs: declarative icon configuration for Plasma

This is the first component of [Oxygen-Labs](../../README.md), the parent project
for experimental Oxygen-related work.
It is in the **testing** tier: the implementation works, but is still undergoing
validation and feedback. This does not imply upstream Plasma acceptance.

This prototype adds a configuration pencil to System Settings > Icons for
themes declaring `X-KDE-IconConfiguration=DeclarativeV1` and providing a valid
`icon-settings.json`. The theme supplies data only; Plasma supplies the parser,
restricted installation engine and generic Qt Widgets dialog.

`plasma-workspace-widgets-v6.7.4.patch` contains the implementation and
regression tests, based on KDE Plasma Workspace tag `v6.7.4`, commit
`fd05f4c88ab093aee23ce137bf6f2412437c9bba`.

## Building

The Oxygen-Labs root project, or this component configured on its own,
downloads the pinned Plasma source,
applies the patch and builds only the Icons settings module, shared renderer
and relevant tests. By default it does nothing; no source is downloaded and
nothing is installed until explicitly enabled.

```bash
cmake -S /path/to/Oxygen-Labs -B build -G Ninja \
    -DINSTALL_PATCHED_ICON_SETTINGS=ON -DBUILD_TESTING=ON \
    -DCMAKE_INSTALL_PREFIX=/path/to/test-prefix
cmake --build build
QT_QPA_PLATFORM=offscreen ctest --test-dir build -R themeconfigtest --output-on-failure
cmake --install build --component IconConfiguration
```

Build dependencies include Git, CMake 3.29+, a C++23 compiler, ECM 6.29+,
Qt 6.10+ development packages and KDE Frameworks development packages for
KCMUtils, Config, I18n, IconThemes, Archive, KIO and NewStuff. The target Plasma
version is **6.7.4**; do not assume binary compatibility with other releases.
Compilation is for the shared Plasma implementation, never theme-provided code.

The helper's fixed libexec path is determined at configuration time, so
configure the correct installation prefix and layout before building.
A custom prefix is not automatically loaded by normal System Settings.
For example, on Arch/Manjaro with matching Plasma and Frameworks versions:

```bash
cmake -S /path/to/Oxygen-Labs -B build-native -G Ninja \
    -DINSTALL_PATCHED_ICON_SETTINGS=ON -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
cmake --build build-native
QT_QPA_PLATFORM=offscreen ctest --test-dir build-native -R themeconfigtest --output-on-failure
sudo cmake --install build-native --component IconConfiguration
```

Other distributions may use different plugin or libexec directories.
Installation never requests administrator access automatically; elevation
is the user's explicit choice. Close and reopen System Settings afterward.
The install step backs up existing files and records absent files under
`<prefix>/share/plasma-icon-configuration/backups/`. It prints a rollback command:

```bash
sudo cmake -DBACKUP_DIR=/path/printed/during/install \
    -P /path/printed/during/install/RestoreInstallation.cmake
```

Rollback checks original and installed checksums and refuses to overwrite
files changed subsequently by a package update. When multiple versions were
installed, restore their backups in reverse installation order. This restores
the Plasma components only, not user artwork preferences or theme selection.
Use `DESTDIR` for package staging rather than overwriting a running desktop.
Only the KCM and helper are installed; unchanged Workspace utilities are excluded.

The relevant runtime pieces are `kcm_icons.so` and
`plasma-icon-theme-config`. Oxygen's `index.theme` declaration and adjacent
`icon-settings.json` must also be installed with its artwork.

## Behavior and scope

Save applies immediately to the same theme identity, not a new configured
theme tile. A system-installed theme gets a same-ID user override under the
user's standard icon directory; packaged artwork is never modified.
Original user-installed artwork is retained in the hidden
`icons/.icon-config-sources/<theme-id>/` directory for later restoration.
Cancel writes nothing; Defaults restores the declaration's checkbox defaults.

The JSON separates UI controls from conditional installation rules.
The supported operations are deliberately restricted to `userThemeCopy`
and `omitDirectories`. Scripts, executable plugins, arbitrary destination
paths and administrator access cannot be requested by theme data.
Interactive Save runs in a worker thread; image copying avoids a durable
sync for each individual artwork file.

Normal KDE icon-size and inheritance fallback remains unchanged. These
controls change available artwork directories, not strict requested-size
lookup policy. Unpatched desktops ignore the extra metadata and continue
using the theme normally, without configuration controls.

This is experimental support, not an upstream-approved or released Plasma
feature. The schema and implementation may change during upstream review.
The Oxygen Icons README documents its declaration and examples.
