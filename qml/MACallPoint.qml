import QtQuick 2.0
import QtQuick.Controls 2.0
Item {
    id: calPointArea

    width: 210
    height: 100
    //focus: calPointArea.pressed
    //propagateComposedEvents: true


    property alias kV: val_kV.text
    property alias mA: val_mA.text
    property alias c_N:  caseNumber.text
    property alias selected:pointer.on   
    property alias maR: val_maR.text


    TurnIndicator{
        id: pointer
        width: 60
        anchors.left: parent.left
        anchors.top: caseNumber.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 0
        anchors.bottomMargin: 8
        direction: 2
        anchors.leftMargin: 8
        activeFocusOnTab: true
        on: false
        flashing: true

    }

    Text {
        id: lab_KV
        width: 25
        text: qsTr("kV")
        anchors.left: pointer.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.leftMargin: 15
        anchors.bottomMargin: 80
        anchors.topMargin: 0
        font.family: "Tahoma"
    }

    TextEdit {
        id: val_kV
        x: 86
        width: 47
        height: 20
        text: qsTr("125")
        anchors.top: lab_KV.bottom
        font.pixelSize: 14
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: lab_KV.horizontalCenter
        anchors.topMargin: 3
        z: 1
        readOnly: true
        mouseSelectionMode: TextInput.SelectCharacters
        Rectangle{
            anchors.fill: parent
            z: -1

        }
    }

    Text {
        id: lab_mA
        x: 100
        width: 25
        height: 20
        text: qsTr("mA")
        anchors.top: val_kV.bottom
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: lab_KV.horizontalCenter
        anchors.topMargin: 4
        font.family: "Tahoma"
    }

    TextEdit {
        id: val_mA
        x: 84
        width: 50
        height: 20
        text: qsTr("400")
        anchors.top: lab_mA.bottom
        font.pixelSize: 14
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: lab_KV.horizontalCenter
        anchors.topMargin: 3
        readOnly: true
        Rectangle{
            anchors.fill: parent
            z: -1

        }
    }

    Text {
        id: lab_Trimmer
        y: 13
        width: 85
        height: 20
        text: qsTr("TRIMMER")
        anchors.verticalCenter: lab_KV.verticalCenter
        anchors.right: parent.right
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.rightMargin: 5
        anchors.verticalCenterOffset: 0
        font.family: "Tahoma"
    }

    Text {
        id: lab_maR
        x: 149
        y: 65
        width: 85
        height: 20
        text: qsTr("mA detected")
        anchors.verticalCenter: lab_mA.verticalCenter
        font.pixelSize: 15
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: lab_Trimmer.horizontalCenter
        font.family: "Tahoma"
    }

    TextEdit {
        id: val_maR
        x: 180
        width: 50
        height: 20
        text: qsTr("000.0")
        anchors.top: lab_maR.bottom
        font.pixelSize: 14
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: lab_Trimmer.horizontalCenter
        anchors.topMargin: 3
        readOnly: true
        Rectangle{
            anchors.fill: parent
            z: -1
        }
        onTextChanged: {
            if (val_maR.text!="000.0")
                trimmerInput.b_color = "black"
        }
    }

    TextInput {
        id: trimmerInput
        x: 188
        y: 39
        width: 60
        height: 25
        text: qsTr("4321")
        anchors.verticalCenter: val_kV.verticalCenter
        font.pixelSize: 17
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: lab_Trimmer.horizontalCenter
        inputMethodHints: Qt.ImhDigitsOnly

        property var b_color: rec.color
        Rectangle{
            id: rec
            border.width: 4
            anchors.fill: parent
            z: -1
            border.color: "grey"
        }
    }

    Text {
        id: caseNumber
        width: 60
        height: 31
        color: "#e20613"
        text: qsTr("0.")
        anchors.left: parent.left
        anchors.top: parent.top
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.leftMargin: 5
        anchors.topMargin: 1
        style: Text.Normal
        font.weight: Font.Normal
        font.bold: true
        font.family: "Arial"
        fontSizeMode: Text.Fit
    }


   /*onPointNChanged:
    {
        if (mACalPanel.selector === toSel)
        {

            forceActiveFocus()
            pointer.on = true
            // qui dovrei impostare i valori da seriale e i valori confermati dovrebbero andare in calibrazione

        }
        else
        {
            pointer.on = false
        }      
    }
    onActiveFocusChanged:
    {
        if (!calPointArea.focus)
            pointer.on = false
    }*/


}
