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
    width: Screen.width
    height: Screen.height
    color: "black"

    ParticleSystem {
        anchors.fill: parent
        visible: true
        id: particles
        /*
        Emitter {
            group: "stars"
            emitRate: 800
            lifeSpan: 2400
            size: 24
            sizeVariation: 8
            anchors.fill: parent
        }
*/
        // ![0]
        ImageParticle {
            anchors.fill: parent
            //source: "qrc:///particleresources/fuzzydot.png"
            source: "fuzzydot.png"
            alpha: 0.5
            alphaVariation: 0.5
            entryEffect: ImageParticle.Scale
            rotationVelocity: 200
            opacityTable: "spark_opacity.png"
            color: "#FF8A10"
        }
        // ![0]

        Gravity {
            //system: sys
            magnitude: 800
            angle: 90
        }

        Emitter {
            //anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height + 60
            emitRate: 300
            lifeSpan: 1500
            lifeSpanVariation: 600
            size: 32
            sizeVariation: 16
            velocity: AngleDirection { angle: -90; angleVariation: 45; magnitude: 800; magnitudeVariation: 500 }
        }

        Turbulence {
            anchors.fill: parent
            strength: 4
        }

        /*
        Wander {
            affectedParameter: Wander.Position
            xVariance: 3200
            yVariance: 3200
        }
        */
    }

    Text {
        id: textCaption
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        color: "#4422FF"
        text: "Particle effects"
        font.pointSize: 60
    }
}
