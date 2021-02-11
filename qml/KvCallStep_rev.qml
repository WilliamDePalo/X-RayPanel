import QtQuick 2.0
import QtQuick.Controls 2.0
Item {
    id: calPointArea

    width: 140
    height: 90

    property alias kV: val_kV.text
    property alias c_N:  caseNumber.text
    property alias selected:pointer.on     
    property string kvstr : "" 
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
        anchors.left: parent.rigth
        anchors.right: parent.right
        anchors.top: caseNumber.bottom
        anchors.bottom: parent.bottom
        direction: 3
        anchors.rightMargin: 9
        anchors.topMargin: 8
        anchors.bottomMargin: 0
        anchors.leftMargin: 5
        activeFocusOnTab: true
        on: false
        flashing: true

    }

    Text {
        id: lab_KV
        height: 36
        text: qsTr("kV")
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: pointer.left
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.leftMargin: 6
        anchors.rightMargin: 15
        anchors.verticalCenterOffset: -22
        minimumPointSize: 15
        minimumPixelSize: 15
        font.family: "Tahoma"
    }

    TextEdit {
        id: val_kV
        width: 50
        height: 36
        text: qsTr("40")
        anchors.left: parent.left
        anchors.top: lab_KV.bottom
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.leftMargin: 9
        anchors.horizontalCenterOffset: 3
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
        anchors.right: parent.right
        anchors.top: parent.top
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.topMargin: 0
        anchors.rightMargin: 5
        style: Text.Normal
        font.weight: Font.Normal
        font.bold: true
        font.family: "Arial"
        fontSizeMode: Text.Fit
    }

}
