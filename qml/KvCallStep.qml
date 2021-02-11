import QtQuick 2.0
import QtQuick.Controls 2.0
Item {
    id: calPointArea

    width: 140
    height: 90
    //focus: calPointArea.pressed
    //propagateComposedEvents: true


    property alias kV: val_kV.text
    property alias c_N:  caseNumber.text
    property alias selected:pointer.on   

    property string kvstr : ""
    property  string mAstr : ""
    property int idn: 0

    function setkVRead( newText)
    {
    //     val_kVR.text = newText
    }

    function  getkVRead(tex)
  {
//        tex = val_kVR.text
    }


    function kvSelection(val)
    {
        if (val)
            val_kV.selectAll()
        else
            val_kV.deselect()
    }


    function selectionChange(index)
   //onPointNChanged:
    {
        if (calPointArea.idn === index)
        {
            calPointArea.selected = true//(mACalPanel.selector === toSel)
            calPointArea.kvSelection(true)            
            forceActiveFocus()
            pointer.on = true
            // qui dovrei impostare i valori da seriale e i valori confermati dovrebbero andare in calibrazione
            if (val_kV.text.length < 3)
                 kvstr = "KV0" + val_kV.text
            else
                kvstr = "KV" + val_kV.text           
            serialTerminal.putPC1cmd(kvstr,1)//"KV050",0)           
        }
        else
        {
            pointer.on = false
            calPointArea.kvSelection(false)           
        }
    }

    TurnIndicator{
        id: pointer
        y: 30
        width: 60
        height: 40
        anchors.left: parent.left
        anchors.top: caseNumber.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 8
        anchors.bottomMargin: 0
        direction: 2
        anchors.leftMargin: 9
        activeFocusOnTab: true
        on: false
        flashing: true

    }

    Text {
        id: lab_KV
        height: 36
        text: qsTr("kV")
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: pointer.right
        anchors.right: parent.right
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.rightMargin: 6
        anchors.verticalCenterOffset: -22
        minimumPointSize: 15
        minimumPixelSize: 15
        anchors.leftMargin: 15
        font.family: "Tahoma"
    }

    TextEdit {
        id: val_kV
        x: 86
        width: 50
        height: 36
        text: qsTr("40")
        anchors.top: lab_KV.bottom
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenterOffset: 0
        enabled: false
        anchors.horizontalCenter: lab_KV.horizontalCenter
        anchors.topMargin: 5
        z: 1
        readOnly: false
        mouseSelectionMode: TextInput.SelectCharacters
        Rectangle{
            border.width: 2
            anchors.fill: parent
            z: -1

        }
    }

    Text {
        id: caseNumber
        width: 60
        height: 31
        color: "#e20613"
        text: qsTr("0.")
        anchors.verticalCenter: lab_KV.verticalCenter
        anchors.left: parent.left
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.leftMargin: 5
        style: Text.Normal
        font.weight: Font.Normal
        font.bold: true
        font.family: "Arial"
        fontSizeMode: Text.Fit
    }

}
