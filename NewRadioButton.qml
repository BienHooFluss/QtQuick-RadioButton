import QtQuick 2.15

Item {
    width: 260
    height: 80
    property var size: 0
    property var borderColor: 0


    Rectangle {
        id: outerArc
        width: width
        height: width
        radius: width * 0.5
        color: "white"
        border.width: 2
        border.color: "#5F74F0"
        opacity: 0
        anchors {
            horizontalCenter: centerArc.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: centerArc
        width: 40
        height: 40
        radius: height * 0.5
        //boder.width: 1
        border.color: borderColor == 0 ? "grey" : "#5F74F0"
        Rectangle {
            width: size
            height: size
            radius: size * 0.5
            color: size == 0 ? "white" : "#5F74F0"
            anchors.centerIn: parent
        }

        anchors {
            left: parent.left
            leftMargin: 30
            verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        width: 120
        height: 40
        color: "grey"
        anchors {
            left: parent.left
            leftMargin: 90
            verticalCenter: parent.verticalCenter
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                timer.running = true
            }
        }
    }

    Timer {
        id: timer
        interval: 50; running: false; repeat: true
        onTriggered: {
            if (borderColor)
            {
                timer.running = false
                borderColor = 0
                size = 0
                return
            }
            else {
                if (size > 16)
                {
                    timer.running = false
                    borderColor = 1
                    sequentialAnimation.running = true
                    return
                }
                size += 5
            }
        }
    }

    ParallelAnimation {
        id: showOuterArc
        running: false
        PropertyAnimation {
            target: outerArc;
            property: "opacity";
            to: 1
            duration: 300;
        }
        PropertyAnimation {
            target: outerArc;
            property: "width";
            to: 80
            duration: 300;
        }
    }

    ParallelAnimation {
        id: hideOuterArc
        running: false
        PropertyAnimation {
            target: outerArc;
            running: false;
            property: "opacity";
            from: 1
            to: 0
            duration: 200;
        }
//        PropertyAnimation {
//            target: outerArc;
//            running: false;
//            property: "width";
//            to: 60
//            duration: 200;
//        }
    }

    SequentialAnimation {
        id: sequentialAnimation
        running: false
        ScriptAction {script: {showOuterArc.running = true;}}
        PauseAnimation {
            duration: 200
        }
        ScriptAction {script: {showOuterArc.running = false;hideOuterArc.running = true;}}
        ScriptAction {script: sequentialAnimation.running = false;}
    }

}
