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
    }

    // Dashboards are typically in a landscape orientation, so we need to ensure
    // our height is never greater than our width.
    Item {
        id: container
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        // Math.min(root.width, root.height)
        Column{
            id: gaugeColumn
            rotation: 0
            anchors.fill: parent
            spacing: 0

            Item {
                id: element
                x: 700
                y: 0
                width: 150
                height: 300
                anchors.horizontalCenterOffset: 380
                clip: false
                transformOrigin: Item.Right
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

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
                    maximumValue: 12
                    width: parent.width
                    height: parent.height * 0.7
                    value: 0
                    stepSize: 11
                    minimumValue: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    clip: false
                    y: parent.height / 2 + container.height * 0.01

                    style: IconGaugeStyle {
                        id: tempGaugeStyle
                        halfGauge: true
                        tickmarkStepSize: 3
                        minorTickmarkInset: 2
                        minorTickmarkCount: 2

   //                     tickmarkCount: 1
                       textt: "MSEC"
                       icon: "qrc:/images/temperature-icon.png"
                        maxWarningColor: Qt.rgba(0.5, 0, 0, 1)

                        tickmarkLabel: Text {
                            color: "white"
                            visible: styleData.value === 0 || styleData.value === 11
                            font.pixelSize: tempGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "min" : (styleData.value === 11 ? "max" : "")
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
                maximumValue: 50
                anchors.verticalCenter: parent.verticalCenter

                style: TachometerStyle {}

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
                    onClicked: fruitModel.setProperty(index, "cost", cost + 0.25)
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
                    onClicked: fruitModel.setProperty(index, "cost", cost + 0.25)
            }

            }

            CircularGauge {
                id: speedometer
                width: 285
                value: valueSource.mA
                anchors.verticalCenter: parent.verticalCenter
                maximumValue: 700
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
                onClicked: fruitModel.setProperty(index, "cost", cost + 0.25)
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
                onClicked: fruitModel.setProperty(index, "cost", cost + 0.25)
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

        }

        PressAndHoldButton {
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
            anchors.horizontalCenterOffset: -129
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
                onClicked:  m_settings(new SettingsDialog)


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
                opacity: 0.2
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

}

/*##^##
Designer {
    D{i:14;anchors_y:0}D{i:16;anchors_y:0}D{i:3;anchors_height:600;anchors_width:1000;anchors_x:0;anchors_y:0}
D{i:2;anchors_height:600;anchors_width:1024}
}
##^##*/
