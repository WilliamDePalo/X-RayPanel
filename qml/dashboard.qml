/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import Qt.labs.calendar 1.0
import QtQuick 2.7

Window {
    id: root
    visible: true
    width: 1024
    height: 600

    color: "#161616"

    property alias yellowButtonIconSource: yellowButton.iconSource
    //property alias elementAnchorsverticalCenterOffset: element.anchors.verticalCenterOffset
    property alias fuelGaugeY: fuelGauge.y
    title: "X-Ray Manager"

    ValueSource {
        id: valueSource
        fuoco: false

    }

    // Dashboards are typically in a landscape orientation, so we need to ensure
    // our height is never greater than our width.
    Item {
        id: container
        width: 1024
        height: 600
        anchors.left: parent.left
        anchors.right: parent.right
        // Math.min(root.width, root.height)
        Column{
            id: gaugeColumn
            visible: true
            transformOrigin: Item.Center
            rotation: 0
            anchors.fill: parent
            spacing: 0

            Item {
                id: element
                y: 0
                height: 300
                anchors.left: parent.left
                anchors.leftMargin: 834
                anchors.right: parent.right
                anchors.rightMargin: 38
                clip: false
                transformOrigin: Item.Right
                anchors.verticalCenter: parent.verticalCenter

                CircularGauge {
                    id: fuelGauge
                    x: 0
                    value: valueSource.fuoco
                    maximumValue: 1
                    width: parent.width
                    height: parent.height * 0.7
                    stepSize: 1
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    visible: true

                    style: IconGaugeStyle {
                        id: fuelGaugeStyle
                        Text {
                            id: textSec
                            text: qsTr("SEC")
                        }
                        textt: "FOCUS"
                        icon: "qrc:/images/fuel-icon.png"
                        minWarningColor: Qt.rgba(0.5, 0, 0, 1)

                        tickmarkLabel: Text {
                            color: "white"
                            visible: styleData.value === 0 || styleData.value === 1
                            font.pixelSize: fuelGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "SMALL" : (styleData.value === 1 ? "LARGE" : "")
                        }
                    }
                }
                CircularGauge {
                    id: tempGauge
                    maximumValue: 2 //12
                    width: parent.width
                    height: parent.height * 0.7
                    value: valueSource.secondi
                    stepSize: 0//11
                    minimumValue: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    clip: false
                    y: parent.height / 2 + container.height * 0.01

                    style: IconGaugeStyle {                         
                        id: tempGaugeStyle

                        minimumValueAngle: -60
                        maximumValueAngle: 60

                        halfGauge: true
                        tickmarkStepSize: 0.25
                        minorTickmarkInset: 0
                        minorTickmarkCount: 1

                        //                     tickmarkCount: 1
                        textt: "MSEC"
                    //    icon: "qrc:/images/temperature-icon.png"
                    //    minWarningColor: "#b8a521"
                    //    maxWarningColor: "#ef5050"
                        maxWarningColor: Qt.rgba(0.5, 0, 0, 1)

                        tickmarkLabel: Text {
                            color: "white"
                            visible: styleData.value === 0 || styleData.value === 2/*11*/|| styleData.value === 1
                            font.pixelSize: tempGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "min" :(styleData.value === 1 ? "1000" : (styleData.value === 2/*11*/ ? "max" : ""))
                        }
                    }
                }


            }

            CircularGauge {
                id: tachometer
                x: 0
                y: 0
                width: 285
                height: 285
                anchors.horizontalCenterOffset: -150
                anchors.verticalCenterOffset: 145
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter//0.25 - gaugeRow.spacing
                value: valueSource.kv
                maximumValue: 125
                minimumValue: 40
                anchors.verticalCenter: parent.verticalCenter

                style: TachometerStyle {}
            }
            PressAndHoldButton {
                id: kvPlus
                width: 18
                height: 23
                antialiasing: true
                anchors.left: tachometer.right
                anchors.leftMargin: -350
                anchors.verticalCenterOffset: -30
                anchors.verticalCenter: tachometer.verticalCenter
                z: 1.63
                scale: 3.859
                transformOrigin: Item.Top
                sourceSize.height: 24
                fillMode: Image.Stretch
                sourceSize.width: 23
                pressed: false
                source: "../images/plus-sign.png"
                onClicked:
                {
                    if (serialTerminal.getConnectionStatusSlot() !== false)
                    {
                        serialTerminal.writeToSerialPCIMode("KV+")
                    }
                }
            }
            PressAndHoldButton {
                id: kvMinus
                width: 18
                height: 23
                antialiasing: true
                anchors.rightMargin: -350
                anchors.right:  tachometer.left
                anchors.leftMargin: -350
                anchors.verticalCenterOffset: -30
                anchors.verticalCenter: tachometer.verticalCenter
                z: 1.63
                scale: 3.859
                transformOrigin: Item.Top
                sourceSize.height: 24
                fillMode: Image.Stretch
                sourceSize.width: 23
                pressed: false
                source: "../images/minus-sign.png"
                onClicked:{
                    if (serialTerminal.getConnectionStatusSlot() !== false)
                    {
                        serialTerminal.writeToSerialPCIMode("KV-")
                    }
                }
            }

            CircularGauge {
                id: speedometer
                width: 285
                value: valueSource.mA
                anchors.verticalCenter: parent.verticalCenter
                minimumValue: 80
                maximumValue: 160
                // We set the width to the height, because the height will always be
                // the more limited factor. Also, all circular controls letterbox
                // their contents to ensure that they remain circular. However, we
                // don't want to extra space on the left and right of our gauges,
                // because they're laid out horizontally, and that would create
                // large horizontal gaps between gauges on wide screens.
                height: 285
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.horizontalCenterOffset: -150
                anchors.verticalCenterOffset: -145
                opacity: 1
                visible: true
                anchors.horizontalCenter: parent.horizontalCenter
                transformOrigin: Item.Top

                style: DashboardGaugeStyle {}
            }
            anchors.centerIn: parent
            //  spacing: 10

            PressAndHoldButton {
                id: mAPlus
                width: 18
                height: 23
                antialiasing: true
                anchors.left: speedometer.right
                anchors.leftMargin: -350
                anchors.verticalCenterOffset: -30
                anchors.verticalCenter: speedometer.verticalCenter
                z: 1.63
                scale: 3.859
                transformOrigin: Item.Top
                sourceSize.height: 24
                fillMode: Image.Stretch
                sourceSize.width: 23
                pressed: false
                source: "../images/plus-sign.png"
                onClicked:{
                    if (serialTerminal.getConnectionStatusSlot() !== false)
                    {
                        serialTerminal.writeToSerialPCIMode("MA+")
                    }
                }

            }
            PressAndHoldButton {
                id: mAMinus
                width: 18
                height: 23
                antialiasing: true
                anchors.rightMargin: -350
                anchors.right:  speedometer.left
                anchors.leftMargin: -350
                anchors.verticalCenterOffset: -30
                anchors.verticalCenter: speedometer.verticalCenter
                z: 1.63
                scale: 3.859
                transformOrigin: Item.Top
                sourceSize.height: 24
                fillMode: Image.Stretch
                sourceSize.width: 23
                pressed: false
                source: "../images/minus-sign.png"
                onClicked:{
                    if (serialTerminal.getConnectionStatusSlot() !== false)
                    {
                        serialTerminal.writeToSerialPCIMode("MA-")
                    }
                }
            }
            /*           PressAndHoldButton {
                id: speedPlus1
                width: 18
                height: 23
                transformOrigin: Item.Top
                anchors.left: speedometer.right
                anchors.verticalCenterOffset: -30
                anchors.leftMargin: -350
                sourceSize.width: 23
                sourceSize.height: 24
                z: 1.63
                anchors.verticalCenter: speedometer.verticalCenter
                scale: 3.859
                source: "../images/plus-sign.png"
                pressed: false
                fillMode: Image.Stretch
            }
              Row {
            id: gaugeRow
            spacing: container.width * 0.02
            anchors.centerIn: parent

            TurnIndicator {
                id: leftIndicator
                anchors.verticalCenter: parent.verticalCenter
                width: height
                height: container.height * 0.1 - gaugeRow.spacing
                visible: false

                direction: Qt.LeftArrow
                on: valueSource.turnSignal == Qt.LeftArrow
            }




            TurnIndicator {
                id: rightIndicator
                anchors.verticalCenter: parent.verticalCenter
                width: height
                height: container.height * 0.1 - gaugeRow.spacing
                visible: false

                direction: Qt.RightArrow
                on: valueSource.turnSignal == Qt.RightArrow
            }

        }*/


        }

        Image {
            id: lights

            // property alias button: button
            anchors.verticalCenterOffset: -238
            anchors.right: parent.right
            anchors.rightMargin: 100
            anchors.verticalCenter: parent.verticalCenter
            //   property TrafficLightStateMachine stateMachine

            //    source: "background.png"

            Row {
                id:rowLights
                y: -35
                width: 171
                height: 41
                anchors.horizontalCenterOffset: -20
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter

                Image {
                    id: redLight
                    width: 38
                    height: 38
                    opacity: 1
                    source: "../images/red.png"

                }

                /*           Image {
                id: yellowLight
                width: 38
                height: 38
                opacity: 1
                source: "../images/yellow.png"
            }*/
                Button {
                    id: yellowButton
                    x: 0
                    y: 0
                    width: 38
                    height: 38
                    antialiasing: true
                    smooth: false
                    iconSource: ""
                    activeFocusOnPress: false
                    enabled: true
                    layer.wrapMode: ShaderEffectSource.ClampToEdge
                    layer.textureSize.height: 0
                    layer.mipmap: false
                    layer.format: ShaderEffectSource.RGBA
                    anchors.horizontalCenter: parent.horizontalCenter
                    scale: 1
                    layer.enabled: false
                    clip: false
                    visible: true
                    layer.textureSize.width: 0
                    layer.textureMirroring: ShaderEffectSource.NoMirroring
                    layer.samples: 2
                    isDefault: false
                    checkable: false
                    onClicked:  {
                        if (serialSettings.visible)
                            serialSettings.visible = false
                        else
                        {
                            baudRate.currentIndex = 8
                            serialSettings.visible = true
                        }
                    }

                    style:ButtonStyle{

                        background:Rectangle{
                            antialiasing: true
                            color: control.pressed ? "#d1d1d1" : control.hovered ? "#666" : "transparent"
                            border.color: "transparent"
                            radius: height/2
                            border.width: 1
                        }

                        /*       background:Image {
                        id: myRoundButton
                        width: 38
                        height: 38
                        scale: -4.402
                        anchors.fill: parent
                        source: "../images/yellow.png"
                        clip: false
                        sourceSize.height: 0
                        sourceSize.width: 0
                    //    verticalTileMode: BorderImage.Round
                     //   horizontalTileMode: BorderImage.Round

                    }*/



                    }


                    opacity: 1
                    Image {
                        id: btnyellImage
                        x: 0
                        y: 0
                        width: 38
                        height: 38
                        visible: true
                        rotation: 180
                        sourceSize.height: 0
                        sourceSize.width: 0
                        fillMode: Image.Stretch
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        scale: 1
                        anchors.fill: parent
                        source: "../images/yellow.png"
                    }

                }
                Image {
                    id: greenLight
                    x: 0
                    width: 38
                    height: 38
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    visible: true
                    opacity: 0.3
                    source: "../images/green.png"
                }



                //            style:Image{
                //                id: yellowLight
                //                source: "../images/yellow.png"
                //      }
            }


            /*       Button {
            id: button

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 20
        //    source: "pause.png"
        }

        states: [
            State {
                name: "Red"
                when: stateMachine.red

                PropertyChanges {
                    target: redLight
                    opacity: 1
                }
            },
            State {
                name: "RedGoingGreen"
                when: stateMachine.redGoingGreen

                PropertyChanges {
                    target: redLight
                    opacity: 1
                }

                PropertyChanges {
                    target: yellowLight
                    opacity: 1
                }
            },
            State {
                name: "Yellow"
                when: stateMachine.yellow || stateMachine.blinking

                PropertyChanges {
                    target: yellowLight
                    opacity: 1
                }
            },
            State {
                name: "Green"
                when: stateMachine.green

                PropertyChanges {
                    target: greenLight
                    opacity: 1
                }
            }
        ]*/
        }
        Column {
            id: serialSettings
            anchors.top: parent.top
            anchors.topMargin: 76
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 524
            anchors.right: parent.right
            anchors.rightMargin: 115

            visible: false
            ComboBox {

                id: serialPorts
                anchors.right: parent.right
                anchors.rightMargin: -100
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -20
                anchors.top: parent.top
                anchors.topMargin: 0
                transformOrigin: Item.Top
                model: portsNameModel



                Label{
                    color: "#fdfdfd"

                    text: qsTr("Serial port: ")
                    anchors.right: parent.right
                    anchors.rightMargin: 139
                    anchors.left: parent.left
                    anchors.leftMargin: -95
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 3
                    anchors.top: parent.top
                    anchors.topMargin: 4
                }
            }

            Label {
                color: "#fbfbfb"

                text: qsTr("Baud: ")
                anchors.right: parent.right
                anchors.rightMargin: 19
                anchors.left: parent.left
                anchors.leftMargin: -50
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -48
                anchors.top: parent.top
                anchors.topMargin: 35
            }

            ComboBox {

                id: baudRate
                width: 100
                anchors.right: parent.right
                anchors.rightMargin: -100
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -47
                anchors.top: serialPorts.top
                anchors.topMargin: 27
                scale: 1
                transformOrigin: Item.Center
                clip: false
                model: baudsModel

                //  Text: "19200"
            }


            Connections {

                target: serialTerminal
                property real tmp :0
                property string  rcv: ""

                onGetData: {
                    //textlog1.text = "<-APP " + data.ToString;
                   //  textlog1.text = data->element;
                //    while (data[tmp]!==0)
               //         textlog1.text += cStr() data[tmp] ;
                //    textlog1.text = "<-APP " + rcv;
                    errorMessage.visible = false
                    if((data[0] ==="F")&&            // gestione fuoco
                            (data[1]==="O"))
                    {
                        if (data[2]==="0") // fuoco piccolo
                        {
                            valueSource.fuoco = false
                            speedometer.minimumValue = 80
                            speedometer.maximumValue = 160
                        }
                        else
                        {
                            valueSource.fuoco = true
                            speedometer.minimumValue= 80
                            speedometer.maximumValue= 400
                        }
                        errorMessage.visible = false
                    }
                    else if ((data[0] ==="K")&&            // gestione kV
                             (data[1]==="V"))
                    {                            
                        tmp = (data[2]-"0")*100;
                        tmp += (data[3]-"0")*10;
                        tmp += data[4]-"0";
                        valueSource.kv = tmp;
                        errorMessage.visible = false
                    }else if ((data[0] ==="M")&&            // gestione Ma
                              (data[1]==="A"))
                    {
                        tmp =  (data[2]-"0")*1000;
                        tmp += (data[3]-"0")*100;
                        tmp += (data[4]-"0")*10;//0;
                        tmp += (data[5]-"0");//*10;
                        // tmp +=  data[6]-"0";
                        valueSource.mA = tmp;
                        errorMessage.visible = false
                    }else if ((data[0] ==="M")&&            // gestione Ms
                              (data[1]==="S"))
                    {
                        tmp =  (data[2]-"0")*1000;
                        tmp += (data[3]-"0")*100;
                        tmp += (data[4]-"0")*100;
                        tmp += (data[5]-"0")*10;
                        tmp +=  data[6]-"0";
                        valueSource.secondi = tmp/1000; // in secondi
                        errorMessage.visible = false
                    }else if ((data[0] ==="P")&&            // gestione PRONTO
                              (data[1]==="R"))
                    {
                        serialTerminal.writeToSerialPCIMode(data);
                        prState.value = data[2]-"0";
                        if (data[2] === "0")
                            prStatus.text = "IDLE"
                        else if (data[2]=== "1")
                            prStatus.text = "ACTIVE !!"
                        else if(data[2]==="2")
                            prStatus.text = "READY !!!"

                    }else if ((data[0] ==="X")&&            // gestione PRONTO
                              (data[1]==="R"))
                    {
                        serialTerminal.writeToSerialPCIMode(data);

                        if (data[2] === "0")
                            emissionSts.active = false;
                        else if (data[2]=== "1")
                        {

                            emissionSts.active = true;
                            prState.value =0;
                            prStatus.text = "IDLE"
                        }
                    }
                    else if ((data[0] ==="E")&&            // gestione LATCHING ERROR
                             (data[1]==="L"))
                    {
                        serialTerminal.writeToSerialPCIMode(data);
                        errorMessage.text = qsTr("LATCHING ERROR !!!")
                        errorMessage.visible = true
                    }else if ((data[0] ==="E")&&            // gestione LATCHING ERROR
                              (data[1]==="R"))
                    {
                        serialTerminal.writeToSerialPCIMode(data);
                        if (data[3] === "0")
                        {
                            if (data[4] === "1")
                            {
                                errorMessage.text = qsTr("INVALID COMMAND !!!")
                            }else if (data[4] === "2")
                            {
                                errorMessage.text = qsTr("COMMAND NOT ALLOWED!!!")
                            }else if (data[4] === "3")
                            {
                                errorMessage.text = qsTr("GENERATOR KV LIMIT EXCEDEED !!!")
                            }else if (data[4] === "4")
                            {
                                errorMessage.text = qsTr("GENERATOR MA LIMIT EXCEDEED !!!")
                            }else if (data[4] === "5")
                            {
                                errorMessage.text = qsTr("GENERATOR MS LIMIT EXCEDEED !!!")
                            }else if (data[4] === "6")
                            {
                                errorMessage.text = qsTr("GENERATOR MAS LIMIT EXCEDEED !!!")
                            }else
                            {
                                errorMessage.text = qsTr("GENERIC ERROR !!!")
                            }
                        }else
                        {
                            errorMessage.text = qsTr("GENERIC ERROR !!!")
                        }
                        errorMessage.visible = true
                    }
                    else
                    {
                        if (data === "ERROR")
                        {// errore connessione
                            errorMessage.text = qsTr("Connection ERROR !!!")
                            errorMessage.visible = true
                        }
                        // poi ci sono i parametri non gestiti tipo ET 0/1
                    }

                }
            }
            Button {

                id: connectBtn
                width: 100
                text: qsTr("Connect")
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -79
                anchors.top: baudRate.bottom
                anchors.topMargin: 9
                onClicked: {

                    if (serialTerminal.getConnectionStatusSlot() === false){
                        serialTerminal.openSerialPortSlot(serialPorts.currentText,baudRate.currentText)

                        if (serialTerminal.getConnectionStatusSlot() !== false)
                        {
                            connectBtn.text = "Disconnect"
                            serialSettings.visible = false
                            greenLight.opacity = 1
                            redLight.opacity = 0.3
                            yellowButton.opacity = 0.3
                            serialTerminal.writeToSerialPCIMode("ET1")
                            serialTerminal.writeToSerialPCIMode("FO1")
                            serialTerminal.writeToSerialPCIMode("KV050")
                            serialTerminal.writeToSerialPCIMode("MA01600")
                            serialTerminal.writeToSerialPCIMode("MS00500")
                        }
                    }else {

                        serialTerminal.closeSerialPortSlot();
                        connectBtn.text = "Connect"
                        greenLight.opacity = 0.3
                        redLight.opacity = 1
                        yellowButton.opacity = 1
                        serialSettings.visible = false
                    }
                }
            }

        }
        //    Timer {
        //          interval: 50; running: true; repeat: true
        //           onTriggered:
        //           {
        //               if (serialTerminal.getConnectionStatusSlot() === true)
        //               serialTerminal.readFromSerialPort();
        //     time.text = Date().toString()
        //           }
        //       }

        Column {
            id: prContainer
            x: 570
            width: 200
            height: 71
            anchors.right: parent.right
            anchors.rightMargin: 254
            anchors.top: parent.top
            anchors.topMargin: 17

            ProgressBar {
                id: prState
                anchors.verticalCenter: parent.verticalCenter
                value: 0
                indeterminate: false
                maximumValue: 2
            }

            Text {
                id: prTitle
                width: 111
                height: 24
                color: "#fbfbfb"
                text: qsTr("Generator State :")
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 12
            }

            Text {
                id: prStatus
                width: 111
                height: 24
                color: "#fbfbfb"
                text: qsTr("INACTIVE")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                font.pixelSize: 12
            }
        }

        StatusIndicator {
            id: emissionSts
            width: 59
            color: "#ff0000"
            z: 19.022
            anchors.left: parent.left
            anchors.leftMargin: 711
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 389
            anchors.top: parent.top
            anchors.topMargin: 163
            antialiasing: true
            enabled: false
            active: false
        }

        Text {
            id: errorMessage
            x: 471
            y: 1
            width: 380
            height: 60
            color: "#ef5050"
            text: qsTr("Error Example !!")
            visible: false
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 48
            enabled: false
            lineHeight: 1.2
            fontSizeMode: Text.Fit
            textFormat: Text.AutoText
            style: Text.Normal
            font.weight: Font.Light
            verticalAlignment: Text.AlignVCenter
            font.family: "Arial"
            anchors.right: parent.right
            anchors.rightMargin: 52
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 33
        }

        Text {
            id: textlog1
            x: 652
            y: 276
            width: 176
            height: 191
            color: "#fbfbfb"
            text: qsTr("")
            clip: true
            styleColor: "#b8a521"
            font.pixelSize: 12
        }

        //  Text { id: time }
    }
}

/*##^##
Designer {
    D{i:4;anchors_width:150;anchors_x:700}D{i:14;anchors_y:0}D{i:16;anchors_y:0}D{i:3;anchors_height:600;anchors_width:1000;anchors_x:0;anchors_y:0}
D{i:30;anchors_width:100;anchors_x:"-95";anchors_y:0}D{i:29;anchors_width:100;anchors_y:0}
D{i:31;anchors_x:"-95";anchors_y:4}D{i:32;anchors_x:"-50";anchors_y:35}D{i:33;anchors_y:0}
D{i:34;anchors_width:100;anchors_y:0}D{i:35;anchors_width:100;anchors_y:40}D{i:39;anchors_height:50;anchors_width:50;anchors_x:757;anchors_y:312}
D{i:40;anchors_width:100;anchors_y:0}D{i:2;anchors_height:600;anchors_width:1024}
}
##^##*/
