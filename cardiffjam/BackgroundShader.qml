// BackgroundShader.qml - A simple shader to create a real-time effect

import QtQuick 2.0

ShaderEffect {
    width: parent.width
    height: parent.height

    // Expose our defined width and height into the shader
    property real viewport_width: width
    property real viewport_height: height

    property real time: 0.0
    NumberAnimation on time { loops: Animation.Infinite; from: 0; to: 10; duration: 10000 }

    fragmentShader: "
#ifdef GL_ES
precision mediump float;
#endif

// Import the width/height properties from the component
uniform float viewport_width;
uniform float viewport_height;

// Import time
uniform float time;

vec2 resolution = vec2(viewport_width, viewport_height);

// ------- Below is the unmodified GLSL Sandbox code ----------

// Shader by Nicolas Robert [NRX]
// Ancestor of http://glsl.heroku.com/e#16679

#define PI 90

void main( void )
{
    vec2 p = ( gl_FragCoord.xy / resolution.xy ) - 0.2;

    float t = sin( p.x * p.x * p.y - 1. * time );
    float sx = 0.2 * (p.x + 0.2) * sin( p.x *  time + t * 10.0);
    float dy = 1./ ( 10. * abs(p.y - sx));

    dy += 1./ (40. * length(p - vec2(p.x, 0.)));

    gl_FragColor = vec4( (p.x + 1.2) * dy, dy, 0.23 * dy, 1.0 );
}
    "
}

