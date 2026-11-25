# Oxygen switches for Qt Quick Controls

This experiment lets Oxygen paint the switches used by Kirigami applications.
The Bluetooth toggle in System Settings is the design reference.

## Appearance

The indicator measures **46 × 26 logical pixels**. Its **20-pixel handle** has 3 pixels of clearance above and below, and the same clearance at either end of travel. Oxygen paints the slider face directly at the requested size. A short contact shadow sits under the handle. A separate shadow follows the inside edge of the groove, darkest at the top and faint at the bottom. The checked groove uses the palette highlight, with most of the shading confined to the rim.

## How the two projects fit together

- **Oxygen** registers a custom control element named `CE_SwitchIndicator`. It advertises the element ID and its preferred size through two Qt properties on the style object, `kdeSwitchControlElement` and `kdeSwitchIndicatorSize`. Its painter reuses `drawSliderSlab()` for the handle.
- **QQC2 Desktop Style** queries the active widget style for those properties. Its shared `SwitchIndicator.qml` serves both `Switch` and `SwitchDelegate`. The private `StyleItem` passes a `QStyleOptionSlider` to the advertised painter, including checked, pressed, hover and keyboard-focus state. The slider position comes from the control’s physical `visualPosition`, which already accounts for right-to-left layouts.
- **Compatibility.** The existing QML indicator is the fallback when a style does not advertise the capability. Either package can land first. Both are needed to see the Oxygen artwork. The application continues to own input, accessibility and toggle state.

## Build and preview

The [review patch](oxygen-switch.patch) covers Oxygen v6.8.2
(`7af3bc4bb04f`) and QQC2 Desktop Style v6.31.0 (`2efe38d55ebc`).
Set `labs` to this experiment's absolute path. In a fresh working directory
outside the Labs checkout, run the following commands.

```sh
git clone --branch v6.8.2 --depth 1 https://invent.kde.org/plasma/oxygen.git oxygen
git clone --branch v6.31.0 --depth 1 https://invent.kde.org/frameworks/qqc2-desktop-style.git qqc2-desktop-style
git apply --check "$labs/oxygen-switch.patch"
git apply "$labs/oxygen-switch.patch"
```

Build the Qt 6 Oxygen style plugin and QQC2 Desktop Style in your KDE
development environment and install both into its prefix. Select Oxygen as
the application style, then launch the preview in that environment.

```sh
QT_QUICK_CONTROLS_STYLE=org.kde.desktop qml6 -a widget "$labs/Preview.qml"
```

Drag the handle or focus the switch with Tab and press Space. The preview
includes a slider and a switch delegate for comparison. The related
[notification experiment](../kirigami-notifications/) lists its own KDE base revisions.
