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
import WdpClass 1.0
import QtGraphicalEffects 1.0

Window {
    id: root
    visible: true
    width: 1024
    height: 600

    color: "#d3eccb"
   // property alias touchSynchroText: touchSynchro.text

    property alias yellowButtonIconSource: yellowButton.iconSource
    //property alias elementAnchorsverticalCenterOffset: element.anchors.verticalCenterOffset
    //  property alias fuelGaugeY: focusGauge.y
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

    Timer{
        id: statusTimer
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


    function setStatusTo(callback, delay)
    {
        if(statusTimer.running){
            // error
            return;
        }
        statusTimer.callback = callback;
        statusTimer.interval = delay + 1;
        statusTimer.running = true;
    }

    function sendMinMaFp()
    {
        if (serialTerminal.getConnectionStatusSlot() !== false)
        {
            serialTerminal.putPC1cmd("MA00800",1)
        }
    }
    function sendMaxMaFp(){
        if (serialTerminal.getConnectionStatusSlot() !== false)
        {
            serialTerminal.putPC1cmd("MA01600",1)
        }
    }
    function sendStatusRqst(){
        if (serialTerminal.getConnectionStatusSlot() !== false)
        {
            //  decommentare serialTerminal.putPC1cmd("ST",1)
            serialTerminal.putPC1cmd("VC?",1)
            serialTerminal.putPC1cmd("PA?",1)
        }
    }
    function sendAlignRqst(){
        if (serialTerminal.getConnectionStatusSlot() !== false)
        {
            serialTerminal.putPC1cmd("ST",1)
            serialTerminal.putPC1cmd("RS",1)
            serialTerminal.putPC1cmd("RR",1)
            serialTerminal.putPC1cmd("PV?",1)
        }
        // si potrebbe aggiungere anche lo stato "ST"
    }

    // Dashboards are typically in a landscape orientation, so we need to ensure
    // our height is never greater than our width.
    Item {
        id: container
        y: 0
        width: 1024
        height: 600
        anchors.rightMargin: -6
        anchors.leftMargin: 6
        anchors.left: parent.left
        anchors.right: parent.right
        // Math.min(root.width, root.height)
        Image{
            id: backGroundImg
            rotation: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: -7
            anchors.topMargin: 0
            fillMode: Image.TileVertically
            source: "../images/sfondo/sfondo1"
            anchors.fill: parent
            //Image:"qrc:image/logoRxR.jpg"
        }

        Column{
            id: gaugeColumn
            anchors.leftMargin: 0
            visible: true
            transformOrigin: Item.Center
            rotation: 0
            anchors.fill: parent
            spacing: 0
            Item {
                id: rigthColumn
                x: 700
                y: 0
                width: 230
                height: 420
                anchors.rightMargin: 4
                anchors.verticalCenterOffset: 85
                anchors.right: parent.right
                clip: false
                transformOrigin: Item.Right
                anchors.verticalCenter: parent.verticalCenter
                Button {
                    id:focusBtn
                    y: 14
                    width: 60
                    height: 60
                    iconSource: ""
                    tooltip: "Small"
                    anchors.left: focusTitle.right
                    anchors.leftMargin: 0
                    anchors.verticalCenter: focusTitle.verticalCenter
                    checkable: false
                    style:ButtonStyle{
                        background:Rectangle{

                            antialiasing: true
                            color: control.pressed ? "#d1d1d1" : control.hovered ? "transparent":"transparent"
                            //"#666" : "transparent"
                            border.color: "transparent"
                            radius: height/2
                            border.width: 1
                        }

                    }
                    Image {
                        id: focusImage
                        x: 0
                        y: 0
                        width: 55
                        height: 55
                        opacity: 1
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: parent.top
                        visible: true
                        rotation: 0
                        sourceSize.height: 0
                        sourceSize.width: 0
                        fillMode: Image.Stretch
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        scale: 1
                        source: "../images/smallFocus.png"
                    }
                    /*                  CircularGauge {
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
                            icon: "qrc:/images/smallFocus_FULL.png"
                            Text {
                                id: textSec
                                text: qsTr("SEC")
                            }
                            textt: "FOCUS"
                            minWarningColor: Qt.rgba(0.5, 0, 0, 1)

                            tickmarkLabel: Text {
                                color: "white"
                                visible: styleData.value === 0 || styleData.value === 1
                                font.pixelSize: fuelGaugeStyle.toPixels(0.225)
                                text: styleData.value === 0 ? "SMALL" : (styleData.value === 1 ? "LARGE" : "")
                            }
                        }

                        Image {
                            id: largeFocusImage
                            x: 64
                            y: 59
                            width: 23
                            height: 24
                            visible: false
                            fillMode: Image.PreserveAspectFit
                            source: "../images/largeFocus_Full.png"
                        }
                    }*/
                    onClicked:{
                        if (serialTerminal.getConnectionStatusSlot() !== false)
                        {

                            if (valueSource.fuoco) // Se fuoco grande
                            {
                                serialTerminal.putPC1cmd("MA01600",1) // serve per evitare l'errore kw max

                                serialTerminal.putPC1cmd("FO0",1)

                                largeFocusImage.visible = false
                                // se tecnica a 3 punti imposto il valore iniziale di MA Fuoco piccolo
                                if (valueSource.tecn)
                                    serialTerminal.putPC1cmd("MA00800",1)
                            }else // se piccolo
                            {
                                serialTerminal.putPC1cmd("FO1",1)
                                largeFocusImage.visible = true

                                // se tecnica a 3 punti imposto il valore iniziale di MA Fuoco grande
                                if (valueSource.tecn)
                                    serialTerminal.putPC1cmd("MA01600",1)
                            }
                        }
                    }

                }

                Text {
                    id: statusTitle
                    height: 35
                    color: "#fdfdfd"
                    text: qsTr("STATUS:")
                    anchors.leftMargin: 0
                    font.family: "Tahoma"
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    textFormat: Text.AutoText
                    fontSizeMode: Text.HorizontalFit
                    font.letterSpacing: 0.6
                    font.wordSpacing: 1
                    style: Text.Sunken
                    font.weight: Font.Normal
                    styleColor: "#16161616"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.rightMargin: 155
                    font.pixelSize: 18
                }

                Text {
                    id: status
                    y: 196
                    height: 34
                    color: "#5eb3e4"
                    text: qsTr("DISCONNECT")
                    anchors.verticalCenter: statusTitle.verticalCenter
                    anchors.left: statusTitle.right
                    anchors.leftMargin: 0
                    font.pixelSize: 18
                    fontSizeMode: Text.HorizontalFit
                    font.weight: Font.Bold
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.wordSpacing: 1
                    styleColor: "#16161616"
                    style: Text.Sunken
                    textFormat: Text.AutoText
                    font.letterSpacing: 0.6

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
                    y: 375
                    width: 203
                    height: 37
                    layer.textureSize.width: 1
                    layer.textureSize.height: 2
                    checked: true
                    activeFocusOnPress: false
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 8

                    style: SwitchStyle{
                        groove: Rectangle {
                            id: guida
                            x: 0
                            width: 200
                            height: 30
                            color: "#424545"
                            //     width: 80
                            //     height: 22
                            implicitWidth: 200
                            implicitHeight: 20
                            radius: 1
                            border.color: "#000000"
                            opacity: 1
                            visible: true
                            //    border.color: "#62626a"
                            scale: 1
                            border.width: 12

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
                    y: 355
                    height: 18
                    color: "#fbfbfb"

                    text: qsTr("2 POINT")
                    font.pixelSize: 18
                    anchors.left: swTecnique.left
                    anchors.leftMargin: 17
                    font.family: "Verdana"
                    anchors.bottom: swTecnique.top
                    anchors.bottomMargin: 2
                    fontSizeMode: Text.FixedSize
                    verticalAlignment: Text.AlignBottom
                    horizontalAlignment: Text.AlignHCenter

                }

                Text {
                    id: tecLabel3
                    x: 111
                    y: 355
                    height: 18
                    color: "#5bb2e5"
                    text: qsTr("3 POINT")
                    font.pixelSize: 18
                    font.family: "Verdana"
                    anchors.verticalCenter: tecLabel2.verticalCenter
                    anchors.right: swTecnique.right
                    anchors.rightMargin: 17
                    verticalAlignment: Text.AlignBottom
                    horizontalAlignment: Text.AlignHCenter
                    fontSizeMode: Text.FixedSize
                }

                Gauge {
                    id: capacitorPerc
                    x: -121
                    width: 63
                    height: 200
                    anchors.top: status.top
                    anchors.topMargin: -1
                    value:  valueSource.cap
                    anchors.right: parent.right
                    anchors.rightMargin: 288
                }

                Text {
                    id: focusTitle
                    height: 35
                    color: "#fdfdfd"
                    text: qsTr("FOCUS:")
                    anchors.leftMargin: 8
                    anchors.left: parent.left
                    font.weight: Font.Normal
                    verticalAlignment: Text.AlignVCenter
                    font.letterSpacing: 0.6
                    fontSizeMode: Text.HorizontalFit
                    styleColor: "#16161616"
                    anchors.rightMargin: 147
                    anchors.right: parent.right
                    anchors.topMargin: 69
                    textFormat: Text.AutoText
                    font.family: "Tahoma"
                    font.wordSpacing: 1
                    style: Text.Sunken
                    anchors.top: parent.verticalCenter
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 18
                }

                Column {
                    id: prContainer
                    x: 4
                    y: 47
                    width: 200
                    height: 71
                    anchors.right: parent.right
                    anchors.rightMargin: 27
                    anchors.top: parent.verticalCenter
                    anchors.topMargin: -160

                    ProgressBar {
                        id: prState
                        width: 200
                        height: 15
                        anchors.top: prTitle.bottom
                        anchors.topMargin: 5
                        value: 0
                        indeterminate: false
                        maximumValue: 2
                        style:ProgressBarStyle{


                            background: Rectangle {
                                width: 800
                                height: 400

                                visible: true
                                color:"#e6e6e6"
                                radius: 3
                            }

                            progress: Rectangle {
                                width: prState.visualPosition * parent.width
                                height: parent.height
                                radius: 2
                                color: "#17a81a"

                                gradient: Gradient {
                                    GradientStop {
                                        position: 0.0
                                        SequentialAnimation on color {
                                            loops: Animation.Infinite
                                            ColorAnimation { from: "green"; to: "lightgreen"; duration: 2000 }
                                            ColorAnimation { from: "lightgreen"; to: "green"; duration: 2000 }
                                        }
                                    }
                                    GradientStop {
                                        position: 1.0
                                        color: "#23ae16"
                                        SequentialAnimation on color {
                                            loops: Animation.Infinite
                                            ColorAnimation { from: "#23ae16"; to: "#437284"; duration: 2000 }
                                            ColorAnimation { from: "#437284"; to: "#23ae16"; duration: 2000 }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Text {
                        id: prTitle
                        width: 111
                        height: 24
                        color: "#5eb3e4"
                        text: qsTr("GENERATOR STATE :")
                        font.family: "Verdana"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.top: parent.top
                        anchors.topMargin: 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 18
                    }

                    Text {
                        id: prStatus
                        width: 111
                        height: 24
                        color: "#5eb3e4"
                        text: qsTr("INACTIVE")
                        font.family: "Verdana"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        font.pixelSize: 18
                    }
                }

                Text {
                    id: readyTitle
                    height: 35
                    color: "#fdfdfd"
                    text: "READY:"
                    horizontalAlignment: Text.AlignLeft
                    anchors.top: prContainer.bottom
                    textFormat: Text.AutoText
                    style: Text.Sunken
                    font.wordSpacing: 1
                    verticalAlignment: Text.AlignVCenter
                    anchors.rightMargin: 147
                    font.letterSpacing: 0.6
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    font.weight: Font.Normal
                    anchors.topMargin: 55
                    font.family: "Tahoma"
                    styleColor: "#16161616"
                    fontSizeMode: Text.HorizontalFit
                    font.pixelSize: 18
                }

            }

            CircularGauge {
                id: tachometer
                y: 0
                width: 285
                height: 285
                anchors.verticalCenterOffset: 50
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.verticalCenter: parent.verticalCenter
                //0.25 - gaugeRow.spacing
                value: valueSource.kv
                maximumValue: 125
                minimumValue: 40

                style: TachometerStyle {}
            }
            PressAndHoldButton {
                id: kvPlus
                width: 20
                height: 20
                anchors.left: tachometer.horizontalCenter
                anchors.leftMargin: 30
                anchors.top: tachometer.bottom
                anchors.topMargin: -3
                smooth: false
                antialiasing: true
                z: 1.63
                scale: 3.859
                transformOrigin: Item.Top
                sourceSize.height: 24
                fillMode: Image.Stretch
                sourceSize.width: 23
                pressed: false
                source: "../images/plus-sign.png"
                property int cntr : 0
                onClicked:{
                    if (serialTerminal.getConnectionStatusSlot() !== false)
                    {
                        if (cntr <= 4)
                            serialTerminal.putPC1cmd("KV+",1)
                        else
                            serialTerminal.putPC1cmd("KV++",1)
                        cntr++
                    }
                }
                onPressedChanged:  {
                    if (!pressed)
                        cntr = 0
                }
            }
            PressAndHoldButton {
                property int cntr : 0
                id: kvMinus
                x: 254
                width: 20
                height: 20
                anchors.top: tachometer.bottom
                anchors.topMargin: -3
                anchors.right: tachometer.horizontalCenter
                anchors.rightMargin: 30
                antialiasing: true
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
                        if (cntr <= 4)
                            serialTerminal.putPC1cmd("KV-",1)
                        else
                            serialTerminal.putPC1cmd("KV--",1)
                        cntr++
                    }
                }
                onPressedChanged:  {
                    if (!pressed)
                        cntr = 0
                }
            }
            anchors.centerIn: parent
            //  spacing: 10

            Item {
                id: threePointPanel
                x: 9
                width: 445
                height: 285
                anchors.right: rigthColumn.left
                anchors.rightMargin: 30
                visible: true
                anchors.verticalCenterOffset: 50
                anchors.verticalCenter: parent.verticalCenter

                PressAndHoldButton {
                    id: mAMinus
                    x: 435
                    width: 20
                    height: 20
                    anchors.right: speedometer.horizontalCenter
                    anchors.rightMargin: 30
                    anchors.top: speedometer.bottom
                    anchors.topMargin: -3
                    anchors.horizontalCenterOffset: -52
                    antialiasing: true
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
                    width: 20
                    height: 20
                    anchors.left: speedometer.horizontalCenter
                    anchors.leftMargin: 30
                    anchors.top: speedometer.bottom
                    anchors.topMargin: -3
                    anchors.horizontalCenterOffset: -52
                    antialiasing: true
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
                    width: 285
                    value: valueSource.mA
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
                    anchors.right: tempGauge.left
                    anchors.rightMargin: 30
                    stepSize: 1

                    opacity: 1
                    visible: true
                    transformOrigin: Item.Top

                    style: DashboardGaugeStyle {
                        labelStepSize:20
                    }
                    //   DashboardGaugeStyle.
                }

                CircularGauge {
                    id: tempGauge
                    x: 325
                    y: 193
                    width: 120
                    height: 166
                    anchors.bottomMargin: -74
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
                        maxWarningColor: "#5bb2e5"

                        minimumValueAngle: -60
                        maximumValueAngle: 60

                        halfGauge: true
                        tickmarkStepSize: 0.25
                        minorTickmarkInset: 0
                        minorTickmarkCount: 1

                        //                     tickmarkCount: 1
                        textt: valueSource.msec
                        // icon: "qrc:/images/smallFocus.png"
                        //    minWarningColor: "#b8a521"
                        //    maxWarningColor: "#ef5050"

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
                        anchors.leftMargin: 8
                        antialiasing: true
                        property int  cntr: 0
                        onClicked:
                        {
                            if (serialTerminal.getConnectionStatusSlot() !== false)
                            {
                                if (cntr <= 4)
                                    serialTerminal.putPC1cmd("MS-",1)
                                else
                                    serialTerminal.putPC1cmd("MS--",1)
                                cntr++
                            }
                        }
                        onPressedChanged:  {
                            if (!pressed)
                                cntr = 0
                        }
                    }

                    PressAndHoldButton {
                        id: msecPlus
                        x: 131
                        y: 111
                        width: 8
                        height: 8
                        anchors.right: parent.right
                        anchors.rightMargin: 8
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
                        property int  cntr: 0
                        onClicked:
                        {
                            if (serialTerminal.getConnectionStatusSlot() !== false)
                            {
                                if (cntr <= 4)
                                    serialTerminal.putPC1cmd("MS+",1)
                                else
                                    serialTerminal.putPC1cmd("MS++",1)
                                cntr++
                            }
                        }
                        onPressedChanged:  {
                            if (!pressed)
                                cntr = 0
                        }
                    }
                }
            }


        }



        Image {
            id: logo
            x: 31
            y: 32
            width: 317
            height: 110
            fillMode: Image.PreserveAspectFit
            source: "../images/whitetramp.png"
        }

        Item {
            id: twoPointPanel
            width: 325
            height: 285
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 13
            anchors.left: parent.left
            anchors.leftMargin: 9
            visible: false
            anchors.verticalCenterOffset: 145
            anchors.verticalCenter: parent.verticalCenter
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
                property int  cntr: 0
                onClicked:
                {
                    if (serialTerminal.getConnectionStatusSlot() !== false)
                    {
                        if (cntr <= 2)
                            serialTerminal.putPC1cmd("MX-",1)
                        else
                            serialTerminal.putPC1cmd("MX--",1)
                        cntr++
                    }
                }
                onPressedChanged:  {
                    if (!pressed)
                        cntr = 0
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
                property int  cntr: 0
                onClicked:
                {
                    if (serialTerminal.getConnectionStatusSlot() !== false)
                    {

                        if (cntr <= 2)
                            serialTerminal.putPC1cmd("MX+",1)
                        else
                            serialTerminal.putPC1cmd("MX++",1)
                        cntr++

                    }
                }
                onPressedChanged:  {
                    if (!pressed)
                        cntr = 0
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
                y: -40
                width: 237
                height: 80
                anchors.horizontalCenterOffset: -45
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter

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
                    width: 55
                    height: 55
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    antialiasing: true
                    smooth: false
                    iconSource: ""
                    activeFocusOnPress: false
                    enabled: true
                    layer.wrapMode: ShaderEffectSource.ClampToEdge
                    layer.textureSize.height: 0
                    layer.mipmap: false
                    layer.format: ShaderEffectSource.RGBA
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
                        {
                            serialSettings.visible = false
                            if (serialTerminal.getConnectionStatusSlot() === false)
                                btnyellImage.source = "../images/red.png"
                            else
                                btnyellImage.source = "../images/green.png"
                        }else
                        {
                            baudRate.currentIndex = 8
                            serialSettings.visible = true
                            if (serialTerminal.getConnectionStatusSlot() === false)
                                btnyellImage.source = "../images/yellow.png"
                            else
                                btnyellImage.source = "../images/green.png"

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
                        width: 55
                        height: 55
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: parent.top
                        visible: true
                        rotation: 0
                        sourceSize.height: 0
                        sourceSize.width: 0
                        fillMode: Image.Stretch
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        scale: 1
                        source: "../images/red.png"
                    }

                }

                StatusIndicator {
                    id: emissionSts
                    width: 65
                    height: 65
                    color: "#feec63"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    z: 19.022
                    antialiasing: true
                    enabled: false
                    active: false
                }

                Button {
                    id: infoButton
                    y: 0
                    width: 55
                    height: 55
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    layer.textureMirroring: ShaderEffectSource.NoMirroring
                    isDefault: false
                    layer.format: ShaderEffectSource.RGBA
                    layer.samples: 2


                    onClicked:  {
                        if (infoPanel.visible)
                        {
                            infoPanel.visible = false
                        }else
                        {
                            infoPanel.visible = true
                        }
                             }
                    style: ButtonStyle {
                        background: Rectangle {
                            color: control.pressed ? "#d1d1d1" : control.hovered ? "#666" : "transparent"
                            radius: height/2
                            border.color: "#00000000"
                            border.width: 1
                            antialiasing: true
                        }
                    }
                    visible: true
                    antialiasing: true
                    opacity: 1
                    layer.mipmap: false
                    layer.textureSize.width: 0
                    enabled: true
                    activeFocusOnPress: false
                    scale: 1
                    layer.textureSize.height: 0
                    anchors.verticalCenter: parent.verticalCenter
                    Image {
                        id: btnInfImage1
                        x: 0
                        y: 0
                        width: 55
                        height: 55
                        anchors.topMargin: 0
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        sourceSize.width: 0
                        visible: true
                        fillMode: Image.Stretch
                        anchors.rightMargin: 0
                        sourceSize.height: 0
                        scale: 1
                        anchors.leftMargin: 0
                        anchors.left: parent.left
                        rotation: 0
                        source: "../images/info64.png"
                        anchors.bottomMargin: 0
                        anchors.top: parent.top
                    }
                    smooth: false
                    layer.enabled: false
                    iconSource: ""
                    layer.wrapMode: ShaderEffectSource.ClampToEdge
                    clip: false
                    checkable: false
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



                ]*/
        }
        Column {
            id: serialSettings
            x: 784
            y: 68
            width: 219
            height: 137
            anchors.top: lights.bottom
            anchors.topMargin: 31
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 418
            anchors.right: parent.right
            anchors.rightMargin: 21

            visible: false
            ComboBox {

                id: serialPorts
                width: 100
                height: 25
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                transformOrigin: Item.Top
                model: portsNameModel



                Label{
                    id: spLab
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
                id: baudLab
                width: 56
                height: 18
                color: "#fbfbfb"

                text: qsTr("Baud: ")
                anchors.right: baudRate.left
                anchors.rightMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 35
            }

            ComboBox {

                id: baudRate
                width: 100
                height: 25
                anchors.right: serialPorts.right
                anchors.rightMargin: 0
                anchors.top: serialPorts.bottom
                anchors.topMargin: 10
                scale: 1
                transformOrigin: Item.Center
                clip: false
                model: baudsModel

                //  Text: "19200"
            }

            StringParsing{ id: strPars }
            Connections {

                target: serialTerminal
                property real tmp :5000
                property  real tmp1: 1000
                property  real tmp2:0
                property string  rcv: ""

                onGetData: {
                    if ((data[0] ==="S")&&            // gestione STATI
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

                        if((data[0]=== "A") &&
                                (data[1]=== "P"))
                        {
                            pMAS.text = "Last MAS " + data[2]+data[3]+data[4]+data[5]+"."+data[6]
                        }
                        else if((data[0]=== "A") &&
                                (data[1]=== "T"))
                        {
                            pMs.text = "Last MS " + data[2]+data[3]+data[4]+data[5]+"."+data[6]
                        }
                        else
                        {

                            errorMessage.visible = false
                        }


                        if((data[0] ==="F")&&            // gestione fuoco
                                (data[1]==="O"))
                        {
                            if (data[2]==="0") // fuoco piccolo
                            {
                                speedometer.minimumValue = 80
                                speedometer.maximumValue = 160
                                speedometer.DashboardGaugeStyle.labelStepSize = 20
                                if ((valueSource.tecn == 1) &&  valueSource.fuoco) // solo sul cambio
                                    if (serialTerminal.getConnectionStatusSlot() !== false)
                                        serialTerminal.putPC1cmd("MA00800",1)
                                valueSource.fuoco = false
                            }
                            else
                            {
                                valueSource.fuoco = true
                                speedometer.minimumValue= 160
                                speedometer.maximumValue= 400
                                speedometer.DashboardGaugeStyle.labelStepSize = 50
                                if ((valueSource.tecn == 1) && (valueSource.fuoco === 0))
                                    if (serialTerminal.getConnectionStatusSlot() !== false)
                                        serialTerminal.putPC1cmd("MA01600",1)
                            }
                            errorMessage.visible = false
                        }else if((data[0] ==="E")&&            // gestione fuoco
                                 (data[1]==="T"))
                        {
                            if (data[2]==="0") // Tecnica 2 punti
                            {
                                if ((valueSource.tecn==1)||
                                        (valueSource.tecn == 4))// se è già impostata allora potrebbe essere
                                    // una risposta al polling
                                {
                                    valueSource.tecn = 0
                                    swTecnique.checked = false
                                    threePointPanel.visible = false
                                    twoPointPanel.visible = true
                                    // se e' la prima volta
                                    if((valueSource.mA!== 0)||(valueSource.msec !== 0))
                                    {
                                        var calcMas = valueSource.mA * (valueSource.msec/1000)
                                        var strMas =  strPars.process(calcMas)
                                        // calcolo quanti zeri devo aggiungere all'inizio
                                        // i mas vengono scritti in 5 cifre di cui l'ultima è il
                                        // decimale quindi 4 + 1
                                        var maxlen// numero zeri massimi meno numero cifre
                                        var maxLenNum

                                        if (calcMas<1) {maxlen = 5 - 1
                                            maxLenNum = 1}
                                        else if (calcMas<10){maxlen = 5 - 2
                                            maxLenNum = 2}
                                        else if (calcMas<100){maxlen = 5 - 3
                                            maxLenNum = 3}
                                        else if (calcMas<1000){maxlen = 5 - 4
                                            maxLenNum = 4}
                                        else if (calcMas<10000){maxlen = 5 - 5
                                            maxLenNum = 5}

                                        var str0Mas = ""        // definisco la stringa che conterrà gli zeri


                                        for (var cf = 0;cf<maxlen;cf ++)
                                            str0Mas += '0'
                                        str0Mas += strMas
                                        var mas2Send = "MX" + str0Mas
                                        serialTerminal.putPC1cmd(mas2Send,1)
                                    }else if(valueSource.mas===0)
                                    {
                                        if (serialTerminal.getConnectionStatusSlot() !== false)
                                        {
                                            serialTerminal.putPC1cmd("MX00006",1)
                                        }
                                    }
                                }
                            }
                            else // // Tecnica 3 punti
                            {
                                if ((valueSource.tecn == 0) ||
                                        (valueSource.tecn == 4))// se è già impostata allora potrebbe essere
                                    // una risposta al polling
                                {
                                    valueSource.tecn = 1
                                    swTecnique.checked = true
                                    threePointPanel.visible = true
                                    twoPointPanel.visible = false
                                    if (valueSource.fuoco) // se Fuoco Grande
                                    {
                                        if (serialTerminal.getConnectionStatusSlot() !== false)
                                        {
                                            serialTerminal.putPC1cmd("MA01600",1)
                                        }
                                    }
                                    else //fuoco piccolo
                                    {
                                        if (serialTerminal.getConnectionStatusSlot() !== false)
                                        {
                                            serialTerminal.putPC1cmd("MA00800",1)
                                        }
                                    }
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

                        }else if ((data[0]==="V") &&
                                  (data[1]==="C"))
                        {
                            tmp = (data[2]-"0")*100;
                            tmp += (data[3]-"0")*10;
                            tmp += data[4]-"0";                            
                            valueSource.cap = tmp;                           
                        }
                        else if ((data[0] ==="M")&&            // gestione Ma
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
                            valueSource.msec = tmp/10; // in secondi /1000
                            errorMessage.visible = false
                        }else if ((data[0] ==="M")&&            // gestione MAs
                                  (data[1]==="X"))
                        {
                            // dato che nel comando di init MAS e' lultimo ad arrivare, se parte vuoto e tutti sono vuoti
                            // Discriminare in base alla tecnica
                            // allora devo dargli i primi parametri
                            if((valueSource.kv==0) || (valueSource.mA==0) || (valueSource.msec==0))
                            {// invio i default
                                if (serialTerminal.getConnectionStatusSlot() !== false)
                                {
                                    serialTerminal.putPC1cmd("ET1",0)
                                    serialTerminal.putPC1cmd("FO0",0)
                                    serialTerminal.putPC1cmd("KV050",0)
                                    serialTerminal.putPC1cmd("MA01600",0)
                                    serialTerminal.putPC1cmd("MS01500",1)
                                    errorMessage.text = qsTr("DEFAULT PARAM !!!")
                                    errorMessage.visible = true
                                }
                            }
                            tmp =  (data[2]-"0")*1000;
                            tmp += (data[3]-"0")*100;
                            tmp += (data[4]-"0")*10;//0;
                            tmp += (data[5]-"0");//*10;
                            tmp += ( data[6]-"0")/10;
                            valueSource.mas = tmp;
                            errorMessage.visible = false
                        }
                        else if ((data[0] ==="P")&&            // gestione PRONTO
                                 (data[1]==="R"))
                        {

                            prState.value = data[2]-"0";
                            if (data[2] === "0")
                            {
                                prStatus.text = "IDLE"
                                serialTerminal.putPC1cmd("AP?",1);
                                serialTerminal.putPC1cmd("AT?",1);
                                // riabilito il pollingTimer
                                if (touchSynchro.checked)
                                {
                                    //pollingTimer.repeat = 1
                                    //setTimeout(sendAlignRqst,500)
                                    pollingTimer.start()
                                }
                                statusTimer.start()
                            }
                            else if (data[2]=== "1")
                            {
                                //se attivo disabilito il pollingTimer
                                if (touchSynchro.checked)
                                    //pollingTimer.repeat = 0
                                    pollingTimer.stop()
                                statusTimer.stop()
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
                        else if   ((data[0] ==="F")&&            // gestione versione Firmware
                                   (data[1]==="V"))
                        {
                            fVersion.text = "IF-XRAY VER: " +data[2]+data[3]+"."+
                                    data[4]+data[5]+"."+data[6]+data[7]
                        }
                        else if   ((data[0] ==="P")&&            // gestione versione Firmware
                                   (data[1]==="V"))
                        {
                            if (data!=="PV000/")
                                plVersion.text = "CAP BANK VER: " + data[2]+data[3]+"."+data[4]+data[5]
                            else
                                plVersion.text = "CAP BANK VER: " + "PANEL MANAGEMENT"

                        }
                        else if ((data[0] ==="P")&&            // gestione LATCHING ERROR
                                 (data[1]==="A"))
                        {
                            if((data[9] & 1)) // pos 0
                            {
                                errorMessage.text = qsTr("CAPACITOR CHARGE TIMEOUT !!!")
                                errorMessage.visible = true
                            }
                            if (data[9] & 2)
                            {
                                errorMessage.text = qsTr("TIMEOUT CHARGE CAPACITORS (during rebalancing) !!!")
                                errorMessage.visible = true
                            }
                            if ((data[9] === "6") && (data[8] === "5")&&
                                (data[7] === "2") && (data[6] === "0"))
                            {
                                errorMessage.text = qsTr("PL02 BUFFER RX OVERFLOW !!!")
                                errorMessage.visible = true
                            }
                            if ((data[9] & 4) && (data[9]!=="6") && (data[7]!=="2"))
                            {
                                errorMessage.text = qsTr("CHARGE CAPACITORS TOO SLOW !!!")
                                errorMessage.visible = true
                            }
                            if (data[9] & 8)
                                   errorMessage.text = qsTr("EXCEEDING CRITICAL THRESHOLD VMAX !!!")
                            if ((data[9] === "6") && (data[8] === "1"))
                            {
                                errorMessage.text = qsTr("CAPACITOR INPUT CALIBRATION !!!")
                                //  ALLARME_CAL_INGRESSI = ALARM_STATUS & 16 //0x10
                                errorMessage.visible = true
                            }
                            if ((data[9] === "8") && (data[8] === "6")&&
                                (data[7] === "7") && (data[6] === "2") && (data[5] ==="3"))
                            {
                                errorMessage.text = qsTr("WARNING V MAX RESTORED TO BALANCE CAPACITORS !!!")
                                   //WARNING_CARICA_MAX = ALARM_STATUS & 32768 //0x8000
                                errorMessage.visible = true
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
                                        errorMessage.text = qsTr("FEEDBACK UNCONNECTED")
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
                                    if(data[4]==="4")
                                        errorMessage.text = qsTr("PREPARATION TIMEOUT")
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
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: baudRate.bottom
                anchors.topMargin: 7
                onClicked: {

                    if (serialTerminal.getConnectionStatusSlot() === false){
                        serialTerminal.openSerialPortSlot(serialPorts.currentText,baudRate.currentText)

                        if (serialTerminal.getConnectionStatusSlot() !== false)
                        {
                            connectBtn.text = "Disconnect"
                            serialSettings.visible = false
                            //  yellowButton.opacity = 0.3
                            btnyellImage.source = "../images/green.png"
                            serialTerminal.putPC1cmd("RS",1)
                            serialTerminal.putPC1cmd("RR",1)
                            serialTerminal.putPC1cmd("FV?",1)
                            serialTerminal.putPC1cmd("PV?",1)
                            //  QUI PER ABILITARE IL polling STATI
                            statusTimer.repeat = 1
                            setStatusTo(sendStatusRqst,2500)
                        }
                    }else {
                        connectBtn.text = "Connect"
                        //    yellowButton.opacity = 1
                        btnyellImage.source = "../images/red.png"
                        serialSettings.visible = false
                        errorMessage.visible = false;
                        serialTerminal.resetAck();
                        serialTerminal.closeSerialPortSlot();

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



        Text {
            id: errorMessage
            x: 343
            y: 32
            width: 380
            height: 60
            color: "#fb0404"
            text: qsTr("Error Example !!")
            styleColor: "#4343eb"
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
            anchors.rightMargin: 301
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 508
        }



        Column {
            id: infoPanel
            x: 611
            width: 158
            height: 149
            layer.samples: 2
            scale: 1
            anchors.topMargin: 98

            StringParsing {
                id: strPars1
            }

            Text {
                id: fVersion
                color: "#f6f4f4"
                text: qsTr("IF-XRAY VER :")
                anchors.left: parent.left
                anchors.top: parent.top
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                fontSizeMode: Text.FixedSize
                anchors.leftMargin: 0
                anchors.topMargin: 0
                font.pixelSize: 14
            }

            Text {
                id: plVersion
                color: "#f6f4f4"
                text: qsTr("CAP BANK VER :")
                anchors.top: fVersion.bottom
                anchors.right: parent.right
                anchors.left: parent.left
                font.pixelSize: 14
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 5
                horizontalAlignment: Text.AlignLeft
                fontSizeMode: Text.FixedSize
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: pMs
                width: 92
                height: 23
                color: "#f9f9f9"
                text: qsTr("Msec")
                anchors.top: pMAS.bottom
                anchors.topMargin: 1
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 12
            }

            RadioButton {
                id: touchSynchro
                width: 14
                height: 16
                text: "Panel Synchro"
                anchors.top: pMs.bottom
                anchors.topMargin: 2
                anchors.left: parent.left
                // text: "Panel Synchro"
                onCheckedChanged: {
                    if (touchSynchro.checked)
                    {
                        //  QUI PER ABILITARE IL polling
                        pollingTimer.repeat = 1
                        setTimeout(sendAlignRqst,2000)
                    }else
                    {
                        pollingTimer.repeat = 0
                    }
                }
            }

            Text {
                id: pMAS
                width: 92
                height: 23
                color: "#f9f9f9"
                text: qsTr("Mas ")
                anchors.top: plVersion.bottom
                anchors.topMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 12
            }

      /*     Connections {
                target: serialTerminal
                tmp1: 1000
                tmp: 5000
                tmp2: 0
                rcv: ""
            }*/





            anchors.rightMargin: 255
            anchors.top: parent.top
            visible: false
            anchors.right: parent.right
        }

    }
}
//  Text { id: time }




