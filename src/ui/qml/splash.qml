import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12

// Qt Labs
import Qt.labs.settings 1.0

Window {
    id: windowSplash

    width: dialogSplash.width + 100
    height: dialogSplash.height + 140
    visible: true
    flags: Qt.SplashScreen | Qt.BypassWindowManagerHint | Qt.CustomizeWindowHint | Qt.WindowStaysOnTopHint
    color: "transparent"
    x: (Screen.width - width)/2
    y: (Screen.height - height)/2

    Settings {
        id: settings
    }

    Material.theme: ~~settings.value("style/theme", Material.Light)

    Dialog {
        id: dialogSplash
        anchors.centerIn: Overlay.overlay
        visible: true
        closePolicy: Dialog.NoAutoClose
        standardButtons: Dialog.Abort

        Component.onCompleted: {
            standardButton(Dialog.Abort).Material.accent = Material.Red
            standardButton(Dialog.Abort).highlighted = true
        }

        onRejected: Qt.exit(-1)
        onClosed: windowSplash.visible = false

        width: implicitWidth + implicitWidth % 2
        height: implicitHeight + implicitHeight % 2

        ColumnLayout {
            anchors.fill: parent

            Image {
                id: imageLogo
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/icons/app/appIcon.svg"
                sourceSize: Qt.size(128, 128)
            }

            Label {
                id: labelApplicationName
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                text: Qt.application.name
                font.pointSize: Qt.application.font.pointSize * 3
                // you may want to use a different font here
            }

            Label {
                id: labelApplicationDescription
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                font.pointSize: Qt.application.font.pointSize * 2
                text: qsTr("Description of the application")
            }

            RowLayout {
                clip: true
                Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
                Layout.topMargin: 20

                BusyIndicator {
                    id: busyIndicator
                    running: visible
                    implicitWidth: 32
                    implicitHeight: busyIndicator.implicitWidth
                }
                Label {
                    text: qsTr("Loading...")
                    font.italic: true
                }
            }
        } // ColumnLayout
    } // Dialog

    Loader {
        id: loader
        source: "main.qml"
        asynchronous: true

        onLoaded: {
            dialogSplash.standardButton(Dialog.Abort).enabled = false
            dialogSplash.close()
        }
    }
}
