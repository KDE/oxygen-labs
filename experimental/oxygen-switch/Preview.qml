// SPDX-License-Identifier: LGPL-2.0-or-later
import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts

Controls.ApplicationWindow {
    visible: true
    width: 340
    height: 180
    title: "Oxygen switch preview"

    ColumnLayout {
        anchors.centerIn: parent
        Controls.Slider { value: 0.5 }
        RowLayout {
            Controls.Switch { text: checked ? "On" : "Off" }
            Controls.Switch { text: checked ? "On" : "Off"; checked: true }
        }
        Controls.SwitchDelegate { text: "List row"; checked: true }
    }
}
