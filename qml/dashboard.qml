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
//import WdpClass 1.0

Window {
    id: root
    visible: true
    width: 1024
    height: 600

    color: "#161616"

    property alias yellowButtonIconSource: yellowButton.iconSource
    //property alias elementAnchorsverticalCenterOffset: element.anchors.verticalCenterOffset
    property alias fuelGaugeY: focusGauge.y
    title: "X-Ray Manager"

    ValueSource {
        id: valueSource

        fuoco: false

    }

    Timer{
        id: pollingTimer
        running: false
        repeat: false

        property var callback

        onTriggered: callback()

    }

    function setTimeout(callback, delay)
    {
        if (pollingTimer.running) {
            //      console.error("nested calls to setTimeout are not supported!");
            return;
        }
        pollingTimer.callback = callback;
        // note: an interval of 0 is directly triggered, so add a little padding
        pollingTimer.interval = delay + 1;
        pollingTimer.running = true;
    }
    function sendMinMaFp()
    {
        serialTerminal.putPC1cmd("MA00800",1)
    }
    function sendMaxMaFp(){
        serialTerminal.putPC1cmd("MA01600",1)
    }
    function sendStatusRqst(){
        serialTerminal.putPC1cmd("ST",1)

    }

    // Dashboards are typically in a landscape orientation, so we need to ensure
    // our height is never greater than our width.
    Item {
        id: container
        y: 6
        width: 1024
        height: 600
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.left: parent.left
        anchors.right: parent.right
        // Math.min(root.width, root.height)

        Column{
            id: gaugeColumn
            anchors.leftMargin: -200
            visible: true
            transformOrigin: Item.Center
            rotation: 0
            anchors.fill: parent
            spacing: 0
            Item {
                id: rigthColumn
                x: 700
                y: 0
                width: 150
                height: 400
                anchors.verticalCenterOffset: 90
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: -574
                clip: false
                transformOrigin: Item.Right
                anchors.verticalCenter: parent.verticalCenter
                Button {
                    id:focusBtn
                    width: parent.width
                    height: 95
                    anchors.top: parent.top
                    anchors.topMargin: 46
                    anchors.right: parent.right
                    checkable: false
                    anchors.rightMargin: 0
                    style:ButtonStyle{

                        background:Rectangle{
                            antialiasing: true
                            color: control.pressed ? "#d1d1d1" : control.hovered ? "#666" : "transparent"
                            border.color: "transparent"
                            radius: height/2
                            border.width: 1
                        }
                    }
                    onClicked:{
                        if (serialTerminal.getConnectionStatusSlot() !== false)
                        {

                            if (valueSource.fuoco) // Se fuoco grande
                            {

                                serialTerminal.putPC1cmd("FO0",1)
                                // se tecnica a 3 punti imposto il valore iniziale di MA Fuoco piccolo
                                if (valueSource.tecn)
                                    serialTerminal.putPC1cmd("MA00800",1)
                            }else // se piccolo
                            {
                                serialTerminal.putPC1cmd("FO1",1)
                                // se tecnica a 3 punti imposto il valore iniziale di MA Fuoco grande
                                if (valueSource.tecn)
                                    serialTerminal.putPC1cmd("MA01600",1)


                            }
                        }
                    }
                    CircularGauge {
                        id: focusGauge
                        x: 0
                        value: valueSource.fuoco
                        maximumValue: 1
                        width: parent.width
                        height: 210
                        anchors.top: parent.top
                        anchors.topMargin: -36
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        stepSize: 1
                        visible: true

                        style: IconGaugeStyle {
                            id: fuelGaugeStyle
                            Text {
                                id: textSec
                                text: qsTr("SEC")
                            }
                            textt: "FOCUS"
                           // icon: "qrc:/images/fuel-icon.png" Icona fuoco
                            minWarningColor: Qt.rgba(0.5, 0, 0, 1)

                            tickmarkLabel: Text {
                                color: "white"
                                visible: styleData.value === 0 || styleData.value === 1
                                font.pixelSize: fuelGaugeStyle.toPixels(0.225)
                                text: styleData.value === 0 ? "SMALL" : (styleData.value === 1 ? "LARGE" : "")
                            }

                        }

                        Text {
                            id: statusTitle
                            y: 168
                            height: 34
                            color: "#fdfdfd"
                            text: qsTr("STATUS")
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            textFormat: Text.AutoText
                            fontSizeMode: Text.HorizontalFit
                            font.letterSpacing: 0.6
                            font.wordSpacing: 1
                            style: Text.Sunken
                            font.weight: Font.Bold
                            styleColor: "#16161616"
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            font.pixelSize: 18
                        }

                        Text {
                            id: status
                            x: 5
                            height: 34
                            color: "#fdfdfd"
                            text: qsTr("DISCONNECT")
                            anchors.top: parent.top
                            anchors.topMargin: 200
                            anchors.rightMargin: 0
                            font.pixelSize: 18
                            anchors.left: parent.left
                            fontSizeMode: Text.HorizontalFit
                            font.weight: Font.Bold
                            anchors.leftMargin: 0
                            verticalAlignment: Text.AlignVCenter
                            anchors.right: parent.right
                            horizontalAlignment: Text.AlignHCenter
                            font.wordSpacing: 1
                            styleColor: "#16161616"
                            style: Text.Sunken
                            textFormat: Text.AutoText
                            font.letterSpacing: 0.6

                        }
                    }
                }

                /*            Row {
                    id: tecniqueRow
                    y: 282
                    height: 118
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    visible: true
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    spacing: container.width * 0.02

                    TurnIndicator {
                        id: leftIndicator
                        width: 70
                        height: 70
                        flashing: true
                        on: true
                        anchors.verticalCenter: parent.verticalCenter
                        visible: false

                        direction: Qt.LeftArrow
                    }




                    TurnIndicator {
                        id: rightIndicator
                        width: 70
                        height: 70
                        flashing: true
                        on: true
                        anchors.verticalCenter: parent.verticalCenter
                        visible: true

                        direction: Qt.RightArrow
                    }

          }*/
                Switch{
                    id: swTecnique
                    x: 0
                    y: 335
                    width: 150
                    height: 22
                    checked: true
                    activeFocusOnPress: false
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 35

                    style: SwitchStyle{
                        groove: Rectangle {
                            id: guida
                            height: 20
                            color: "#62626a"
                            //     width: 80
                            //     height: 22
                            implicitWidth: 130
                            implicitHeight: 20
                            radius: 1
                            border.color: "#161616"
                            visible: true
                            //    border.color: "#62626a"
                            scale: 1
                            border.width: 9

                        }
                    }
                    onCheckedChanged: {
                        if (checked==true)// 3 punti
                        {// invio il comando
                            if (serialTerminal.getConnectionStatusSlot() !== false)
                            {
                                serialTerminal.putPC1cmd("ET1",1)
                            }
                        }else // invio il comando 2 punti
                        {
                            if (serialTerminal.getConnectionStatusSlot() !== false)
                            {
                                serialTerminal.putPC1cmd("ET0",1)
                            }
                        }
                    }
                }
                Text {
                    id: tecLabel2
                    x: 8
                    y: 371
                    height: 18
                    color: "#fdfdfd"
                    anchors.right: swTecnique.right

                    text: qsTr("2 point")
                    anchors.rightMargin: 96
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 11
                    font.pointSize: 11
                    fontSizeMode: Text.FixedSize
                    verticalAlignment: Text.AlignBottom
                    horizontalAlignment: Text.AlignHCenter

                }

                Text {
                    id: tecLabel3
                    x: 76
                    y: 371
                    height: 18
                    color: "#fdfdfd"
                    text: qsTr("3 point")
                    verticalAlignment: Text.AlignBottom
                    anchors.right: swTecnique.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 28
                    font.pointSize: 11
                    horizontalAlignment: Text.AlignHCenter
                    fontSizeMode: Text.FixedSize
                    anchors.bottomMargin: 11
                }
            }

            CircularGauge {
                id: tachometer
                x: 319
                y: 0
                width: 285
                height: 285
                anchors.verticalCenterOffset: -145
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: -150
                anchors.horizontalCenter: parent.horizontalCenter//0.25 - gaugeRow.spacing
                value: valueSource.kv
                maximumValue: 125
                minimumValue: 40

                style: TachometerStyle {}
            }
            PressAndHoldButton {
                id: kvPlus
                width: 20
                height: 20
                smooth: false
                anchors.left: tachometer.left
                anchors.leftMargin: 332
                antialiasing: true
                anchors.verticalCenterOffset: -32
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
                        serialTerminal.putPC1cmd("KV+",1)
                    }
                }
            }
            PressAndHoldButton {
                id: kvMinus
                x: 254
                width: 20
                height: 20
                anchors.right: tachometer.left
                anchors.rightMargin: 42
                antialiasing: true
                anchors.verticalCenterOffset: -32
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
                        serialTerminal.putPC1cmd("KV-",1)
                    }
                }
            }
            anchors.centerIn: parent
            //  spacing: 10

            Item {
                id: threePointPanel
                x: 9
                width: 783
                height: 285
                visible: false
                anchors.verticalCenterOffset: 145
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: -100
                anchors.horizontalCenter: parent.horizontalCenter

                PressAndHoldButton {
                    id: mAMinus
                    x: 42
                    y: 103
                    width: 20
                    height: 20
                    anchors.horizontalCenterOffset: -52
                    anchors.left: speedometer.right
                    antialiasing: true
                    anchors.leftMargin: -345
                    anchors.verticalCenterOffset: -29
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
                            serialTerminal.putPC1cmd("MA-",1)
                        }
                    }
                }

                PressAndHoldButton {
                    id: mAPlus
                    x: 439
                    y: 113
                    width: 20
                    height: 20
                    anchors.horizontalCenterOffset: -52
                    anchors.left: speedometer.left
                    anchors.leftMargin: 331
                    antialiasing: true
                    anchors.verticalCenterOffset: -29
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
                            serialTerminal.putPC1cmd("MA+",1)
                        }
                    }

                }

                CircularGauge {
                    id: speedometer
                    x: 107
                    y: 0
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
                    anchors.horizontalCenterOffset: -52
                    stepSize: 1

                    anchors.verticalCenterOffset: 0
                    opacity: 1
                    visible: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    transformOrigin: Item.Top

                    style: DashboardGaugeStyle {
                        labelStepSize:20
                    }
                    //   DashboardGaugeStyle.
                }

                CircularGauge {
                    id: tempGauge
                    x: 633
                    y: 104
                    width: 150
                    height: 210
                    anchors.bottomMargin: -29
                    anchors.bottom: parent.bottom
                    maximumValue: 2 //12
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    value: valueSource.msec/1000
                    stepSize: 0//11
                    minimumValue: 0
                    clip: false

                    style: IconGaugeStyle {
                        id: tempGaugeStyle

                        minimumValueAngle: -60
                        maximumValueAngle: 60

                        halfGauge: true
                        tickmarkStepSize: 0.25
                        minorTickmarkInset: 0
                        minorTickmarkCount: 1

                        //                     tickmarkCount: 1
                        textt: valueSource.msec
                        //    icon: "qrc:/images/temperature-icon.png"
                        //    minWarningColor: "#b8a521"
                        //    maxWarningColor: "#ef5050"
                        maxWarningColor: Qt.rgba(0.5, 0, 0, 1)

                        tickmarkLabel: Text {
                            color: "white"
                            visible: styleData.value === 0 || styleData.value === 2/*11*/|| styleData.value === 1
                            font.pixelSize: tempGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "min" :(styleData.value === 1 ? "MSEC" : (styleData.value === 2/*11*/ ? "max" : ""))
                        }
                    }

                    PressAndHoldButton {
                        id: msecMinus
                        y: 111
                        width: 8
                        height: 8
                        anchors.left: parent.left
                        anchors.right: tachometer.left
                        transformOrigin: Item.Top
                        anchors.verticalCenterOffset: -30
                        sourceSize.width: 23
                        anchors.rightMargin: -350
                        sourceSize.height: 24
                        z: 1.63
                        scale: 3.859
                        fillMode: Image.Stretch
                        pressed: false
                        source: "../images/minus-sign.png"
                        anchors.verticalCenter: tachometer.verticalCenter
                        anchors.leftMargin: 16
                        antialiasing: true
                        onClicked:
                        {
                            if (serialTerminal.getConnectionStatusSlot() !== false)
                            {
                                serialTerminal.putPC1cmd("MS-",1)
                            }
                        }
                    }

                    PressAndHoldButton {
                        id: msecPlus
                        x: 131
                        y: 111
                        width: 8
                        height: 8
                        anchors.right: parent.right
                        anchors.rightMargin: 16
                        anchors.verticalCenterOffset: -30
                        source: "../images/plus-sign.png"
                        anchors.leftMargin: -350
                        antialiasing: true
                        anchors.verticalCenter: tachometer.verticalCenter
                        scale: 3.859
                        transformOrigin: Item.Top
                        z: 1.63
                        fillMode: Image.Stretch
                        anchors.left: tachometer.right
                        sourceSize.width: 23
                        sourceSize.height: 24
                        pressed: false
                        onClicked:
                        {
                            if (serialTerminal.getConnectionStatusSlot() !== false)
                            {
                                serialTerminal.putPC1cmd("MS+",1)
                            }
                        }
                    }
                }


            }



            Item {
                id: twoPointPanel
                x: 9
                width: 783
                height: 285
                visible: true
                anchors.verticalCenterOffset: 145
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: -100
                anchors.horizontalCenter: parent.horizontalCenter
                MasGauge{
                    id:masGa
                    property bool accelerating
                    width: 285
                    anchors.left: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    anchors.leftMargin: 0
                    minimumValue: 0.6
                    value: valueSource.mas
                    maximumValue: 250

                    // Component.onCompleted: forceActiveFocus()

                    //   Behavior on value { NumberAnimation { duration: 1000 }}

                    //     Keys.onSpacePressed: accelerating = true
                    //     Keys.onReleased: {
                    //         if (event.key === Qt.Key_Space) {
                    //             accelerating = false;
                    //            event.accepted = true;
                    //        }
                    //    }
                }

                PressAndHoldButton {
                    id: masMinus
                    x: 272
                    y: 94
                    width: 20
                    height: 20
                    scale: 3.859
                    sourceSize.height: 24
                    anchors.right: masGa.left
                    anchors.rightMargin: 42
                    z: 1.63
                    transformOrigin: Item.Top
                    source: "../images/minus-sign.png"
                    antialiasing: true
                    sourceSize.width: 23
                    anchors.verticalCenter: masGa.verticalCenter
                    anchors.verticalCenterOffset: -32
                    pressed: false
                    fillMode: Image.Stretch
                    onClicked:
                    {
                        if (serialTerminal.getConnectionStatusSlot() !== false)
                        {
                            serialTerminal.putPC1cmd("MX-",1)
                        }
                    }
                }

                PressAndHoldButton {
                    id: masPlus
                    x: 734
                    y: 94
                    width: 20
                    height: 20
                    anchors.leftMargin: 332
                    scale: 3.859
                    sourceSize.height: 24
                    z: 1.63
                    transformOrigin: Item.Top
                    source: "../images/plus-sign.png"
                    antialiasing: true
                    sourceSize.width: 23
                    anchors.verticalCenter: masGa.verticalCenter
                    anchors.verticalCenterOffset: -32
                    pressed: false
                    fillMode: Image.Stretch
                    anchors.left: masGa.left
                    onClicked:
                    {
                        if (serialTerminal.getConnectionStatusSlot() !== false)
                        {
                            serialTerminal.putPC1cmd("MX+",1)
                        }
                    }
                }
            }
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

            //StringParsing{ id: strPars }
            Connections {

                target: serialTerminal
                property real tmp :5000
                property  real tmp1: 1000
                property  real tmp2:0
                property string  rcv: ""

                onGetData: {
                    //                var dt;
                    //                dt =  strPars.process(data)
                    //                dt =  data;


                    //textlog1.text = "<-APP " + data.ToString;
                    //  textlog1.text = data->element;
                    //    while (data[tmp]!==0)
                    //         textlog1.text += cStr() data[tmp] ;
                    //    textlog1.text = "<-APP " + rcv;

                    if ((data[0] ==="S")&&            // gestione fuoco
                         (data[1]==="T"))
                    {
                        if ((data[2]==="0") &&
                                (data[3]==="0"))
                        {
                            if (data[4]==="1")
                            {
                                status.text=qsTr("INITIALIZATION")

                            }else if (data[4]==="2")
                            {
                                status.text=qsTr("STANDBY")

                            }else if (data[4]==="3")
                            {
                                status.text=qsTr("RAD PREPARATION")

                            }else if (data[4]==="4")
                            {
                                status.text=qsTr("RAD EXPOSURE")

                            }else if (data[4]==="5")
                            {
                                status.text=qsTr("ERROR")

                            }else
                            {
                                status.text=qstr("UNKNOW")
                            }
                        }
                    }else // se non e' un polling
                    {
                        errorMessage.visible = false
                        if((data[0] ==="F")&&            // gestione fuoco
                                (data[1]==="O"))
                        {
                            if (data[2]==="0") // fuoco piccolo
                            {
                                valueSource.fuoco = false
                                speedometer.minimumValue = 80
                                speedometer.maximumValue = 160
                                speedometer.DashboardGaugeStyle.labelStepSize = 20
                            }
                            else
                            {
                                valueSource.fuoco = true
                                speedometer.minimumValue= 160
                                speedometer.maximumValue= 400
                                speedometer.DashboardGaugeStyle.labelStepSize = 50
                            }
                            errorMessage.visible = false
                        }else if((data[0] ==="E")&&            // gestione fuoco
                                 (data[1]==="T"))
                        {
                            if (data[2]==="0") // Tecnica 2 punti
                            {
                                valueSource.tecn = 0
                                swTecnique.checked = false
                                threePointPanel.visible = false
                                twoPointPanel.visible = true
                                // se e' la prima volta
                                if((valueSource.mA!== 0)||(valueSource.msec !== 0))
                                {
                                    var calcMas = valueSource.mA * (valueSource.msec/1000)
                                    var strMas =  masStrFormat(calcMas)
                                    // calcolo quanti zeri devo aggiungere all'inizio
                                    // i mas vengono scritti in 5 cifre di cui l'ultima è il
                                    // decimale quindi 4 + 1
                                   var maxlen// numero zeri massimi meno numero cifre
                                    var maxLenNum
                                    if (calcMas<10) {maxlen = 5 - 1
                                                    maxLenNum = 1}
                                    else if (calcMas<100){maxlen = 5 - 2
                                        maxLenNum = 2}
                                    else if (calcMas<1000){maxlen = 5 - 3
                                        maxLenNum = 3}
                                    else if (calcMas<10000){maxlen = 5 - 4
                                        maxLenNum = 4}
                                    else if (calcMas<100000){maxlen = 5 - 5
                                        maxLenNum = 5}

                                     var strcMas = calcMas.toString() // converto in stringa
                                    // solo se e' presente la virgola
                                    if ((strcMas[maxLenNum]===".") || (strcMas[maxLenNum]===","))
                                    {
                                        // calcolo la virgola e la sposto
                                        for (var i =0; i<= maxLenNum;i++)
                                        {
                                            if ((strcMas[i]===".") || (strcMas[i]===","))
                                            {
                                                // i e' la posizione della virgola
                                                var tmp = strcMas[i+1]
                                                // tolgo la virgola
                                                strcMas.at(i) = tmp
                                                //fermo la stringa ad un decimale
                                                strcMas[i+1] = ""
                                            }
                                        }
                                    }
                                    var str0Mas = ""        // definisco la stringa che conterrà gli zeri


                                    for (var cf = 0;cf<maxlen;cf ++)
                                        str0Mas += '0'
                                    str0Mas += strcMas
                                    var mas2Send = "MX" + str0Mas
                                    serialTerminal.putPC1cmd(mas2Send,1)
                                }else if(valueSource.mas===0)
                                    serialTerminal.putPC1cmd("MX00006",1)


                            }
                            else // // Tecnica 3 punti
                            {
                                valueSource.tecn = 1
                                swTecnique.checked = true
                                threePointPanel.visible = true
                                twoPointPanel.visible = false
                                if (valueSource.fuoco) // se Fuoco Grande
                                {
                                    serialTerminal.putPC1cmd("MA01600",1)
                                }
                                else //fuoco piccolo
                                {
                                    serialTerminal.putPC1cmd("MA00800",1)
                                }
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
                            /*     tmp =  (data[2]-"0")*10000;
                        tmp += (data[3]-"0")*1000;
                        tmp += (data[4]-"0")*100;
                        tmp += (data[5]-"0")*10;
                        tmp +=  data[6]-"0";*/
                            tmp1 = (data[2]-"0");
                            tmp2 = tmp1*10000
                            tmp =  tmp2;
                            tmp1= (data[3]-"0");
                            tmp2= tmp1*1000;
                            tmp+=tmp2;
                            tmp1 = (data[4]-"0");
                            tmp2= tmp1*100;
                            tmp+=tmp2;
                            tmp1 = (data[5]-"0");
                            tmp2= tmp1*10;
                            tmp+=tmp2;
                            tmp1 = data[6]-"0";
                            tmp2 = tmp;
                            tmp = tmp1+tmp2;
                            valueSource.msec = tmp; // in secondi /1000
                            errorMessage.visible = false
                        }else if ((data[0] ==="M")&&            // gestione MAs
                                  (data[1]==="X"))
                        {
                            // dato che nel comando di init MAS e' lultimo ad arrivare, se parte vuoto e tutti sono vuoti
                            // Discriminare in base alla tecnica
                            // allora devo dargli i primi parametri
                            if((valueSource.kv && valueSource.mA && valueSource.msec/* || valueSource.mas*/ ) === 0)
                            {// invio i default
                                serialTerminal.putPC1cmd("ET1",0)
                                serialTerminal.putPC1cmd("FO0",0)
                                serialTerminal.putPC1cmd("KV050",0)
                                serialTerminal.putPC1cmd("MA01600",0)
                                serialTerminal.putPC1cmd("MS01500",1)
                                errorMessage.text = qsTr("DEFAULT PARAM !!!")
                                errorMessage.visible = true
                            }
                            tmp =  (data[2]-"0")*1000;
                            tmp += (data[3]-"0")*100;
                            tmp += (data[4]-"0")*10;//0;
                            tmp += (data[5]-"0");//*10;
                            // tmp +=  data[6]-"0";
                            valueSource.mas = tmp;
                            errorMessage.visible = false
                        }
                        else if ((data[0] ==="P")&&            // gestione PRONTO
                                 (data[1]==="R"))
                        {

                            prState.value = data[2]-"0";
                            if (data[2] === "0")
                                prStatus.text = "IDLE"
                            else if (data[2]=== "1")
                            {
                                serialTerminal.putPC1cmd(data,1);
                                prStatus.text = "ACTIVE !!"
                            }
                            else if(data[2]==="2")
                            {
                                serialTerminal.putPC1cmd(data,1);
                                prStatus.text = "READY !!!"
                            }
                        }else if ((data[0] ==="X")&&            // gestione PRONTO
                                  (data[1]==="R"))
                        {

                            if (data[2] === "0")
                                emissionSts.active = false;
                            else if (data[2]=== "1")
                            {
                                serialTerminal.putPC1cmd(data,1);
                                emissionSts.active = true;
                                prState.value =0;
                                prStatus.text = "IDLE"
                            }
                        }
                        else if ((data[0] ==="E")&&            // gestione LATCHING ERROR
                                 (data[1]==="L"))
                        {
                            serialTerminal.putPC1cmd(data,0);
                            errorMessage.text = qsTr("LATCHING ERROR !!!")
                            if((data[2] === "0"))
                            {
                                if(data[3]==="0")
                                {
                                    if(data[4]==="1")
                                        errorMessage.text = qsTr("GENERATOR KW LIMIT !!!")
                                    if(data[4]==="2")
                                        errorMessage.text = qsTr("TIMEOUT OPERATOR !!!")
                                    if(data[4]==="3")
                                        errorMessage.text = qsTr("TIMEOUT FPD ")
                                    if(data[4]==="4")
                                        errorMessage.text = qsTr("TIMEOUT ANODE")
                                    if(data[4]==="5")
                                        errorMessage.text = qsTr("FEEDING ALARM")
                                    if(data[4]==="6")
                                        errorMessage.text = qsTr("FILAMENT ALARM")
                                    if(data[4]==="7")
                                        errorMessage.text = qsTr("SYSTEM SAFETY ALARM")
                                    if(data[4]==="8")
                                        errorMessage.text = qsTr("OVERCHARGE ALARM")
                                    if(data[4]==="9")
                                        errorMessage.text = qsTr("OVERCHARGE ALARM")
                                }else if (data[3]==="1")
                                {
                                    if(data[4]==="0")
                                        errorMessage.text = qsTr("NO EMISSION ALARM")
                                    if(data[4]==="1")
                                        errorMessage.text = qsTr("PR1 ACKNOWLEDGEMENT TIMEOUT")
                                    if(data[4]==="2")
                                        errorMessage.text = qsTr("PR2 ACKNOWLEDGEMENT TIMEOUT")
                                    if(data[4]==="3")
                                        errorMessage.text = qsTr("XR1 ACKNOWLEDGEMENT TIMEOUT")
                                }
                            }


                            errorMessage.visible = true
                        }else if ((data[0] ==="E")&&            // gestione LATCHING ERROR
                                  (data[1]==="R"))
                        {
                            //       serialTerminal.putPC1cmd(data);
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
                                }else if (data[4] === "7")
                                {
                                    errorMessage.text = qsTr("TIMEOUT GENERATION !!!")
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
                            //    serialTerminal.putPC1cmd("ET?",1)
                            //   serialTerminal.putPC1cmd("FO?",1)
                            serialTerminal.putPC1cmd("RS",1)
                            serialTerminal.putPC1cmd("RR",1)
                            pollingTimer.repeat = 1
                            setTimeout(sendStatusRqst,1000)
                        }
                    }else {
                        errorMessage.visible = false;
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
            x: 539
            width: 200
            height: 71
            anchors.right: parent.right
            anchors.rightMargin: 286
            anchors.top: parent.top
            anchors.topMargin: 205

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
            color: "#feec63"
            z: 19.022
            anchors.left: parent.left
            anchors.leftMargin: 609
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 442
            anchors.top: parent.top
            anchors.topMargin: 110
            antialiasing: true
            enabled: false
            active: false
        }

        Text {
            id: errorMessage
            x: 406
            y: 16
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
            anchors.rightMargin: 238
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 524
        }

        //  Text { id: time }
    }
}

/*##^##
Designer {
    D{i:2;anchors_height:600;anchors_width:1024}D{i:8;anchors_y:14}D{i:12;anchors_x:254;anchors_y:0}
D{i:13;anchors_x:54}D{i:14;anchors_height:16;anchors_width:14;anchors_x:254;anchors_y:0}
D{i:16;anchors_x:254;anchors_y:0}D{i:15;anchors_height:16;anchors_width:14;anchors_x:254;anchors_y:0}
D{i:19;anchors_height:16;anchors_width:14;anchors_x:649;anchors_y:0}D{i:21;anchors_x:254;anchors_y:0}
D{i:20;anchors_height:16;anchors_width:14;anchors_x:254;anchors_y:0}D{i:22;anchors_x:254;anchors_y:0}
D{i:23;anchors_x:254;anchors_y:0}D{i:25;anchors_x:254;anchors_y:0}D{i:26;anchors_x:254;anchors_y:0}
D{i:28;anchors_x:254;anchors_y:0}D{i:27;anchors_x:254;anchors_y:0}D{i:30;anchors_x:254}
D{i:29;anchors_x:254;anchors_y:0}D{i:24;anchors_x:254;anchors_y:0}D{i:35;anchors_x:254;anchors_y:0}
D{i:36;anchors_width:100;anchors_x:254;anchors_y:0}D{i:37;anchors_width:100;anchors_x:"-95";anchors_y:0}
D{i:4;anchors_width:150;anchors_x:700}D{i:40;anchors_width:100;anchors_x:"-95";anchors_y:4}
D{i:42;anchors_width:100;anchors_x:"-50";anchors_y:0}D{i:43;anchors_width:100;anchors_x:"-50";anchors_y:0}
D{i:44;anchors_width:100;anchors_x:"-50";anchors_y:40}D{i:41;anchors_width:100;anchors_x:"-50";anchors_y:35}
D{i:45;anchors_width:100;anchors_x:"-50";anchors_y:40}D{i:39;anchors_width:100;anchors_x:"-95";anchors_y:0}
D{i:38;anchors_width:100;anchors_x:"-95";anchors_y:0}D{i:48;anchors_height:50;anchors_width:50;anchors_x:757;anchors_y:312}
D{i:47;anchors_height:50;anchors_width:100;anchors_x:"-50";anchors_y:40}D{i:49;anchors_height:50;anchors_width:100;anchors_x:757;anchors_y:0}
D{i:50;anchors_height:50;anchors_width:100;anchors_x:757;anchors_y:0}D{i:51;anchors_height:50;anchors_width:100;anchors_x:757;anchors_y:0}
D{i:52;anchors_height:50;anchors_width:100;anchors_x:757;anchors_y:0}D{i:46;anchors_height:50;anchors_width:100;anchors_x:"-50";anchors_y:40}
D{i:54;anchors_height:50;anchors_width:100;anchors_x:757;anchors_y:0}D{i:55;anchors_height:50;anchors_width:100;anchors_x:757;anchors_y:0}
D{i:56;anchors_height:50;anchors_width:100;anchors_x:757;anchors_y:0}D{i:53;anchors_height:50;anchors_width:100;anchors_x:757;anchors_y:0}
D{i:57;anchors_height:50;anchors_width:100;anchors_x:757;anchors_y:0}D{i:58;anchors_height:50;anchors_width:100;anchors_x:757;anchors_y:0}
D{i:3;anchors_height:600;anchors_width:1000;anchors_x:0;anchors_y:0}
}
##^##*/
