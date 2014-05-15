// TalkSlide, a custom component that displays a specific style of slide

import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle
{
    // These properties can be configured
    property string backgroundImage: ""
    property string title: "Title"
    property string byline: "Byline"
    property string presenterText: "Presenter"
    property variant nextSlide

    property variant bgfill

    width: parent.width
    height: parent.height
    color: "black"
    visible: false
    id: slide

    onVisibleChanged: {
        // When we shows this slide determine if we have an image to show or if
        // we should use a gradient backdrop
        if (visible == true) {
            if (backgroundImage == "") {
                gradient.visible = true;
                backdrop.visible = false;
                bgfill = gradient;
            } else {
                gradient.visible = false;
                backdrop.visible = true;
                bgfill = backdrop;
            }

            mainAnimation.running = true;
            console.log("Show slide");
        }
    }

    // Load the image if specified
    Image {
        id: backdrop
        source: backgroundImage
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop

        visible: false
    }

    // Create a radial gradient as a backup
    RadialGradient {
        id: gradient
        anchors.fill: parent
        verticalRadius: parent.width

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#555555" }
            GradientStop { position: 0.5; color: "#111111" }
        }

        visible: false
    }

    Text {
        id: titleText
        text: title
        color: "white"

        font.pointSize: 36

        style: Text.Outline
        styleColor: "black"

        // We don't use anchors here, because we animate
        horizontalAlignment: Text.AlignHCenter
        width: parent.width

        // Make the text vertical then offset it negatively to put it above the line
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -titleText.height

        opacity: 0
    }

    Text {
        id: bylineText
        text: byline
        color: "#BBBBBB"

        font.pointSize: 32

        style: Text.Outline
        styleColor: "black"

        horizontalAlignment: Text.AlignHCenter
        width: parent.width

        // Make the text vertical then offset it positively to put it below the line
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: bylineText.height

        opacity: 0
    }

    Rectangle {
        id: seperator
        color: "#0000AA"

        width: parent.width * 0.5
        height: parent.height * 0.01

        anchors.verticalCenter: parent.verticalCenter

        opacity: 0
    }

    ParallelAnimation {
        id: mainAnimation
        running: false

        // Starting values
        PropertyAction { target: slide; property: "opacity"; value: 1 }
        PropertyAction { target: titleText; property: "opacity"; value: 0 }
        PropertyAction { target: bylineText; property: "opacity"; value: 0 }
        PropertyAction { target: seperator; property: "opacity"; value: 0 }

        // Create zoom effect on background image
        NumberAnimation { target: backdrop; property: "scale"; from: 1; to: 1.2; duration: 10000; }

        SequentialAnimation {
            NumberAnimation { target: bgfill; property: "opacity"; from: 0; to: 1; duration: 1000; }
            //PropertyAction { target: backdrop; property: "opacity"; value: 1; }

            // Slide/fade the seperator in from left side of screen
            ParallelAnimation {
                NumberAnimation { target: seperator; property: "x"; from: -(parent.width * 0.25); to: parent.width * 0.25; duration: 1000; easing.type: "InQuad" }
                NumberAnimation { target: seperator; property: "opacity"; from: 0; to: 1; duration: 500; }
            }

            // Small slide/fade action for title
            ParallelAnimation {
                NumberAnimation { target: titleText; property: "x"; from: -(parent.width * 0.05); to: 0; duration: 500;  }
                NumberAnimation { target: titleText; property: "opacity"; from: 0; to: 1; duration: 500; }
            }

            // Small slide/fade action for byline
            ParallelAnimation {
                NumberAnimation { target: bylineText; property: "x"; from: -(parent.width * 0.05); to: 0; duration: 500; }
                NumberAnimation { target: bylineText; property: "opacity"; from: 0; to: 1; duration: 500; }
            }

            PauseAnimation { duration: 6000 }

            // Fade out and hide the slide
            NumberAnimation { target: slide; property: "opacity"; from: 1; to: 0; duration: 1000; }
            PropertyAction { target: slide; property: "visible"; value: false }

            // Show the next slide
            PropertyAction { target: nextSlide; property: "visible"; value: true }
        }

    }
}
