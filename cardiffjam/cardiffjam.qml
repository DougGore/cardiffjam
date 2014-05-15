// QML Auto Presentation System
// A simple system for doing self-running presentations with a bit of style

import QtQuick 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

Rectangle {
	id: main
    width: Screen.width
    height: Screen.height
    color: "black"

    // The title screen is custom section of animation, we start with a white background
    Rectangle {
        id: titleScreen
        width: parent.width
        height: parent.height
        color: "white"

        // The PiCymru logo starts completely transparent and slightly scaled down
        Image  {
            id: picymru
            source: "large_trans.png"

            scale: 0.9
            opacity: 0

            anchors.centerIn: parent
        }

        // Text will be transparent and centred in the middle of the screen
        Text {
            id: presents
            text: "presents"
            color: "#999999"
            font.pointSize: 64
            opacity: 0

            anchors.centerIn: parent
        }

        BackgroundShader {
            id: shader
            width: parent.width
            height: parent.height

            visible: false
        }

        Text {
            id: cardiffjam

            text: "Cardiff Jam"
            color: "black"

            font.pointSize: 128
            font.bold: true

            opacity: 0

            anchors.centerIn: parent
        }

        // Run all the animation actions below one at a time in order
        SequentialAnimation {
            running: true
            id: titleAnimation

            // PropertyActions are immediate, they just set values

            // Reset our staging (neccessary as our presentation runs in a loop)

            PropertyAction { target: picymru; property: "scale"; value: 0.9 }
            PropertyAction { target: presents; property: "scale"; value: 1.0 }

            PropertyAction { target: titleScreen; property: "visible"; value: true }
            PropertyAction { target: titleScreen; property: "opacity"; value: 1 }

            // These animations run in parallel, they all have to complete before we move onto
            // the next animation in the sequence.
            ParallelAnimation {
                // Fade and zoom in the PiCymru logo
                PropertyAnimation { target: picymru; property: "opacity"; to: 1; duration: 3000; easing.type: Easing.InCubic }
                PropertyAnimation { target: picymru; property: "scale"; to: 1; duration: 5000 }
            }

            // Fade logo out, and "presents" in, with "presents" zooming in as well
            ParallelAnimation {
                PropertyAnimation { target: picymru; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutCubic }
                PropertyAnimation { target: presents; property: "opacity"; to: 1; duration: 1000; }
                PropertyAnimation { target: presents; property: "scale"; to: 1.5; duration: 3000; }
            }

            // Fade "presents" out
            PropertyAnimation { target: presents; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutCubic }

            // Make our shader visible
            PropertyAction { target: shader; property: "visible"; value: true }

            // Fade in "Cardiff Jam"
            NumberAnimation { target: cardiffjam; property: "opacity"; to: 0.8; duration: 1000; }

            // Pause for 8 seconds (shader will continue to animate)
            PauseAnimation { duration: 8000 }

            // Fade this title screen out
            NumberAnimation { target: titleScreen; property: "opacity"; from: 1; to: 0; duration: 1000; }

            // Hide/reset some stuff
            PropertyAction { target: titleScreen; property: "visible"; value: false }
            PropertyAction { target: shader; property: "visible"; value: false }
            PropertyAction { target: cardiffjam; property: "opacity"; value: 0 }

            // Show our first talk slide
            PropertyAction { target: slide1; property: "visible"; value: true }
        }

        onVisibleChanged: {
            if (visible == true) {
                titleAnimation.running = true;
                console.log("Show title");
            }
        }

    }

    /*
        This section defines all the slides, these are QML components that have
        been created to be the visual and logical content.

        Each slide needs the following:
         - Identifier
         - Title
         - Byline (goes below title)
         - Background image URL (optional, radial gradient used otherwise)
         - Next slide identifer
    */

    TalkSlide {
        id: slide1
        title: "Today's Programme"
        byline: "With breaks between talks"
        nextSlide: slide2
    }

    TalkSlide {
        id: slide2
        title: "Introduction"
        byline: "Matthew Gall (@matthewgall)"
        nextSlide: slide3
    }

    TalkSlide {
        id: slide3
        title: "The MagPi"
        byline: "Colin Deady (@ethicalwebsites)"
        backgroundImage: "magpi.png"
        nextSlide: slide4
    }

    TalkSlide {
        id: slide4
        title: "Super Phil"
        byline: "Julian Milligan (@darthmill)"
        backgroundImage: "superphil.jpg"
        nextSlide: slide5
    }

    TalkSlide {
        id: slide5
        title: "Looking Good"
        byline: "Douglas Gore (@douggore)"
        backgroundImage: "qtgraphics.jpg"
        nextSlide: slide6
    }

    TalkSlide {
        id: slide6
        title: "Testing"
        byline: "Colin Deady (@ethicalwebsites)"
        backgroundImage: "testing.jpg"
        nextSlide: slide7
    }

    TalkSlide {
        id: slide7
        title: "Open Discussion"
        byline: "Get answers to your questions"
        nextSlide: slide8
    }

    TalkSlide {
        id: slide8
        title: "Finish at 5.30pm"
        byline: "Have fun and make some friends!"
        nextSlide: titleScreen
    }

    focus: true
    Keys.onEscapePressed: Qt.quit()
}
