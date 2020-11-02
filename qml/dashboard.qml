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
import QtQuick 2.0
import QtQuick 2.12
import QtQuick 2.2
import QtQml 2.12
import QtQuick.Window 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import Qt.labs.calendar 1.0
import QtQuick 2.7
import WdpClass 1.0
import QtGraphicalEffects 1.0
import QtQuick.VirtualKeyboard 2.1
import QtQuick.VirtualKeyboard 2.2
import QtQuick.VirtualKeyboard 2.4
import QtQuick.VirtualKeyboard.Settings 2.2
import "NumberPadSupport"
import "menuSupport"
import "NumberPadSupport/calculator.js" as CalcEngine
import "keyPadSupport"


// di seguito gli import per il menuPanel
//import QtQuick.Layouts 1.0
//import QtQuick.Dialogs 1.0
//import "content"

Window {
    id: root
    visible: true
    width: 1024
    height: 600

    color: "#d3eccb"
    //  property alias btnCloseCopyrightText: btnCloseCopyright.text
    // property alias touchSynchroText: touchSynchro.text

    property alias yellowButtonIconSource: yellowButton.iconSource
    //property alias elementAnchorsverticalCenterOffset: element.anchors.verticalCenterOffset
    //  property alias fuelGaugeY: focusGauge.y
    title: "Mu.De. Manager"



    property var keyPanelManager : 0  // indice dell'oggetto che sta gestendo il KeyPanel 0 = nessuno
    property var key_noone : 0
    property var key_mSec : 1
    property var key_kV : 2
    property var key_mAs : 3

    property var key_trimFP_1 : 4
    property var key_trimFP_2 : 5
    property var key_trimFP_3 : 6
    property var key_trimFP_4 : 7
    property var key_trimFP_5 : 8
    property var key_trimFP_6 : 9
    property var key_trimFP_7 : 10
    property var key_trimFP_8 : 11



    ValueSource {
        id: valueSource

        fuoco: false



    }

    function setAdvancedMode(value)
    {
        if (value)
        {
            valueSource.advancedMode = true
            valueSource.btnTXT = "EXIT"
            advancedIcon.visible = true
        }
        else
        {
            valueSource.advancedMode = false
            valueSource.btnTXT = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:10pt; color:#ffffff;\">ENTER</span></p></body></html>"
            advancedIcon.visible = false
        }
    }

    Timer{
        id: pollingTimer
        running: false
        repeat: false

        property var callback

        onTriggered: callback()

    }

    Image {
        id: advancedIcon
        visible: false
        anchors.fill: parent
        source: "../images/options-settings-White.svg"
        z: 2
        sourceSize.height: 70
        sourceSize.width: 70
        anchors.rightMargin: 944
        anchors.leftMargin: 10
        anchors.bottomMargin: 520
        anchors.topMargin: 10
        fillMode: Image.Stretch
    }

    Timer{
        id: statusTimer
        running: false
        repeat: false

        property var callback

        onTriggered: callback()

    }
    /*
    Timer{
        id: readyTimer
        running: true
        repeat: true
        interval: 300
        //property var callback

        onTriggered:  checkErrorReady() //callback()

    }*/

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

    function setStatusInterval(delay)
    {
        if(statusTimer.running){
            statusTimer.stop();
        }
        statusTimer.interval = delay;
        statusTimer.running = true;
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

    /*    function setReadyTo(callback, delay)
    {
        if(readyTimer.running){
            // error
            return;
        }
        readyTimer.callback = callback;
        readyTimer.interval = delay + 1;
        readyTimer.running = true;
    }*/

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


    function checkErrorReady()
    {// c'è un allarme in atto // non ho la connessione // lo stato è init, alarm, o disconnect // la carica e' minore di 98%
        if ((errorMessage.visible == true) || (serialTerminal.getConnectionStatusSlot() === false) ||
                ((valueSource.numericSTS == 0)  ||(valueSource.numericSTS == 1) || (valueSource.numericSTS == 5)) ||
                (valueSource.cap < 98))
            /*  if ((errorMessage.visible == true) || // c'è un allarme in atto
            ((valueSource.numericSTS == 0)  ||
             (valueSource.numericSTS == 1)  ||
             (valueSource.numericSTS == 5)) ||
             (valueSource.cap < 98))
*/
        {
            readyImg.source = "../images/noReady.png"
        }else
        {
            readyImg.source = "../images/ready.png"
        }
    }


    // Dashboards are typically in a landscape orientation, so we need to ensure
    // our height is never greater than our width.
    Item {
        id: container
        y: 0
        width: 1024
        height: 600
        anchors.rightMargin: 0
        anchors.leftMargin: 0
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
            source: "../images/sfondo/sfondo-grigio-chiaro.png"
            anchors.fill: parent
            //Image:"qrc:image/logoRxR.jpg"
        }

        Column{
            id: backGroundPanel
            anchors.leftMargin: 0
            visible: true
            transformOrigin: Item.Center
            rotation: 0
            anchors.fill: parent
            spacing: 0
            anchors.centerIn: parent
            Item {
                id: rigthColumn
                x: 700
                y: 0
                width: 230
                height: 400
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
                    activeFocusOnPress: false
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
                        source: "../images/fuoco-piccolo_B.png"
                    }
                    onClicked:{
                        if (serialTerminal.getConnectionStatusSlot() !== false)
                        {

                            if (valueSource.fuoco) // Se fuoco grande
                            {
                                serialTerminal.putPC1cmd("MA01600",1) // serve per evitare l'errore kw max

                                serialTerminal.putPC1cmd("FO0",1)

                                focusImage.source =  "../images/fuoco-piccolo.png"
                                // se tecnica a 3 punti imposto il valore iniziale di MA Fuoco piccolo
                                if (valueSource.tecn)
                                    serialTerminal.putPC1cmd("MA00800",1)
                            }else // se piccolo
                            {
                                serialTerminal.putPC1cmd("FO1",1)
                                focusImage.source = "../images/fuoco-grande.png"

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
                    color: "#e20613"
                    text: qsTr("STATUS:")
                    anchors.leftMargin: -40
                    font.family: "Tahoma"
                    anchors.top: parent.top
                    anchors.topMargin: 1
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
                    anchors.rightMargin: 195
                    font.pixelSize: 18
                }

                Text {
                    id: status
                    y: 196
                    height: 34
                    color: "#060606"// #5eb3e4
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
                            //     width: 80
                            //     height: 22
                            implicitWidth: 200
                            implicitHeight: 20
                            radius: 1
                            border.color: "#b6b3b3"
                            opacity: 1
                            visible: true
                            color: "#060606"
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
                    color: "#060606"

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
                    color: "#e20613"
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
                    x: -117
                    width: 63
                    height: 261
                    anchors.top: status.top
                    anchors.topMargin: -63
                    value:  valueSource.cap
                    anchors.right: parent.right
                    anchors.rightMargin: 284
                    Rectangle{
                        width: 13
                        radius: 3
                        border.width: 2
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        z: 2

                    }
                    style: GaugeStyle{

                        tickmarkLabel: Text {
                            text: control.formatValue(styleData.value)
                            font: control.font
                            color:"black"
                            antialiasing: true
                        }

                        tickmark: Item {
                         //   implicitWidth: Math.round(TextSingleton.height * 1.1)
                          //  implicitHeight: Math.max(2, Math.round(TextSingleton.height * 0.1))

                            Rectangle {
                                color:"black"
                                anchors.fill: parent
                                anchors.leftMargin: Math.round(TextSingleton.implicitHeight * 0.2)
                                anchors.rightMargin: Math.round(TextSingleton.implicitHeight * 0.2)
                            }
                        }

                    }
                }

                Text {
                    id: focusTitle
                    y: 265
                    height: 35
                    color: "#060606"
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
                    anchors.topMargin: 60
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
                    anchors.topMargin: -130

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
                        color: "#e20613" // #5eb3e4
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
                        color: "#00000000"
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
                    color: "#060606"
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
                    anchors.topMargin: 40
                    font.family: "Tahoma"
                    styleColor: "#16161616"
                    fontSizeMode: Text.HorizontalFit
                    font.pixelSize: 18
                }

                Image {
                    id: readyImg
                    x: -790
                    y: -185
                    width: 85
                    height: 35
                    anchors.verticalCenterOffset: 0
                    anchors.verticalCenter: readyTitle.verticalCenter
                    anchors.left: readyTitle.right
                    anchors.leftMargin: 1
                    fillMode: Image.PreserveAspectFit
                    source: "../images/noReady.png"
                }

            }
            Item{
                id: kVPanel
                width: 285
                height: 285
                visible: true
                anchors.verticalCenterOffset: 50
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.verticalCenter: parent.verticalCenter
                CircularGauge {
                    id: tachometer
                    y: 0
                    anchors.fill: parent
                    //0.25 - gaugeRow.spacing
                    value: valueSource.kv
                    maximumValue: 125
                    minimumValue: 40

                    style: TachometerStyle {}

                    MouseArea {
                        id: kvpadCommPos
                        y: 98
                        height: 45
                        anchors.verticalCenterOffset: 47
                        z: 2
                        hoverEnabled: true
                        opacity: 1
                        anchors.left: parent.left
                        anchors.leftMargin: 115
                        anchors.right: parent.right
                        anchors.rightMargin: 115
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: {
                            if (panelKeyPad.visible === false)
                            {
                                panelKeyPad.visible=true
                                kvbrd.border.color = "#f62f2f"
                                keyPanelManager = key_kV
                                CalcEngine.setItem(keyPanelManager)
                                appare.running = true
                            }else
                            {
                                if (keyPanelManager == key_kV)
                                {
                                    //               keyPanelManager = key_noone
                                    //               kvbrd.border.color = "#00000000"
                                    scompare.running = true
                                }
                            }
                        }
                        Rectangle {
                            id : kvbrd
                            color: "#00000000"
                            border.color: "#00000000"
                            anchors.fill: parent
                            z: 3
                            border.width: 2
                        }
                    }
                    onValueChanged:  {
                        kvpadCommPos.anchors.rightMargin = 130 - (valueSource.kv.toString().length * 10)
                        kvpadCommPos.anchors.leftMargin = 130 - (valueSource.kv.toString().length * 10)
                    }
                }
                PressAndHoldButton {
                    id: kvPlus
                    width: 15
                    height: 15
                    visible: true
                    anchors.left: tachometer.horizontalCenter
                    anchors.leftMargin: 40
                    anchors.top: tachometer.bottom
                    anchors.topMargin: 10
                    smooth: false
                    antialiasing: true
                    z: 1.63
                    scale: 3.859
                    transformOrigin: Item.Top
                    sourceSize.height: 23
                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: 23
                    pressed: false
                    source: "../images/piu_b.png"
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
                    width: 15
                    height: 5
                    anchors.top: tachometer.bottom
                    anchors.topMargin: 30
                    anchors.right: tachometer.horizontalCenter
                    anchors.rightMargin: 40
                    antialiasing: true
                    z: 1.63
                    scale: 3.859
                    transformOrigin: Item.Top
                    sourceSize.height: 23
                    fillMode: Image.Stretch
                    sourceSize.width: 23
                    pressed: false
                    source: "../images/meno_b.png"
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

            }

            //  spacing: 10

            Item {
                id: twoPointPanel
                width: 325
                height: 285
                anchors.left: kVPanel.right
                anchors.leftMargin: 10
                visible: false
                anchors.verticalCenterOffset: 50
                anchors.verticalCenter: parent.verticalCenter
                MasGauge{
                    id:masGa
                    property bool accelerating
                    width: 285
                    height: 285
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    anchors.left: parent.left
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
                    x: 48
                    width: 15
                    height: 5
                    anchors.right: masGa.horizontalCenter
                    anchors.rightMargin: 40
                    anchors.top: masGa.bottom
                    anchors.topMargin: 30
                    scale: 3.859
                    sourceSize.height: 24
                    z: 1.63
                    transformOrigin: Item.Top
                    source: "../images/meno.png"
                    antialiasing: true
                    sourceSize.width: 23
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
                    width: 15
                    height: 15
                    anchors.top: parent.bottom
                    anchors.topMargin: 10
                    anchors.leftMargin: 40
                    scale: 3.859
                    sourceSize.height: 23
                    z: 1.63
                    transformOrigin: Item.Top
                    source: "../images/piu.png"
                    antialiasing: true
                    sourceSize.width: 23
                    pressed: false
                    fillMode: Image.PreserveAspectFit
                    anchors.left: masGa.horizontalCenter
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
                    x: 77
                    width: 15
                    height: 5
                    anchors.right: speedometer.horizontalCenter
                    anchors.rightMargin: 40
                    anchors.top: speedometer.bottom
                    anchors.topMargin: 30
                    anchors.horizontalCenterOffset: -52
                    antialiasing: true
                    z: 1.63
                    scale: 3.859
                    transformOrigin: Item.Top
                    sourceSize.height: 23
                    fillMode: Image.Stretch
                    sourceSize.width: 23
                    pressed: false
                    source: "../images/meno_b.png"
                    onClicked:{
                        if (serialTerminal.getConnectionStatusSlot() !== false)
                        {
                            serialTerminal.putPC1cmd("MA-",1)
                        }
                    }
                }

                PressAndHoldButton {
                    id: mAPlus
                    width: 15
                    height: 15
                    anchors.left: speedometer.horizontalCenter
                    anchors.leftMargin: 40
                    anchors.top: speedometer.bottom
                    anchors.topMargin: 10
                    anchors.horizontalCenterOffset: -52
                    antialiasing: true
                    z: 1.63
                    scale: 3.859
                    transformOrigin: Item.Top
                    sourceSize.height: 23
                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: 23
                    pressed: false
                    source: "../images/piu_b.png"
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
                        maxWarningColor: "#e20613"//"#5bb2e5"

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
                            color: "black"//"white"
                            visible: styleData.value === 0 || styleData.value === 2/*11*/|| styleData.value === 1
                            font.pixelSize: tempGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "min" :(styleData.value === 1 ? "MSEC" : (styleData.value === 2/*11*/ ? "max" : ""))
                        }

                    }

                    MouseArea {
                        id: padCommPos
                        y: 98
                        height: 50
                        anchors.verticalCenterOffset: 40
                        z: 2
                        hoverEnabled: true
                        opacity: 1
                        anchors.left: parent.left
                        anchors.leftMargin: 31
                        anchors.right: parent.right
                        anchors.rightMargin: 31
                        anchors.verticalCenter: parent.verticalCenter
                        //onWidthChanged: controller.reload()
                        //  onHeightChanged: controller.reload()
                        onClicked: {
                            if ((panelKeyPad.visible === false) && (menuPanel.visible== false))
                            {
                                panelKeyPad.visible=true
                                //     panelKeyPad.x = 200
                                msecbrd.border.color = "#f62f2f"
                                keyPanelManager = key_mSec
                                CalcEngine.setItem(keyPanelManager)
                                appare.running= true
                            }else
                            {
                                if ( keyPanelManager == key_mSec)
                                {
                                    //      keyPanelManager = key_noone
                                    //      msecbrd.border.color = "#00000000"
                                    scompare.running = true
                                }
                            }
                        }

                        Rectangle {
                            id : msecbrd
                            color: "#00000000"
                            border.color: "#00000000"
                            anchors.fill: parent
                            border.width: 2
                            /*                         AnimationController {
                                id: controller
                                animation: ParallelAnimation {
                                    id: anim
                                    NumberAnimation { target: display; property: "x"; duration: 400; from: -16; to: padCommPos.width - display.width; easing.type: Easing.InOutQuad }
                                    NumberAnimation { target: pad; property: "x"; duration: 400; from: padCommPos.width - pad.width; to: 0; easing.type: Easing.InOutQuad }
                                    SequentialAnimation {
                                        NumberAnimation { target: pad; property: "scale"; duration: 200; from: 1; to: 0.97; easing.type: Easing.InOutQuad }
                                        NumberAnimation { target: pad; property: "scale"; duration: 200; from: 0.97; to: 1; easing.type: Easing.InOutQuad }
                                    }
                                }*/
                            //      }

                        }
                        /*                      TapHandler {
                            id: movingKeynum
                            //onTapped: panelKeyPad.x === 0 ? panelKeyPad.x = 200 : panelKeyPad.x = 0
                            onTapped: panelKeyPad.visible === true ? panelKeyPad.x -= 200 : panelKeyPad.x += 200
                        }*/
                    }
                    onValueChanged:  {
                        msecMinus.anchors.rightMargin = 35 + (valueSource.msec.toString().length * 10)
                        msecPlus.anchors.leftMargin = 35 + (valueSource.msec.toString().length * 10)

                        padCommPos.anchors.rightMargin = 45 - (valueSource.msec.toString().length * 10)
                        padCommPos.anchors.leftMargin = 45 - (valueSource.msec.toString().length * 10)


                    }
                    PressAndHoldButton {
                        id: msecMinus
                        width: 8
                        height: 2
                        anchors.top: parent.bottom
                        anchors.topMargin: -42
                        //  anchors.left: parent.left
                        anchors.right : parent.horizontalCenter
                        anchors.rightMargin: 55
                        transformOrigin: Item.Top
                        anchors.verticalCenterOffset: -30
                        sourceSize.width: 23
                        sourceSize.height: 15
                        z: 1.63
                        scale: 3.859
                        fillMode: Image.Stretch
                        pressed: false
                        source: "../images/meno_b.png"
                        anchors.verticalCenter: tachometer.verticalCenter
                        // anchors.leftMargin: 2
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
                        width: 8
                        height: 8
                        anchors.top: parent.bottom
                        anchors.topMargin: -55
                        anchors.verticalCenterOffset: -30
                        source: "../images/piu_b.png"
                        anchors.leftMargin: 55
                        antialiasing: true
                        anchors.verticalCenter: tachometer.verticalCenter
                        scale: 3.859
                        transformOrigin: Item.Top
                        z: 1.63
                        fillMode: Image.Stretch
                        anchors.left: parent.horizontalCenter
                        sourceSize.width: 23
                        sourceSize.height: 23
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
            Item {
                id: mACalPanel
                anchors.left: parent.left
                anchors.right: rigthColumn.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.rightMargin: 115
                anchors.topMargin: 168
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                visible: false
                property int selector : 1
                onSelectorChanged:{

                }

                Grid {
                    id: mACalFGPanel
                    x: 0
                    y: 0
                    width: 667
                    height: 400
                    visible: true
                    flow: Grid.TopToBottom
                    rows: 4
                    columns: 3
                    property var calSel: "1."

                    function refreshCalmAFG()
                    {

                        // invio il msg
                        if ((serialTerminal.getConnectionStatusSlot() !== false)&&(!brokenCase))
                        {
                            serialTerminal.putPC1cmd("AR9",1)
                            serialTerminal.putPC1cmd("AR10",1)
                            serialTerminal.putPC1cmd("AR11",1)
                            serialTerminal.putPC1cmd("AR4",1)
                            serialTerminal.putPC1cmd("AR5",1)
                            serialTerminal.putPC1cmd("AR6",1)
                            serialTerminal.putPC1cmd("AR7",1)
                            serialTerminal.putPC1cmd("AR8",1)
                        }
                    }

                    MouseArea{
                        id: point9
              //          property bool selection: true
                        property string mAR : ""
                        property bool select : true
                        width: 210
                        height: 100

                        MACallPoint{ selected: false;c_N: "1.";kV:"45";mA:"160";}


                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point18.select = false
                                point17.select = false
                                point16.select = false
                                point15.select = false
                                point14.select = false
                                point13.select = false
                                point12.select = false
                                point11.select = false
                                point10.select = false
                                point9.select = true
                        }
                    }

                    //  MACallPoint{c_N: "1.";kV:"45";mA:"160";toSel:mACalFGPanel.calSel}
                    MouseArea{
                        id: point10
                        width: 210
                        height: 100
                        property bool select : false
                        property string mAR : ""
                        MACallPoint{c_N: "2.";kV:"100";mA:"160";selected:point10.select}

                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point18.select = false
                                point17.select = false
                                point16.select = false
                                point15.select = false
                                point14.select = false
                                point13.select = false
                                point12.select = false
                                point11.select = false
                                point10.select = true
                                point9.select = false
                        }
                    }

                    MouseArea{
                        id: point11
                        width: 210
                        height: 100
                        property bool select : false
                        property string mAR : ""

                        MACallPoint{c_N: "3.";kV:"45";mA:"200";selected:point11.select}

                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point18.select = false
                                point17.select = false
                                point16.select = false
                                point15.select = false
                                point14.select = false
                                point13.select = false
                                point12.select = false
                                point11.select = true
                                point10.select = false
                                point9.select = false
                        }
                    }
                    MouseArea{
                        id: point12
                        width: 210
                        height: 100
                        property bool select : false
                        property string mAR : ""
                        MACallPoint{c_N: "4.";kV:"100";mA:"200";selected:point12.select}
                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point18.select = false
                                point17.select = false
                                point16.select = false
                                point15.select = false
                                point14.select = false
                                point13.select = false
                                point12.select = true
                                point11.select = false
                                point10.select = false
                                point9.select = false
                        }
                    }
                    MouseArea{
                        id: point13
                        width: 210
                        height: 100
                        property bool select : false
                        property string mAR : ""
                        MACallPoint{c_N: "5.";kV:"45";mA:"250";selected:point13.select}
                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point18.select = false
                                point17.select = false
                                point16.select = false
                                point15.select = false
                                point14.select = false
                                point13.select = true
                                point12.select = false
                                point11.select = false
                                point10.select = false
                                point9.select = false
                        }
                    }
                    MouseArea{
                        id: point14
                        width: 210
                        height: 100
                        property bool select : false
                        property string mAR : ""
                        MACallPoint{c_N: "6.";kV:"100";mA:"250";selected:point14.select}
                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point18.select = false
                                point17.select = false
                                point16.select = false
                                point15.select = false
                                point14.select = true
                                point13.select = false
                                point12.select = false
                                point11.select = false
                                point10.select = false
                                point9.select = false
                        }
                    }
                    MouseArea{
                        id: point15
                        width: 210
                        height: 100
                        property bool select : false
                        property string mAR : ""
                    MACallPoint{c_N: "7.";kV:"45";mA:"300";selected:point15.select}
                    onClicked:  {

                            // Se ho selezionato il punto invio i dati e deseleziono gli altri
                            point18.select = false
                            point17.select = false
                            point16.select = false
                            point15.select = true
                            point14.select = false
                            point13.select = false
                            point12.select = false
                            point11.select = false
                            point10.select = false
                            point9.select = false
                    }
                    }
                    MouseArea{
                        id: point16
                        width: 210
                        height: 100
                        property bool select : false
                        property string mAR : ""
                        MACallPoint{c_N: "8.";kV:"90";mA:"300";selected:point16.select}
                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point18.select = false
                                point17.select = false
                                point16.select = true
                                point15.select = false
                                point14.select = false
                                point13.select = false
                                point12.select = false
                                point11.select = false
                                point10.select = false
                                point9.select = false
                        }
                    }
                    MouseArea{
                        id: point17
                        width: 210
                        height: 100
                        property bool select : false
                        property string mAR : ""
                        MACallPoint{c_N: "9.";kV:"45";mA:"400";selected:point17.select}
                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point18.select = false
                                point17.select = true
                                point16.select = false
                                point15.select = false
                                point14.select = false
                                point13.select = false
                                point12.select = false
                                point11.select = false
                                point10.select = false
                                point9.select = false
                        }
                    }
                    MouseArea{
                        id: point18
                        width: 210
                        height: 100
                        property bool select : false
                        property string mAR : ""
                        MACallPoint{c_N: "10.";kV:"70";mA:"400";selected:point18.select}
                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point18.select = true
                                point17.select = false
                                point16.select = false
                                point15.select = false
                                point14.select = false
                                point13.select = false
                                point12.select = false
                                point11.select = false
                                point10.select = false
                                point9.select = false
                        }
                    }
                }
                Grid {
                    id: mACalFPPanel
                    x: 0
                    y: 0
                    width: 667
                    height: 400
                    visible: false
                    spacing: 0
                    topPadding: 0
                    flow: Grid.TopToBottom
                    rows: 4
                    columns: 3
                    property var calSel:".1"
                    function refreshCalmAFP()
                    {

                        // invio il msg
                        if ((serialTerminal.getConnectionStatusSlot() !== false)&&(!brokenCase))
                        {
                            serialTerminal.putPC1cmd("AR1",1)
                            serialTerminal.putPC1cmd("AR2",1)
                            serialTerminal.putPC1cmd("AR3",1)
                            serialTerminal.putPC1cmd("AR4",1)
                            serialTerminal.putPC1cmd("AR5",1)
                            serialTerminal.putPC1cmd("AR6",1)
                            serialTerminal.putPC1cmd("AR7",1)
                            serialTerminal.putPC1cmd("AR8",1)
                        }
                    }

                    MouseArea{
                        id: point1
                        property string mAR : ""
                        property bool select : true
                        width: 210
                        height: 100
                        MACallPoint{ selected: false;c_N: "1.";kV:"80";mA:"80";}  // toSel:1 è l'elemento che deve essere selezionato per primo
                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point8.select = false
                                point7.select = false
                                point6.select = false
                                point5.select = false
                                point4.select = false
                                point3.select = false
                                point2.select = false
                                point1.select = true
                        }

                    }
                    MouseArea{
                        id: point2
                        property string mAR : ""
                        property bool select : false
                        width: 210
                        height: 100
                        MACallPoint{c_N: "2.";kV:"115";mA:"80";selected:point2.select}
                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point8.select = false
                                point7.select = false
                                point6.select = false
                                point5.select = false
                                point4.select = false
                                point3.select = false
                                point2.select = true
                                point1.select = false
                        }
                    }
                    MouseArea{
                        id: point3
                        property string mAR : ""
                        property bool select : false
                        width: 210
                        height: 100
                        MACallPoint{c_N: "3.";kV:"65";mA:"100";selected:point3.select}
                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point8.select = false
                                point7.select = false
                                point6.select = false
                                point5.select = false
                                point4.select = false
                                point3.select = true
                                point2.select = false
                                point1.select = false
                        }
                    }
                    MouseArea{
                        id: point4
                        property string mAR : ""
                        property bool select : false
                        width: 210
                        height: 100
                    MACallPoint{c_N: "4.";kV:"95";mA:"100";selected:point4.select}
                    onClicked:  {

                            // Se ho selezionato il punto invio i dati e deseleziono gli altri
                            point8.select = false
                            point7.select = false
                            point6.select = false
                            point5.select = false
                            point4.select = true
                            point3.select = false
                            point2.select = false
                            point1.select = false
                    }
                    }
                    MouseArea{
                        id: point5
                        property string mAR : ""
                        property bool select : false
                        width: 210
                        height: 100
                    MACallPoint{c_N: "5.";kV:"45";mA:"125";selected:point5.select}
                    onClicked:  {

                            // Se ho selezionato il punto invio i dati e deseleziono gli altri
                            point8.select = false
                            point7.select = false
                            point6.select = false
                            point5.select = true
                            point4.select = false
                            point3.select = false
                            point2.select = false
                            point1.select = false
                    }
                    }
                    MouseArea{
                        id: point6
                        property string mAR : ""
                        property bool select : false
                        width: 210
                        height: 100
                        MACallPoint{c_N: "6.";kV:"75";mA:"125";selected:point6.select}
                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point8.select = false
                                point7.select = false
                                point6.select = true
                                point5.select = false
                                point4.select = false
                                point3.select = false
                                point2.select = false
                                point1.select = false
                        }
                    }
                    MouseArea{
                        id: point7
                        property string mAR : ""
                        property bool select : false
                        width: 210
                        height: 100
                        MACallPoint{c_N: "7.";kV:"45";mA:"160";selected:point7.select}
                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point8.select = false
                                point7.select = true
                                point6.select = false
                                point5.select = false
                                point4.select = false
                                point3.select = false
                                point2.select = false
                                point1.select = false
                        }
                    }
                    MouseArea{
                        id: point8
                        property bool select : false
                        property string mAR : ""
                        width: 210
                        height: 100
                        MACallPoint{c_N: "8.";kV:"60";mA:"160";selected:point8.select}
                        onClicked:  {

                                // Se ho selezionato il punto invio i dati e deseleziono gli altri
                                point8.select = true
                                point7.select = false
                                point6.select = false
                                point5.select = false
                                point4.select = false
                                point3.select = false
                                point2.select = false
                                point1.select = false
                        }
                    }



                }

                Button{
                    id:btnSaveACAl
                    x: 537
                    y: 298
                    width: 55
                    height: 55
                    anchors.bottom: btnClsmACalPnl.top
                    anchors.bottomMargin: 15
                    anchors.horizontalCenter: btnClsmACalPnl.horizontalCenter
                    style: ButtonStyle {
                        background: Rectangle {
                            color: "transparent"
                            radius: height/2
                            border.color: "#00000000"
                            border.width: 1
                            antialiasing: true
                        }
                    }
                    Image {
                        id: imgBtnSaveACal
                        anchors.fill: parent
                        sourceSize.width: 0
                        visible: true
                        fillMode: Image.Stretch
                        sourceSize.height: 0
                        scale: 1
                        rotation: 0
                        source: "../images/save_icon.png"
                    }
                    onClicked: {
                        // blocco il toggle cambio tecnica su 3 punti
                        if (serialTerminal.getConnectionStatusSlot() !== false)
                        {
                            serialTerminal.putPC1cmd("AW",1)
                        }
                    }
                }
                Button{
                    id:readACAl
                    width: 55
                    height: 55
                    anchors.bottom: btnSaveACAl.bottom
                    layer.textureMirroring: ShaderEffectSource.NoMirroring
                    smooth: true
                    layer.smooth: false
                    antialiasing: true
                    anchors.bottomMargin: 70
                    anchors.horizontalCenter: btnClsmACalPnl.horizontalCenter
                    style: ButtonStyle {
                        background: Rectangle {
                            color: "transparent"
                            radius: height/2
                            border.color: "#00000000"
                            border.width: 1
                            antialiasing: true
                        }
                    }
                    Image {
                        id: imgBtnReadACal
                        anchors.fill: parent
                        sourceSize.width: 0
                        visible: true
                        fillMode: Image.Stretch
                        sourceSize.height: 0
                        scale: 1
                        rotation: 0
                        source: "../images/refresh-page-arrow.png"
                        antialiasing: true
                        smooth: false
                    }
                    onClicked:
                    {
                        if (valueSource.fuoco)
                            refreshCalmAFG()
                        else
                            refreshCalmAFP()
                    }
                }

                Button {
                    id: btnClsmACalPnl
                    anchors.verticalCenter: title.verticalCenter
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 370
                    anchors.bottomMargin: 32
                    anchors.rightMargin: 68
                    checkable: true
                    anchors.leftMargin: 507
                    Text {
                        id: btnClsTxt1
                        visible: true
                        color: "#ffffff"
                        text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:10pt;\">CLOSE</span></p></body></html>"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        textFormat: Text.RichText
                        minimumPixelSize: 13
                    }
                    iconSource: ""
                    enabled: true
                    style: ButtonStyle {
                        background: Rectangle {
                            color: "#de1414"
                            radius: height/2
                            border.color: "#ffffff"
                            border.width: 2
                            antialiasing: true
                        }
                    }
                    onClicked: {
                        // invio il comando
                        if (serialTerminal.getConnectionStatusSlot() !== false)
                        {
                            serialTerminal.putPC1cmd("CAL0",1)
                        }
                        if (valueSource.tecn) // se tecnica 3 punti
                            threePointPanel.visible = true
                        else
                            twoPointPanel.visible = true
                        kVPanel.visible = true
                        // Attivo il pannello calibrazione MAFG
                        mACalPanel.visible = false
                        // blocco il toggle cambio tecnica su 3 punti
                        swTecnique.enabled = true
                    }
                    isDefault: false
                    z: 3
                }
            }


        }

        Image {
            id: logo
            y: 53
            width: 310
            height: 115
            anchors.left: parent.left
            anchors.leftMargin: 16
            fillMode: Image.PreserveAspectFit
            source: "../images/Risorsa 1.png"
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
                width: 209
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
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
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
                        }else if (infoPanel.visible== false)
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
                        visible: true
                        rotation: 0
                        sourceSize.height: 0
                        sourceSize.width: 0
                        fillMode: Image.Stretch
                        scale: 1
                        source: "../images/red.png"
                    }

                }

                Button {
                    id: infoButton
                    y: 0
                    width: 55
                    height: 55
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    layer.textureMirroring: ShaderEffectSource.NoMirroring
                    isDefault: false
                    layer.format: ShaderEffectSource.RGBA
                    layer.samples: 2


                    onClicked:  {
                        if (menuPanel.visible)
                        {
                            // menuPanel.visible= false
                            menu_out.running = true
                        }else if (panelKeyPad.visible==false)
                        {
                            if (valueSource.advancedMode)
                            {
                                bt_calA.visible = true
                                bt_calV.visible = true
                            }else
                            {
                                bt_calA.visible = false
                                bt_calV.visible = false
                            }

                            menuPanel.visible = true
                            menu_in.running = true
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
                        anchors.fill: parent
                        sourceSize.width: 0
                        visible: true
                        fillMode: Image.Stretch
                        sourceSize.height: 0
                        scale: 1
                        rotation: 0
                        source: "../images/toppng.com-menu-icon-black.png"
                    }
                    smooth: false
                    layer.enabled: false
                    iconSource: ""
                    layer.wrapMode: ShaderEffectSource.ClampToEdge
                    clip: false
                    checkable: false
                }

                Image {
                    id: emissionImg
                    width: 55
                    height: 55
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    source: "../images/xray-bianco.png"
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
                property int  cntr: 0

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
                            valueSource.numericSTS = data[4]
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
                            if (data!=="CONNERROR")
                                cntr = 0
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
                                focusImage.source =  "../images/fuoco-piccolo.png"
                                // se attiva la calibrazione
                                if (mACalPanel.visible)
                                {
                                    mACalFPPanel.visible = true
                                    mACalFGPanel.visible = false
                                }
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
                                focusImage.source =  "../images/fuoco-grande.png"
                                if (mACalPanel.visible)
                                {
                                    mACalFPPanel.visible = false
                                    mACalFGPanel.visible = true
                                }
                            }
                            errorMessage.visible = false
                            cntr = 0
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
                                    tecLabel2.color = "#5bb2e5"
                                    tecLabel3.color = "#fbfbfb"
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
                                    tecLabel3.color = "#5bb2e5";
                                    tecLabel2.color = "#fbfbfb"
                                }
                            }
                            errorMessage.visible = false
                            cntr = 0
                        }
                        else if ((data[0] ==="K")&&            // gestione kV
                                 (data[1]==="V"))
                        {
                            tmp = (data[2]-"0")*100;
                            tmp += (data[3]-"0")*10;
                            tmp += data[4]-"0";
                            valueSource.kv = tmp;
                            errorMessage.visible = false
                            cntr = 0
                        }else if ((data[0]==="V") &&
                                  (data[1]==="C"))
                        {
                            tmp = (data[2]-"0")*100;
                            tmp += (data[3]-"0")*10;
                            tmp += data[4]-"0";
                            valueSource.cap = tmp;
                            if (valueSource.cap >= 98 ) // se maggiore di 98
                                setStatusInterval(3500);

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
                            cntr = 0
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
                            cntr = 0
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
                            errorMessage.visible = false;
                            cntr = 0
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
                            {
                                emissionImg.source = "../images/xray-bianco.png"
                                setStatusInterval(1000);
                            }
                            else if (data[2]=== "1")
                            {
                                serialTerminal.putPC1cmd(data,1);
                                emissionImg.source ="../images/xray-giallo.png"
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
                                    if(data[4]==="5")
                                        errorMessage.text = qsTr("CHARGE CONNECTION TIMEOUT")
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
                        else if((data[0]=== "O")&&
                                data[1]=== "C")
                        {
                            if (data[2] === "1") // Se abilitazine Calibrazione corrente
                            {
                                // sulla lettura della risposta dovrei eseguire quello che segue
                                mACalPanel.visible = true
                                twoPointPanel.visible = false
                                threePointPanel.visible = false
                                kVPanel.visible = false
                                // blocco il toggle cambio tecnica su 3 punti
                                if (serialTerminal.getConnectionStatusSlot() !== false)
                                {
                                    serialTerminal.putPC1cmd("ET1",1)
                                }
                                swTecnique.enabled = false
                                // se sono su FG
                                if (valueSource.fuoco)
                                { // tolgo i pannelli del funzionamento
                                    // Attivo il pannello calibrazione MAFG
                                    mACalFGPanel.visible = true
                                    maCalFPPanel.visible = false
                                    // il tempo e' fisso a  tmp = 1700; 17 mS impostato da IFXRAY
                                    // invio il messaggio di abilitazione calibrazione
                                }else
                                {
                                    mACalFPPanel.visible = true
                                }
                            }else if (data[3] === "2")// se abilitazione Calibrazione Tensione
                            {
                                mACalFGPanel.visible = false

                            }
                        }

                        else if (data==="CONNERROR")
                        {
                            //Deve succedere almeno 2 volte di seguito
                            if (cntr < 3)
                            {
                                cntr++
                            }
                            else
                            {//Se sono in preparazione o in emissione non rispondo ai messaggi
                                if((valueSource.numericSTS!=3) ||
                                   (valueSource.numericSTS!=4))
                                {

                                        errorMessage.text = qsTr("CONNECTION LOST !!!")
                                        errorMessage.visible = true
                                }
                                cntr = 0
                            }
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
            x: 748
            width: 260
            height: 90
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
                text: ""
                anchors.verticalCenterOffset: -10
                anchors.verticalCenter: pMs.verticalCenter
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: -10
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
                Text {
                    id: touchLabel
                    y: -3
                    width: 91
                    height: 23
                    color: "white"
                    text: qsTr("Panel Synchro")
                    anchors.left: parent.left
                    anchors.leftMargin: 18
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 12
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





            anchors.rightMargin: 16
            anchors.top: parent.top
            visible: false
            anchors.right: parent.right
        }


        Rectangle {
            id: panelKeyPad
            x: 839
            y: 44
            z:1
            width: 154
            height: 370
            color: "#00000000"
            border.color: "#00000000"
            anchors.rightMargin: 31
            visible: false
            anchors.verticalCenterOffset: 32
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right

            XAnimator {
                id : appare
                easing.amplitude: 1.05
                //This specifies how long the animation takes
                duration: 1000
                //This selects an easing curve to interpolate with, the default is Easing.Linear
                easing.type: Easing.OutCubic
                target: panelKeyPad
                from: panelKeyPad.x+200
                to : panelKeyPad.x
                running: false
            }
            SequentialAnimation{
                id:scompare
                XAnimator {
                    easing.amplitude: 1.05
                    //This specifies how long the animation takes
                    duration: 800
                    //This selects an easing curve to interpolate with, the default is Easing.Linear
                    easing.type: Easing.OutCubic
                    target: panelKeyPad
                    from: panelKeyPad.x
                    to : panelKeyPad.x+200
                    running: false
                }
                onStopped:{
                    panelKeyPad.visible = false
                    keyPanelManager = key_noone
                    msecbrd.border.color = "#00000000"
                    kvbrd.border.color = "#00000000"
                }
            }


            // This is the behavior, and it applies a NumberAnimation to any attempt to set the x property
            /*            Behavior on x {
                      NumberAnimation  {

                          easing.amplitude: 1.05
                          //This specifies how long the animation takes
                          duration: 1000
                          //This selects an easing curve to interpolate with, the default is Easing.Linear
                          easing.type: Easing.OutCubic
                      }
                  }*/


            function operatorPressed(operator) {
                CalcEngine.operatorPressed(operator)
                numPad.buttonPressed()
            }
            function digitPressed(digit) {
                CalcEngine.digitPressed(digit)
                numPad.buttonPressed()
            }
            function isButtonDisabled(op) {
                return CalcEngine.disabled(op)
            }
            function setIdxValue(idx,value)
            {
                var brokenCase = 0
                var strTosend=""
                // compongo il messaggio
                switch (idx)
                {
                case key_mSec:
                    // formatto il valore per essere inviato via cpi
                    strTosend = "MS" + value +"0"

                    break;
                case key_kV:
                    strTosend = "KV" + value
                    break;

                case 0:
                default:
                    brokenCase = 1
                    break;
                }
                // invio il msg
                if ((serialTerminal.getConnectionStatusSlot() !== false)&&(!brokenCase))
                {
                    serialTerminal.putPC1cmd(strTosend,1)
                }
                /* Tolgo il riferimento a idx dato che il pannellino si è chiuso
                if (keyPanelManager == key_mSec)
                    msecbrd.border.color = "#00000000"
                else if (keyPanelManager ==  key_kV)
                    kvbrd.border.color = "#00000000"
                keyPanelManager =  key_noone*/
            }

            Item {
                id: pad
                anchors.right: parent.right
                anchors.rightMargin: -30
                visible: true
                anchors.top: parent.top
                anchors.left: parent.left
                NumberPad { id: numPad; z:1;width: 154; visible: true; anchors.top: parent.top; anchors.topMargin: -5; anchors.left: parent.left; anchors.horizontalCenter: parent.horizontalCenter;
                }
            }



            Keys.onPressed: {
                if (event.key === Qt.Key_0)
                    digitPressed("0")
                else if (event.key === Qt.Key_1)
                    digitPressed("1")
                else if (event.key === Qt.Key_2)
                    digitPressed("2")
                else if (event.key === Qt.Key_3)
                    digitPressed("3")
                else if (event.key === Qt.Key_4)
                    digitPressed("4")
                else if (event.key === Qt.Key_5)
                    digitPressed("5")
                else if (event.key === Qt.Key_6)
                    digitPressed("6")
                else if (event.key === Qt.Key_7)
                    digitPressed("7")
                else if (event.key === Qt.Key_8)
                    digitPressed("8")
                else if (event.key === Qt.Key_9)
                    digitPressed("9")
                else if (event.key === Qt.Key_Plus)
                    operatorPressed("+")
                else if (event.key === Qt.Key_Minus)
                    operatorPressed("−")
                else if (event.key === Qt.Key_Asterisk)
                    operatorPressed("×")
                else if (event.key === Qt.Key_Slash)
                    operatorPressed("÷")
                else if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return)
                    operatorPressed("=")
                else if (event.key === Qt.Key_Comma || event.key === Qt.Key_Period)
                    digitPressed(".")
                else if (event.key === Qt.Key_Backspace)
                    operatorPressed("backspace")
            }


            /*       NumberPad {
                id: touchpad
                width: 154
                height: 314
                anchors.bottomMargin: 16
                anchors.topMargin: -16
                anchors.fill: parent
                z: 1
                scale: 0.90
                visible: false

                Rectangle {
                    id: backrect
                    y: 40
                    z: -1
                    color: "#eceeea"
                    anchors.top: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -40
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    opacity: 0.5
                    MouseArea {
                        anchors.fill: parent
                    }
                }
            }*/
            Image {
                id: numPadImg
                x: 180
                y: -5
                width: 154
                height: 314
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                z:-1
                visible: true
                opacity: 0.953
                sourceSize.height: 1000
                sourceSize.width: 1000
                fillMode: Image.Tile
                source: "content/background.svg"
            }

            Display {
                id: display
                height: 50
                anchors.topMargin: -50
                z:2
                anchors.top: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                displayedOperand: "wew"
                anchors.bottom: parent.bottom
                visible: true

                /*        MouseArea {
                    id: mouseInput
                    property real startX: 0
                    property real oldP: 0
                    property bool rewind: false

                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                        right: parent.right
                    }
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    onPositionChanged: {
                        var reverse = startX > panelKeyPad.width / 2
                        var mx = mapToItem(panelKeyPad, mouseInput.mouseX, mouseInput.mouseY).x
                        var p = Math.abs((mx - startX) / (panelKeyPad.width - display.width))
                        if (p < oldP)
                            rewind = reverse ? false : true
                        else
                            rewind = reverse ? true : false
                        controller.progress = reverse ? 1 - p : p
                        oldP = p
                    }
                    onPressed: startX = mapToItem(panelKeyPad, mouseInput.mouseX, mouseInput.mouseY).x
                    onReleased: {
                        if (rewind)
                            controller.completeToBeginning()
                        else
                            controller.completeToEnd()
                    }
                }*/
            }

        }



        /*      property Component circularGauge: CircularGaugeView {}

            property Component dial: ControlView {
                darkBackground: false

                control: Column {
                    id: dialColumn
                    width: controlBounds.width
                    height: controlBounds.height - spacing
                    spacing: menuPanel.toPixels(0.05)

                    ColumnLayout {
                        id: volumeColumn
                        width: parent.width
                        height: (dialColumn.height - dialColumn.spacing) / 2
                        spacing: height * 0.025

                        Dial {
                            id: volumeDial
                            Layout.alignment: Qt.AlignCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true


       //                         Determines whether the dial animates its rotation to the new value when
      //                          a single click or touch is received on the dial.

                            property bool animate: customizerItem.animate

                            Behavior on value {
                                enabled: volumeDial.animate && !volumeDial.pressed
                                NumberAnimation {
                                    duration: 300
                                    easing.type: Easing.OutSine
                                }
                            }
                        }

                        ControlLabel {
                            id: volumeText
                            text: "Volume"
                            Layout.alignment: Qt.AlignCenter
                        }
                    }

                    ColumnLayout {
                        id: trebleColumn
                        width: parent.width
                        height: (dialColumn.height - dialColumn.spacing) / 2
                        spacing: height * 0.025

                        Dial {
                            id: dial2
                            Layout.alignment: Qt.AlignCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            stepSize: 1
                            maximumValue: 10

                            style: DialStyle {
                                labelInset: outerRadius * 0
                            }
                        }

                        ControlLabel {
                            id: trebleText
                            text: "Treble"
                            Layout.alignment: Qt.AlignCenter
                        }
                    }
                }

                customizer: Column {
                    spacing: customizerPropertySpacing

                    property alias animate: animateCheckBox.checked

                    CustomizerLabel {
                        text: "Animate"
                    }

                    CustomizerSwitch {
                        id: animateCheckBox
                    }
                }
            }

            property Component delayButton: ControlView {
                darkBackground: false

                control: DelayButton {
                    text: "Alarm"
                    anchors.centerIn: parent
                }
            }

            property Component gauge: ControlView {
                id: gaugeView
                control: Gauge {
                    id: gauge
                    width: orientation === Qt.Vertical ? implicitWidth : gaugeView.controlBounds.width
                    height: orientation === Qt.Vertical ? gaugeView.controlBounds.height : implicitHeight
                    anchors.centerIn: parent

                    minimumValue: 0
                    value: customizerItem.value
                    maximumValue: 100
                    orientation: customizerItem.orientationFlag ? Qt.Vertical : Qt.Horizontal
                    tickmarkAlignment: orientation === Qt.Vertical
                        ? (customizerItem.alignFlag ? Qt.AlignLeft : Qt.AlignRight)
                        : (customizerItem.alignFlag ? Qt.AlignTop : Qt.AlignBottom)
                }

                customizer: Column {
                    spacing: customizerPropertySpacing

                    property alias value: valueSlider.value
                    property alias orientationFlag: orientationCheckBox.checked
                    property alias alignFlag: alignCheckBox.checked

                    CustomizerLabel {
                        text: "Value"
                    }

                    CustomizerSlider {
                        id: valueSlider
                        minimumValue: 0
                        value: 50
                        maximumValue: 100
                    }

                    CustomizerLabel {
                        text: "Vertical orientation"
                    }

                    CustomizerSwitch {
                        id: orientationCheckBox
                        checked: true
                    }

                    CustomizerLabel {
                        text: controlItem.orientation === Qt.Vertical ? "Left align" : "Top align"
                    }

                    CustomizerSwitch {
                        id: alignCheckBox
                        checked: true
                    }
                }
            }

            property Component toggleButton: ControlView {
                darkBackground: false

                control: ToggleButton {
                    text: checked ? "On" : "Off"
                    anchors.centerIn: parent
                }
            }

            property Component pieMenu: PieMenuControlView {}

            property Component statusIndicator: ControlView {
                id: statusIndicatorView
                darkBackground: false

                Timer {
                    id: recordingFlashTimer
                    running: true
                    repeat: true
                    interval: 1000
                }

                ColumnLayout {
                    id: indicatorLayout
                    width: statusIndicatorView.controlBounds.width * 0.25
                    height: statusIndicatorView.controlBounds.height * 0.75
                    anchors.centerIn: parent

                    Repeater {
                        model: ListModel {
                            id: indicatorModel
                            ListElement {
                                name: "Power"
                                indicatorColor: "#35e02f"
                            }
                            ListElement {
                                name: "Recording"
                                indicatorColor: "red"
                            }
                        }

                        ColumnLayout {
                            Layout.preferredWidth: indicatorLayout.width
                            spacing: 0

                            StatusIndicator {
                                id: indicator
                                color: indicatorColor
                                Layout.preferredWidth: statusIndicatorView.controlBounds.width * 0.07
                                Layout.preferredHeight: Layout.preferredWidth
                                Layout.alignment: Qt.AlignHCenter
                                on: true

                                Connections {
                                    target: recordingFlashTimer
                                    onTriggered: if (name == "Recording") indicator.active = !indicator.active
                                }
                            }
                            ControlLabel {
                                id: indicatorLabel
                                text: name
                                Layout.alignment: Qt.AlignHCenter
                                Layout.maximumWidth: parent.width
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                    }
                }
            }

            property Component tumbler: ControlView {
                id: tumblerView
                darkBackground: false

                Tumbler {
                    id: tumbler
                    anchors.centerIn: parent

                    // TODO: Use FontMetrics with 5.4
                    Label {
                        id: characterMetrics
                        font.bold: true
                        font.pixelSize: textSingleton.font.pixelSize * 1.25
                        font.family: openSans.name
                        visible: false
                        text: "M"
                    }

                    readonly property real delegateTextMargins: characterMetrics.width * 1.5
                    readonly property var days: [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

                    TumblerColumn {
                        id: tumblerDayColumn

                        function updateModel() {
                            var previousIndex = tumblerDayColumn.currentIndex;
                            var newDays = tumbler.days[monthColumn.currentIndex];

                            if (!model) {
                                var array = [];
                                for (var i = 0; i < newDays; ++i) {
                                    array.push(i + 1);
                                }
                                model = array;
                            } else {
                                // If we've already got days in the model, just add or remove
                                // the minimum amount necessary to make spinning the month column fast.
                                var difference = model.length - newDays;
                                if (model.length > newDays) {
                                    model.splice(model.length - 1, difference);
                                } else {
                                    var lastDay = model[model.length - 1];
                                    for (i = lastDay; i < lastDay + difference; ++i) {
                                        model.push(i + 1);
                                    }
                                }
                            }

                            tumbler.setCurrentIndexAt(0, Math.min(newDays - 1, previousIndex));
                        }
                    }
                    TumblerColumn {
                        id: monthColumn
                        width: characterMetrics.width * 3 + tumbler.delegateTextMargins
                        model: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
                        onCurrentIndexChanged: tumblerDayColumn.updateModel()
                    }
                    TumblerColumn {
                        width: characterMetrics.width * 4 + tumbler.delegateTextMargins
                        model: ListModel {
                            Component.onCompleted: {
                                for (var i = 2000; i < 2100; ++i) {
                                    append({value: i.toString()});
                                }
                            }
                        }
                    }
                }
            }
*/
        //         property Component aboutPanel: Row {
        Row {
            id: aboutPanel
            x: 211
            y: 102
            width: 589
            height: 430
            visible: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: copirightTxt
                width: 369
                height: 85
                text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:14pt;\">Copiright (C) 2020 Rampoldi X-Ray s.r.l.</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:14pt;\">All right reserved worldwide.</span></p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-size:14pt;\"><br /></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><a href=\"mailto:w.depalo@rampoldixray.it\"><span style=\" font-family:'Verdana','sans-serif'; font-size:14pt; text-decoration: underline; color:#0000ff;\">w.depalo@rampoldixray.it</span></a><span style=\" font-size:14pt;\"> </span></p>\n<p style=\" margin-top:12px; margin-bottom:12px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><a href=\"http://www.rampoldixray.it/\"><span style=\" font-family:'Verdana','sans-serif'; font-size:14pt; text-decoration: underline; color:#0000ff;\">www.rampoldixray.it</span></a><span style=\" font-size:14pt;\"> </span></p></body></html>"
                elide: Text.ElideRight
                anchors.bottom: parent.bottom
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                anchors.bottomMargin: 35
                fontSizeMode: Text.FixedSize
                textFormat: Text.RichText
                minimumPixelSize: 17
                z: 3
                anchors.horizontalCenter: parent.horizontalCenter
                minimumPointSize: 17
            }

            Text {
                id: title
                height: 15
                text: "Mu.De. Manager "
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 12
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                minimumPointSize: 17
                minimumPixelSize: 17
                textFormat: Text.AutoText
                anchors.horizontalCenterOffset: 150
                z: 3
                anchors.verticalCenterOffset: -170
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: image
                visible: true
                anchors.fill: parent
                source: "../images/logoRxR.jpg"
                z: 2
                fillMode: Image.PreserveAspectCrop
            }

            Text {
                id: versionTxt
                height: 15
                text: "v xx.yy.zz"
                anchors.verticalCenter: title.verticalCenter
                font.pixelSize: 12
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                minimumPointSize: 17
                textFormat: Text.AutoText
                minimumPixelSize: 17
                z: 3
                anchors.horizontalCenterOffset: 80
                anchors.horizontalCenter: title.horizontalCenter
            }

            Button {
                id: btnCloseCopyright
                width: 100
                height: 30
                anchors.verticalCenter: title.verticalCenter

                anchors.left: parent.left
                enabled: true
                iconSource: ""
                isDefault: false
                checkable: true
                z: 3
                anchors.leftMargin: 57
                Text {
                    id: btnClsTxt
                    visible: true
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    textFormat: Text.RichText
                    minimumPixelSize: 13
                    color: "white"
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\n</style></head><body style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:10pt;\">CLOSE</span></p></body></html>"
                }
                style:ButtonStyle{
                    background:Rectangle{
                        color: "#de1414"

                        antialiasing: true
                        //"#666" : "transparent"
                        border.color: "white"
                        radius: height/2
                        border.width: 2
                    }
                    //     text:Text {
                    //          color: "white"
                    //          height: 15
                    //     }
                }
                onClicked: {
                    aboutPanel.visible = false
                }
            }
            onActiveFocusChanged: {
                if (aboutPanel.activeFocus)
                    aboutPanel.visible = true
                else
                    aboutPanel.visible = false
            }

        }

        Rectangle {
            id: pwdPanel
            x: 90
            y: 138
            width: 547
            height: 260
            visible: false
            border.color: "#f62f2f"
            border.width: 2
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#ffffff"
                }

                GradientStop {
                    position: 1
                    color: "#ff000000"
                }
            }

            function checkPWD(candidatePWD)
            {
                if (candidatePWD === valueSource.advanced_PWD)
                    return  true
                else
                    return false
            }

            Text {
                id: pwd_Title
                x: 148
                width: 230
                height: 40
                visible: true
                color: "#fbfbfb"
                text: "Enter Installer Password"
                anchors.top: parent.top
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                styleColor: "#fbfbfb"
                minimumPointSize: 14
                minimumPixelSize: 15
            }
            MouseArea  {
                id: pwdArea
                width: 230
                height: 40
                anchors.top: pwd_Title.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked:
                {
                    focus = true

                }


                TextField {
                    id: pwdTxtIn
                    width: 230
                    height: 40
                    text: qsTr("")
                    anchors.top: pwd_Title.bottom
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    z: 3
                    //  cursorVisible: true
                    anchors.topMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter

                    echoMode: TextInput.Password
                    placeholderText:  qsTr("Insert Password")
                    inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhPreferLowercase | Qt.ImhSensitiveData | Qt.ImhNoPredictiveText
                    enterKeyAction: EnterKeyAction.Next
                    /*                   onPressed: {
                        if (!keyboardArea.visible)
                        {
                            keyboardArea.visible = true
                            kb_in.running = true
                        }
                    }*/



                    //        onAccepted: upperCaseField.focus = true
                    /*     Rectangle{
                    color: "#fbfbfb"
                    border.width: 1
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    z: -1
                    anchors.horizontalCenter: parent.horizontalCenter
                }*/
                    onTextChanged: {
                        if (error_txt.visible)
                        {
                            pwdTxtIn.text=""
                            error_txt.visible = false
                        }

                    }

                    /*                onEditingFinished: {
                    if (pwdPanel.checkPWD(pwdTxtIn.text.toString()))
                        valueSource.advancedMode = true
                    else
                        error_txt.visible = true
                    pwdTxtIn.text=""
                }*/
                    onAccepted: {
                        if (pwdPanel.checkPWD(pwdTxtIn.text.toString()))
                        {
                            setAdvancedMode(true)
                        }
                        else
                            error_txt.visible = true
                    }

                }

            }
            Text {
                id: error_txt
                x: 148
                width: 230
                height: 40
                visible: false
                color: "#de1414"
                text: "WRONG PASSWORD !!!"
                anchors.top: btnEnter.bottom
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                minimumPixelSize: 15
                minimumPointSize: 14
                styleColor: "#fbfbfb"
            }

            Button {
                id: btnEnter
                width: 100
                height: 30
                anchors.verticalCenter: title.verticalCenter
                anchors.top: pwdArea.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                style: ButtonStyle {
                    background: Rectangle {
                        radius: height/2
                        border.color: "#ffffff"
                        border.width: 2
                        gradient: Gradient {
                            GradientStop {
                                position: 0.86935
                                color: "#f62f2f"
                            }

                            GradientStop {
                                position: 1
                                color: "#fbfbfb"
                            }
                        }
                        antialiasing: true
                    }
                }
                z: 3
                checkable: true
                isDefault: false
                Text {
                    id: btnEnterTxt
                    color: "#ffffff"
                    text: valueSource.btnTXT
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    textFormat: Text.RichText
                    minimumPixelSize: 13

                }
                iconSource: ""
                enabled: true
                onClicked: {
                    if (valueSource.advancedMode === false)
                    {
                        // check pwd
                        if (pwdPanel.checkPWD(pwdTxtIn.text.toString()))
                            setAdvancedMode(true)
                        else
                            error_txt.visible = true
                    }else
                        setAdvancedMode(false)
                }
            }

            Button {
                id: btnExit
                width: 30
                height: 30
                anchors.verticalCenter: title.verticalCenter
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 10
                anchors.topMargin: 10
                style: ButtonStyle {
                    background: Rectangle {
                        color: "#f62f2f"
                        radius: height/2
                        border.color: "#ffffff"
                        border.width: 2
                        antialiasing: true
                    }
                }
                z: 3
                checkable: true
                isDefault: false
                Text {
                    id: btnExitTxt
                    color: "#ffffff"
                    text: "X"
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 9
                    font.styleName: "Grassetto"
                    textFormat: Text.RichText
                    minimumPixelSize: 15
                }
                iconSource: ""
                enabled: true
                onClicked: {
                    // close
                    pwdPanel.visible = false
                    pwdTxtIn.focus = false
                    //inputPanel.active = false
                }
            }



        }

        Item {
            id: keyboardArea
            x: 198
            y: 0//376//392
            width: 650
            height: 200
            anchors.horizontalCenterOffset: -83

            // color: "#00000000"
            // Only set with CONFIG+=disable-desktop.
            property bool handwritingInputPanelActive: false


            //        width: Screen.width < Screen.height ? parent.height : parent.width
            //       height: Screen.width < Screen.height ? parent.width : parent.height

            rotation: Screen.width < Screen.height ? 90 : 0
            visible: true
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            //Basic {
            /*        Item{
                id: virtualKeyboard
                anchors.fill: keyboardArea
                // handwritingInputPanelActive: handwritingInputPanel.active

            }*/



            /*  Keyboard input panel.

                    The keyboard is anchored to the bottom of the application.
                */
            InputPanel {
                id: inputPanel
                y: 283 // Qt.inputMethod.visible ? keyboardArea.height - inputPanel.height : keyboardArea.height// appContainer.height
                anchors.left: parent.left
                anchors.right: parent.right
                z: 89

                property var ypos: 300
                states : State {
                    name: "visible"
                    //  The visibility of the InputPanel can be bound to the Qt.inputMethod.visible property,
                    //    but then the handwriting input panel and the keyboard input panel can be visible
                    //    at the same time. Here the visibility is bound to InputPanel.active property instead,
                    //    which allows the handwriting panel to control the visibility when necessary.

                    when: inputPanel.active
                    PropertyChanges {
                        target: inputPanel
                        y: 0 //keyboardArea.height - inputPanel.height

                    }
                }

                /*                transitions: Transition {
                        id: inputPanelTransition
                        from: ""
                        to: "visible"
                        reversible: true
                        enabled: true //!VirtualKeyboardSettings.fullScreenMode
                        ParallelAnimation {
                            NumberAnimation {
                                properties: "y"
                                duration: 2250
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }*/
                transitions: Transition {
                    id: kb_in
                    from: ""
                    to: "visible"
                    reversible: true
                    enabled: true //!VirtualKeyboardSettings.fullScreenMode
                    ParallelAnimation {
                        NumberAnimation {
                            properties: "y"
                            duration: 1000
                            //              from: inputPanel.ypos
                            //               to: keyboardArea.y
                            easing.type: Easing.OutCubic
                        }
                    }
                }
                // transizione sul click dell'attivazione
                Binding {
                    target: InputContext
                    property: "animating"
                    value: kb_in.running //inputPanelTransition.running
                }
                //   AutoScroller {}
            }
            // abilitazione in full Screen
            Binding {
                target: VirtualKeyboardSettings
                property: "fullScreenMode"
                value: false //appContainer.height > 0 && (appContainer.width / appContainer.height) > (16.0 / 9.0)
            }
            /*         YAnimator {
                id : kb_in
                easing.amplitude: 1.05
                //This specifies how long the animation takes
                duration: 1000
                //This selects an easing curve to interpolate with, the default is Easing.Linear
                easing.type: Easing.OutCubic
                target: keyboardArea
                from:583// (keyboardArea.height+16) - keyboardArea.ypos
                to :keyboardArea.ypos
                running: false
            }*/
        }
    }
    FontLoader {
        id: openSans
        source: "qrc:/fonts/OpenSans-Regular.ttf"
    }

    /* property var componentMap: {
        "SystemInfo": infoPanel,
        "About": aboutPanel
        //               "Dial": dial,
        //               "Gauge": gauge,
        //               "PieMenu": pieMenu,
        //                "StatusIndicator": statusIndicator,
        //              "ToggleButton": toggleButton,
        //               "Tumbler": tumbler
    }*/

    Rectangle {
        id: menuPanel
        x: 711
        y: 16
        property  var ypos: 16
        width: 200
        height: 400
        visible: false
        color: "#00000000"
        function toPixels(percentage) {
            return percentage * Math.min(menuPanel.width, menuPanel.height);
        }


        property bool isScreenPortrait: height > width
        property color lightFontColor: "#222"
        property color darkFontColor: "#e7e7e7"
        readonly property color lightBackgroundColor: "#cccccc"
        readonly property color darkBackgroundColor: "#161616"
        property real customizerPropertySpacing: 10
        property real colorPickerRowSpacing: 8

        Text {
            id: textSingleton

        }
        Grid{

            columns: 1
            columnSpacing: 0
            rowSpacing: 0
            id: menuPad
            rows: 5
            signal mnButtonPressed
            anchors.fill: parent


            Button {
                id: bt_SysInjfo
                width: menuPad.width
                height: menuPad.height * (1/menuPad.rows)
                text : qsTr("System Info")

                style: BlackButtonStyle {
                    fontColor: menuPanel.darkFontColor
                    rightAlignedIconSource: "qrc:/images/icon-go.png"

                }
                onClicked: {
                    // chiudi menu
                    menu_out.running = true
                    if (infoPanel.visible)
                        infoPanel.visible = false
                    else if (serialSettings.visible == false)
                        infoPanel.visible = true
                }
            }


            Button {
                id: bt_About
                width: menuPad.width
                height: menuPad.height * (1/menuPad.rows)
                text: qsTr("About Mu.de. ... ")
                style: BlackButtonStyle {
                    fontColor: menuPanel.darkFontColor
                    rightAlignedIconSource: "qrc:/images/icon-go.png"
                }
                onClicked: {
                    // chiudi menu
                    menu_out.running = true
                    if (aboutPanel.visible)
                        aboutPanel.visible = false
                    else
                        aboutPanel.visible = true
                }
            }

            Button {
                id:bt_Advanced
                width: menuPad.width
                height: menuPad.height * (1/menuPad.rows)
                text: qsTr("Advanced Mode")
                style: BlackButtonStyle {
                    fontColor: menuPanel.darkFontColor
                    rightAlignedIconSource: "qrc:/images/icon-go.png"
                }
                onClicked: {
                    // chiudi menu
                    menu_out.running = true
                    if (pwdPanel.visible)
                        pwdPanel.visible = false
                    else
                    {
                        pwdPanel.visible = true
                        pwdTxtIn.text="" // pulisco la stringa se sporca
                    }
                }

            }

            Button {
                id: bt_calA
                width: menuPad.width
                height: menuPad.height * (1/menuPad.rows)
                text: "Current Cal."
                visible: false
                style: BlackButtonStyle {
                    fontColor: menuPanel.darkFontColor
                    rightAlignedIconSource: "qrc:/images/icon-go.png"
                }
                onClicked: {
                    // chiudi menu
                    menu_out.running = true

                    // In realtà dovrei inviare solamente il messaggio al sistema
                    // invio il comando
                    if (serialTerminal.getConnectionStatusSlot() !== false)
                    {
                        serialTerminal.putPC1cmd("OC1",1)
                    }

                }
            }

            Button {
                id: bt_calV
                width: menuPad.width
                height: menuPad.height * (1/menuPad.rows)
                text: "Voltage Cal."
                visible : false
                style: BlackButtonStyle {
                    fontColor: menuPanel.darkFontColor
                    rightAlignedIconSource: "qrc:/images/icon-go.png"
                }
                onClicked: {
                    // chiudi menu
                    menu_out.running = true
                }
            }

        }
        /*StackView {
                id: stackView
                anchors.fill: parent
                visible: false
                initialItem: ListView {

                    model: ListModel {
                        ListElement {
                            title: "System Info"
                        }
                        ListElement {
                            title: "About Mu.De.Manager..."
                        }
                        ListElement {
                            title: "Advanced Mode"
                        }
                        ListElement {
                            title: "Current Calibration"
                        }
                        ListElement {
                            title: "Voltage Calibration"
                        }
                        ListElement {
                            title: "StatusIndicator"
                        }
                        ListElement {
                            title: "ToggleButton"
                        }
                        ListElement {
                            title: "Tumbler"
                        }
                    }

                    delegate: Button {
                        width: stackView.width
                        height: menuPanel.height * 0.125
                        text: title

                        style: BlackButtonStyle {
                            fontColor: menuPanel.darkFontColor
                            rightAlignedIconSource: "qrc:/images/icon-go.png"
                        }

                        onClicked: {
                            if (stackView.depth == 1) {
                                // Only push the control view if we haven't already pushed it...
                                stackView.push({item: componentMap[title]});
                              //  stackView.currentItem.forceActiveFocus();
                                stackView.currentItem.visible = true
                        //        menuPanel.visible = false
                            }
                        }
                    }
                }
                delegate: StackViewDelegate {
                        function transitionFinished(properties)
                        {
                            //properties.exitItem.opacity = 1
                          //  properties.exitItem.y -= stackView.height
                            //if (stackView.parent.visible)


                         }

                        pushTransition: StackViewTransition {
                            PropertyAnimation {
                                target: enterItem
                                property: "y"
                                from: stackView.y// - stackView.height
                                to: stackView.y
                            }
                            PropertyAnimation {
                                target: exitItem
                                property: "y"
                                from: stackView.y
                                to: stackView.y // - stackView.height-menuPanel.y
                            }
                        }
                    }
                    */

        YAnimator {

            id : menu_in
            easing.amplitude: 1.05
            //This specifies how long the animation takes
            duration: 1000
            //This selects an easing curve to interpolate with, the default is Easing.Linear
            easing.type: Easing.OutCubic
            target: menuPanel
            from: menuPanel.ypos-(menuPanel.height+16)
            to :menuPanel.ypos
            running: false
        }
        SequentialAnimation{
            id: menu_out
            YAnimator  {
                easing.amplitude: 1.05
                //This specifies how long the animation takes
                duration: 600
                //This selects an easing curve to interpolate with, the default is Easing.Linear
                easing.type: Easing.OutCubic
                target: menuPanel
                from: menuPanel.ypos
                to : menuPanel.ypos-(menuPanel.height+16)
                running: false
            }
            onStopped:{
                menuPanel.visible = false
                menuPanel.y = menuPanel.ypos // riposiziono
            }
        }

    }

}



//  Text { id: time }











