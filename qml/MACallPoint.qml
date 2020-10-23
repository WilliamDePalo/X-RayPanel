import QtQuick 2.0
import QtQuick.Controls 2.0
MouseArea {
    id: mouseArea
    property var isSel:""
    width: 210
    height: 100
    focus: mouseArea.pressed
    propagateComposedEvents: true

    property alias kV: val_kV.text
    property alias mA: val_mA.text
    property alias c_N:  caseNumber.text
    property alias selected:pointer.on
    property alias toSel:mouseArea.isSel
   // signal clicked
 /*   Timer {
        id: checkFocus
        interval: 200
        running: true
        repeat: true
        onTriggered: {
            if(!mouseArea.focus)
            {
                pointer.on = false
            }
        }
    }*/

    TurnIndicator{
        id: pointer
        width: 60
        height: 60
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        direction: 2
        anchors.leftMargin: 5
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
        anchors.topMargin: 5
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
        anchors.topMargin: 10
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
        anchors.topMargin: 5
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
        anchors.topMargin: 5
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
        x: 5
        y: 8
        width: 60
        height: 31
        color: "#ffffff"
        text: qsTr("0.")
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        style: Text.Normal
        font.weight: Font.Normal
        font.bold: true
        font.family: "Arial"
        fontSizeMode: Text.Fit
    }

    onClicked: {        
        mouseArea.isSel = caseNumber.text
    }
   onIsSelChanged:
    {
        if (mouseArea.isSel === caseNumber.text)
        {
            forceActiveFocus()
            pointer.on = true
            // qui dovrei impostare i valori da seriale e i valori confermati dovrebbero andare in calibrazione
        }
        else
        {
            pointer.on = false
        }
       // parent.calSel = mouseArea.isSel
    }
    onActiveFocusChanged:
    {
        if (!mouseArea.focus)
            pointer.on = false
    }
 /*   onContainsMouseChanged: {

        if (!mouseArea.focus)
            pointer.on = false
    }*/
  //  onToSelChanged:
 //   {
 //       if (!mouseArea.focus)
 //           pointer.on = false
 //   }

}
