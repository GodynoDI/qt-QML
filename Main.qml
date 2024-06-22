import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Random Number Generator"

    Component.onCompleted: {
        backend.setMin(0)
        backend.setMax(1000)
        backend.timerStart(1000)
    }

    Canvas {
        id: chartCanvas
        anchors.fill: parent
        anchors.margins: 30
        property var data: []
        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var minY = backend.min
            var maxY = backend.max
            var rangeY = maxY - minY

            ctx.strokeStyle = "black"
            ctx.beginPath()
            ctx.moveTo(0, 0)
            ctx.lineTo(0, height)
            var zeroY = height + minY * height / rangeY
            ctx.moveTo(0, zeroY)
            ctx.lineTo(width, zeroY)
            ctx.stroke()

            ctx.strokeStyle = "red"
            ctx.beginPath()
            for (var i = 0; i < data.length; i++) {
                var x =  i * width / data.length
                var y = height - (data[i] - minY) * height / rangeY
                if (i === 0)
                    ctx.moveTo(x, y)
                else
                    ctx.lineTo(x, y)
                ctx.fillText(data[i].toString(), x, y)
            }
            ctx.stroke()
        }

        Timer {
            interval: backend.interval
            running: true
            repeat: true
            onTriggered: {
                if (chartCanvas.data.length > 25)
                    chartCanvas.data.shift()
                chartCanvas.data.push(backend.number)
                chartCanvas.requestPaint()
            }
        }
    }

    Button {
        text: "Настройки"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 15
        onClicked: settingsDialog.open()
    }

    Dialog {
        id: settingsDialog
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel

        Column {
            spacing: 10
            padding: 25

            TextField {
                id: minField
                placeholderText: "От"
                text: backend.min.toString()
            }

            TextField {
                id: maxField
                placeholderText: "До"
                text: backend.max.toString()
            }

            TextField {
                id: intervalField
                placeholderText: "Шаг(мс)"
                text: backend.interval.toString()
            }
        }
        onAccepted: {
            backend.setMin(parseInt(minField.text))
            backend.setMax(parseInt(maxField.text))
            backend.timerStart(parseInt(intervalField.text))
        }
    }
}
