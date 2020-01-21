import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0
import QtGraphicalEffects 1.0

CircularGauge {
    id: masGauge

    style: CircularGaugeStyle {
        labelStepSize: 10
        labelInset: outerRadius / 2.2
        tickmarkInset: outerRadius / 4.2
        minorTickmarkInset: outerRadius / 4.2
        minimumValueAngle: -144
        maximumValueAngle: 144

        background: Rectangle {
   //         implicitHeight: MasGauge.height
   //         implicitWidth: MasGauge.width
            color: "black"
            anchors.centerIn: parent
            radius: 360

            Image {
                anchors.fill: parent
                source:"../images/background.svg"
                asynchronous: true
                sourceSize {
                    width: width
                }
            }

            Canvas {
              property int value: MasGauge.value//valueSource.mas//

                anchors.fill: parent
                onValueChanged: requestPaint()

                function degreesToRadians(degrees) {
                  return degrees * (Math.PI / 180);
                }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    ctx.beginPath();
                    ctx.strokeStyle = "black"
                    ctx.lineWidth = outerRadius
                    ctx.arc(outerRadius,
                          outerRadius,
                          outerRadius - ctx.lineWidth / 2,
                          degreesToRadians(valueToAngle(MasGauge.value) - 90),
                          degreesToRadians(valueToAngle(MasGauge.maximumValue + 1) - 90));
                    ctx.stroke();
                }
            }
        }

        needle: Item {
            y: -outerRadius * 0.78
            height: outerRadius * 0.27
            Image {
                id: needle
                source: "../images/needle.svg"
                height: parent.height
                width: height * 0.1
                asynchronous: true
                antialiasing: true
            }

            Glow {
              anchors.fill: needle
              radius: 5
              samples: 10
              color: "white"
              source: needle
          }
        }

        foreground: Item {
            Text {
                id: masLabel
                anchors.centerIn: parent
                text: masGauge.value.toFixed(0)
                font.pixelSize: outerRadius * 0.3
                color: "white"
                antialiasing: true
            }
            Text {
                text: "MAS"
                color: "white"
                font.pixelSize: masGauge.toPixels(0.1)
                anchors.top: masLabel.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        tickmarkLabel:  Text {
            font.pixelSize: Math.max(6, outerRadius * 0.05)
            text: styleData.value
            color: styleData.value <= MasGauge.value ? "white" : "#777776"
            antialiasing: true
        }

        tickmark: Image {
            source: "../images/tickmark.svg"
            width: outerRadius * 0.018
            height: outerRadius * 0.15
            antialiasing: true
            asynchronous: true
        }

        minorTickmark: Rectangle {
            implicitWidth: outerRadius * 0.01
            implicitHeight: outerRadius * 0.03

            antialiasing: true
            smooth: true
            color: styleData.value <= MasGauge.value ? "white" : "darkGray"
        }
    }
}
