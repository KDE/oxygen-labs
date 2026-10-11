# Oxygen Weather

An experimental, separately installable Plasma applet based on KDE's
**Weather Report**. This is a layout experiment, not an original weather
implementation or a replacement for the upstream applet.

## Upstream authors and source

Based on `applets/weather` in
[KDE Plasma Addons](https://invent.kde.org/plasma/kdeplasma-addons),
tag **v6.7.4**, commit `57ab0e90662dd258bf35d07c1c0503a260f7d16d`.
The original applet metadata credits **Luís Gabriel Lima**. Source contributions
include **Petri Damstén**, **Friedrich W. H. Kossebau**, **Bohdan Onofriichuk**
and the other authors credited in individual files.

Original copyright and SPDX license notices are retained. Corresponding license
texts are included in `LICENSES/`. Nuno Pinheiro's layout experiment builds on
that work; weather retrieval, models, configuration and most UI remain upstream
code.

## Layout changes

- A 200px current-condition icon inside an unclipped 256 x 160px area.
- Wind direction and speed below the temperature.
- 48px symbolic forecast icons with an 8px top margin.
- Empty precipitation percentages stay blank while retaining row alignment.
- Adjusted town-heading inset and correct wind-speed unit conversion.

The plugin ID is `org.kde.oxygenlabs.weather`, with a separate QML module and
configuration identity. It can coexist with `org.kde.plasma.weather`.
The applet uses installed Plasma Weather libraries, providers and upstream
translation catalogs, rather than installing replacements. Its custom wind
arrows are embedded in the applet, without changing desktop-theme artwork.
Keep KDE's Weather Report components installed.

## Building

Requires Qt 6.10+, KDE Frameworks 6, ECM, a C++20 compiler and Plasma development
packages providing `plasma_add_applet` and the `Plasma::Weather::Ion` and
`Plasma::Weather::Data` targets. There is no fixed KDE Frameworks or Plasma
minor-version requirement: compatibility is determined by the available APIs,
not a Plasma 6.7 version check.

Developed and tested against Plasma 6.7.4. Other versions with compatible APIs
can be built, but have not yet been validated. Older weather implementations
without these libraries, Plasma 5 and Qt 5 are not supported. The installed
Plasma Weather package may impose its own dependency versions. Build against
the development packages matching the Plasma installation that will load the
applet; removing version checks does not guarantee binary compatibility.

```bash
cmake -S /path/to/Oxygen-Labs -B build -G Ninja \
    -DBUILD_OXYGEN_WEATHER=ON -DCMAKE_INSTALL_PREFIX=/path/to/test-prefix
cmake --build build --target org.kde.oxygenlabs.weather
cmake --install build
```

Alternatively configure this directory directly. The umbrella option is off
by default. A custom prefix is not automatically searched by Plasma; use
distribution-correct plugin paths for an actual installation. This applet does
not install or overwrite KDE's Weather Report plugin or weather libraries.

This belongs in **experimental/**: fixed layout dimensions and real-world
provider, panel, scaling and accessibility behaviour still need broader testing.
Report problems in Oxygen-Labs, not against the original authors' applet.
