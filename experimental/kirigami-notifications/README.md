# Oxygen inline notifications

This Oxygen-Labs experiment gives Kirigami inline messages and native KDE
`KMessageWidget` notifications a shared Oxygen frame. The lower red frame
in the [design reference](mockup.svg) is the implemented version. Oxygen
draws the rounded rim, highlight, translucent status color and shadow.
Applications keep their existing message types, labels, icons and actions.

## Try it

On a patched Qt 6 desktop, select the Oxygen application style and run
`./preview` from this directory. The preview imports the public
`Kirigami.InlineMessage` component. Select **Success**, **Information**,
**Warning** or **Error** to change the header and reopen its inline example.
On a stock desktop the same preview shows the installed Kirigami appearance.

To see the native widget, open **Oxygen Demo → Frames**. Both the preview and
the demo load their style at startup. Reopen them after installing a change.

## Build the experiment

Each patch applies inside its own KDE Git checkout. Use the listed revisions
and a Qt 6 KDE development environment with the matching build dependencies.

| Repository | Tested base | Patch |
| --- | --- | --- |
| Kirigami | `51e5b39b337167b1fd553d34326959f952c3760b` | [Expose message layout and close-icon properties](patches/kirigami.patch) |
| QQC2 Desktop Style | `b8ab0e67d9ab35c662c839e02ff926be289c0f12` | [Install the desktop delegate and call the active style](patches/qqc2-desktop-style.patch) |
| Oxygen | `16a1f518f1f2d498ab4a64ee8d0e43a87777359a` | [Provide the frame painter, status colors and spacing](patches/oxygen.patch) |
| KWidgetsAddons | `v6.31.0` (`259b994c32e2`) | [Use the style painter in native message widgets](patches/kwidgetsaddons.patch) |

For example, with `labs` set to the absolute path of this experiment and
`prefix` set to your KDE development prefix, run these commands inside the
Oxygen checkout. Set `repository` to the corresponding patch name when
repeating the procedure in the other checkouts.

```sh
repository=oxygen
git apply --check "$labs/patches/$repository.patch"
git apply "$labs/patches/$repository.patch"
cmake -S . -B build -G Ninja -DCMAKE_INSTALL_PREFIX="$prefix" -DCMAKE_PREFIX_PATH="$prefix"
cmake --build build
cmake --install build
```

Build Kirigami before QQC2 Desktop Style. Launch the preview from the KDE
development environment for that prefix so Qt finds its plugins and QML
modules. KWidgetsAddons supplies the native-widget integration.

## Style behavior

The shared painter receives the surface color in `QPalette::Window` and the
status accent in `QPalette::Highlight`. Kirigami uses the style's content
padding (12 logical pixels horizontally and 8 vertically). Header messages
also have an outer gap of 10 pixels horizontally and 4 vertically. Inline
and footer messages have no outer gap. Native widgets retain their existing
layout. Styles that omit the custom control element use the toolkit fallback.
