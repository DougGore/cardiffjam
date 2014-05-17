// This is a demo of particle effects in Qt5, my original aim was to try and
// recreate one of the classic Odeon cinema idents as seen here:
// http://vimeo.com/59739036#t=30s

// The original ident was of steel being cut hence all the subtle motion, etc.
// This demo tries to get some of the feel of original.

import QtQuick 2.0
import QtQuick.Particles 2.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: background
    width: Screen.width
    height: Screen.height
    color: "black"

    ParticleSystem {
        anchors.fill: parent
        visible: true
        id: particles

        //
        ImageParticle {
            anchors.fill: parent

            // Source image Qt 5.2 has built in ones but for
            //source: "qrc:///particleresources/fuzzydot.png"
            source: "fuzzydot.png"

            // Varying the level of transparency of the sparks
            alpha: 0.5
            alphaVariation: 0.4

            // We want our sparks to grow as they appar
            entryEffect: ImageParticle.Scale

            // Put some spin on them
            rotationVelocity: 200

            // We use a 1D (1px high) image to make the appearance
            // non-linear
            opacityTable: "spark_opacity.png"

            // Make the sparks orange
            color: "#FF8A10"
        }

        // Apply some gravity so the sparks will start to fall
        Gravity {
            angle: 90
            magnitude: 800
        }

        // The emitter is where we fire the particles from
        Emitter {
            // Put the emitter central and push it slightly off the bottom of the screen
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height + 60

            // Emit 300 particles per second
            emitRate: 300

            // Our particles wil live for 1500ms +/- 600ms
            lifeSpan: 1500
            lifeSpanVariation: 600

            // Size will be 32px +/- 16px
            size: 32
            sizeVariation: 16


            velocity: AngleDirection {
                // Make angle point straight up (0 is righgt)
                angle: -90;

                // Vary that angle +/- 45 degrees to give us a nice arc
                angleVariation: 45;

                // Magnitude in pixels/second, using the screen height as a reference
                magnitude: background.height * 1.05
                magnitudeVariation: background.height * 0.6
            }
        }

        Turbulence {
            anchors.fill: parent
            strength: 4
        }
    }

    // Put a title at the top
    Text {
        id: textCaption
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        color: "#4422FF"
        text: "Particle effects"
        font.pointSize: 60
    }
}
