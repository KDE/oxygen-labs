// SPDX-License-Identifier: LGPL-2.0-or-later
import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: window
    visible: true
    title: qsTr("Kirigami inline message preview")
    width: Kirigami.Units.gridUnit * 40
    height: Kirigami.Units.gridUnit * 27

    pageStack.initialPage: Kirigami.Page {
        id: page
        title: qsTr("Notification Testing")
        header: Kirigami.InlineMessage {
            id: banner
            objectName: "previewBanner"
            visible: true
            showCloseButton: true
            position: Kirigami.InlineMessage.Position.Header
            type: Kirigami.MessageType.Positive
            text: qsTr("The icon theme settings have been saved and applied.")
        }

        readonly property var examples: [
            { label: qsTr("Success"), sample: qsTr("A positive message"), severity: Kirigami.MessageType.Positive, message: qsTr("The icon theme settings have been saved and applied.") },
            { label: qsTr("Information"), sample: qsTr("An information message"), severity: Kirigami.MessageType.Information, message: qsTr("Choose an icon theme to preview it.") },
            { label: qsTr("Warning"), sample: qsTr("A warning message"), severity: Kirigami.MessageType.Warning, message: qsTr("The selected icon theme is incomplete.") },
            { label: qsTr("Error"), sample: qsTr("An error message"), severity: Kirigami.MessageType.Error, message: qsTr("The icon theme could not be loaded.") }
        ]

        ColumnLayout {
            anchors.fill: parent
            spacing: 6
            Flow {
                Layout.fillWidth: true
                Layout.preferredHeight: childrenRect.height
                spacing: Kirigami.Units.smallSpacing
                Repeater {
                    model: page.examples
                    QQC2.Button {
                        required property int index
                        required property var modelData
                        text: modelData.label
                        onClicked: {
                            banner.type = modelData.severity
                            banner.text = modelData.message
                            banner.visible = true
                            inlineMessages.itemAt(index).visible = true
                        }
                    }
                }
            }

            Repeater {
                id: inlineMessages
                model: page.examples
                Kirigami.InlineMessage {
                    required property var modelData
                    Layout.fillWidth: true
                    type: modelData.severity
                    text: modelData.sample
                    showCloseButton: true
                    visible: true
                }
            }
            Item { Layout.fillHeight: true }
        }
    }
}
