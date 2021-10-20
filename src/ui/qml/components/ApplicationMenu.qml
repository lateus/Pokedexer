import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Drawer {
    id: applicationMenu

    property alias currentIndex: listViewMenu.currentIndex
    property int lastValidIndex: 0
    
    property var delegateComponentMap: {
        "CheckDelegate":    componentSwitchDelegate,
        "ItemDelegate":     componentItemDelegate,
        "Separator":        componentSeparator
    }
    
    property var labelTextMap: {
        "Pokédex":      pokedexString,
        "Movedex":      movedexString,
        "Abilitydex":   abilityString,
        "Itemdex":      itemdexString,
        "Berrydex":     berrydexString,
        "Typedex":      typedexString,
        "Naturedex":    naturedexString,
        "Locationdex":  locationdexString,
        "Team builder": teamBuilderString,
        "Dark mode":    darkModeString,
        "About":        aboutString,
        "About Qt":     aboutQtString,
        "License":      licenseString
    }
    
    // for translation (if not the game menu strings are no translated with QQMLEngine::retranslate())
    property string pokedexString:      qsTr("Pokédex")
    property string movedexString:      qsTr("Movedex")
    property string abilityString:      qsTr("Abilitydex")
    property string itemdexString:      qsTr("Itemdex")
    property string berrydexString:     qsTr("Berrydex")
    property string typedexString:      qsTr("Typedex")
    property string naturedexString:    qsTr("Naturedex")
    property string locationdexString:  qsTr("Locationdex")
    // ---
    property string teamBuilderString:  qsTr("Team builder")
    // ---
    property string darkModeString:     qsTr("Dark mode")
    // ---
    property string aboutString:        qsTr("About") + " " + Qt.application.name
    property string aboutQtString:      qsTr("About Qt")
    property string licenseString:      qsTr("License")

    signal pokedexRequested()
    signal movedexRequested()
    signal abilitydexRequested()
    signal itemdexRequested()
    signal berrydexRequested()
    signal typedexRequested()
    signal naturedexRequested()
    signal locationdexRequested()

    signal teamBuilderRequested()

    signal aboutRequested()
    signal aboutQtRequested()
    signal licenseRequested()

    Material.elevation: applicationHeader.Material.elevation
    
    ListModel {
        id: listModelMenu
        
        ListElement {
            type: "ItemDelegate"
            mainText: "Pokédex"
            itemChecked: false
        }
        
        ListElement {
            type: "ItemDelegate"
            mainText: "Movedex"
            itemChecked: false
        }
        
        ListElement {
            type: "ItemDelegate"
            mainText: "Abilitydex"
            itemChecked: false
        }
        
        ListElement {
            type: "ItemDelegate"
            mainText: "Itemdex"
            itemChecked: false
        }
        
        ListElement {
            type: "ItemDelegate"
            mainText: "Berrydex"
            itemChecked: false
        }
        
        ListElement {
            type: "ItemDelegate"
            mainText: "Typedex"
            itemChecked: false
        }
        
        ListElement {
            type: "ItemDelegate"
            mainText: "Naturedex"
            itemChecked: false
        }
        
        ListElement {
            type: "ItemDelegate"
            mainText: "Locationdex"
            itemChecked: false
        }
        
        // ---
        ListElement {
            type: "Separator"
            mainText: ""
            itemChecked: false
        }
        
        ListElement {
            type: "ItemDelegate"
            mainText: "Team builder"
            itemChecked: false
        }
        
        // ---
        ListElement {
            type: "Separator"
            mainText: ""
            itemChecked: false
        }
        
        ListElement {
            type: "CheckDelegate"
            mainText: "Dark mode"
            itemChecked: false
        }
        
        // ---
        ListElement {
            type: "Separator"
            mainText: ""
            itemChecked: false
        }
        
        ListElement {
            type: "ItemDelegate"
            mainText: "About"
            itemChecked: false
        }
        
        ListElement {
            type: "ItemDelegate"
            mainText: "About Qt"
            itemChecked: false
        }
        
        ListElement {
            type: "ItemDelegate"
            mainText: "License"
            itemChecked: false
        }
    } // listModelMode
    
    Component {
        id: componentItemDelegate
        
        ItemDelegate {
            id: itemDelegateMenu
            
            readonly property var iconSourceMap: {
                "Pokédex":      "qrc:/images/icons/menu/pokeball.svg",
                "Movedex":      "qrc:/images/icons/menu/swords.svg",
                "Abilitydex":   "qrc:/images/icons/user/security.svg",
                "Itemdex":      "qrc:/images/icons/menu/item.svg",
                "Berrydex":     "qrc:/images/icons/menu/cherry.svg",
                "Typedex":      "qrc:/images/icons/menu/tag.svg",
                "Naturedex":    "qrc:/images/icons/menu/up_down.svg",
                "Locationdex":  "qrc:/images/icons/menu/location.svg",
                "Team builder": "qrc:/images/icons/menu/repair.svg",
                "About":        "qrc:/images/icons/menu/help.svg",
                "About Qt":     "qrc:/images/icons/qt/qt_logo_white.svg",
                "License":      "qrc:/images/icons/license.svg"
            }
            
            text: applicationMenu.labelTextMap[labelText]
            icon.source: iconSourceMap[labelText]
            highlighted: idx === listViewMenu.currentIndex
            Material.foreground: highlighted ? Material.accent : parent.Material.foreground
            
            onClicked: {
                switch (labelText) {
                case "Pokédex":
                    if (currentIndex !== 0) {
                        pokedexRequested()
                        currentIndex = 0
                        lastValidIndex = currentIndex
                    }
                    break
                case "Movedex":
                    if (currentIndex !== 1) {
                        movedexRequested()
                        currentIndex = 1
                        lastValidIndex = currentIndex
                    }
                    break
                case "Abilitydex":
                    if (currentIndex !== 2) {
                        abilitydexRequested()
                        currentIndex = 2
                        lastValidIndex = currentIndex
                    }
                    break
                case "Itemdex":
                    if (currentIndex !== 3) {
                        itemdexRequested()
                        currentIndex = 3
                        lastValidIndex = currentIndex
                    }
                    break
                case "Berrydex":
                    if (currentIndex !== 4) {
                        berrydexRequested()
                        currentIndex = 4
                        lastValidIndex = currentIndex
                    }
                    break
                case "Typedex":
                    if (currentIndex !== 5) {
                        typedexRequested()
                        currentIndex = 5
                    }
                    break
                case "Naturedex":
                    if (currentIndex !== 6) {
                        naturedexRequested()
                        currentIndex = 6
                        lastValidIndex = currentIndex
                    }
                    break
                case "Locationdex":
                    if (currentIndex !== 7) {
                        locationdexRequested()
                        currentIndex = 7
                        lastValidIndex = currentIndex
                    }
                    break
                case "Team builder":
                    if (currentIndex !== 9) {
                        teamBuilderRequested()
                        currentIndex = 9
                        lastValidIndex = currentIndex
                    }
                    break
                case "About":
                    if (currentIndex !== 13) {
                        aboutRequested()
                        currentIndex = 13
                    }
                    break
                case "About Qt":
                    if (currentIndex !== 14) {
                        aboutQtRequested()
                        currentIndex = 14
                    }
                    break
                case "License":
                    if (currentIndex !== 15) {
                        licenseRequested()
                        currentIndex = 15
                    }
                    break
                }
                close()
            } // onClicked event
        } // ItemDelegate
    } // Component (ItemDelegate)
    
    Component {
        id: componentSwitchDelegate
        
        SwitchDelegate {
            id: switchDelegateMenu
            
            text: applicationMenu.labelTextMap[labelText]
            checked: applicationWindow.Material.theme === Material.Dark
            icon.source: "qrc:/images/icons/night_mode.svg"
            Binding { target: switchDelegateMenu.parent; property: "isChecked"; value: switchDelegateMenu.checked }
            
            onCheckedChanged: {
                switch (labelText) {
                case "Dark mode":
                    applicationWindow.Material.theme = checked ? Material.Dark : Material.Light
                    settings.setValue("style/theme", ~~applicationWindow.Material.theme)
                    break
                }
            }
        }
    } // Component (SwitchDelegate)
    
    Component {
        id: componentSeparator
        
        Item {
            height: 21
            
            Rectangle {
                x: (parent.width - width)/2
                y: (parent.height - height)/2
                width: parent.width
                height: 1

                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop {
                        position: 0.00;
                        color: "transparent"
                    }
                    GradientStop {
                        position: 0.25;
                        color: applicationWindow.Material.theme === Material.Light ? "#A0A0A0" : "#808080"
                    }
                    GradientStop {
                        position: 0.75;
                        color: applicationWindow.Material.theme === Material.Light ? "#A0A0A0" : "#808080"
                    }
                    GradientStop {
                        position: 1.00;
                        color: "transparent"
                    }
                } // Gradient
            } // Rectangle
        } // Item
    } // Component (Item: separator)
    
    ListView {
        id: listViewMenu

        width: parent.width - applicationMenu.rightInset
        height: parent.height

        currentIndex: 0
        model: listModelMenu
        delegate: Loader {
            id: delegateLoader

            property string labelText: mainText
            property bool isChecked: itemChecked
            property int idx: index

            width: listViewMenu.width
            sourceComponent: applicationMenu.delegateComponentMap[type]
        }

        ScrollIndicator.vertical: ScrollIndicator {
            x: parent.width - width
            height: parent.height
        }
    }
}
