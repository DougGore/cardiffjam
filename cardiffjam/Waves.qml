// Waves.qml - A simple shader to create a neon wavy glow

import QtQuick 2.0

ShaderEffect {
    id: shader

    // Default width and height (component creator can override)
    width: 400
    height: 300

    // Expose our defined width and height into the shader
    property real viewport_width: width
    property real viewport_height: height

    // Expose a time input into the shader
    property real iGlobalTime: 0
    //NumberAnimation on iGlobalTime { loops: Animation.Infinite; from: 0; to: Math.PI * 2; duration: 6914 }
    NumberAnimation on iGlobalTime { loops: Animation.Infinite; from: 0; to: Math.PI * 2; duration: 6914/4 }
     
    fragmentShader: "
// Based off Waves by bonniem (https://www.shadertoy.com/view/4dsGzH)
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

#ifdef GL_ES
precision mediump float;
#endif

// Import the width/height properties from the component
uniform float viewport_width;
uniform float viewport_height;

// Convert the viewport width/height to be Shadertoy compatible
vec3 iResolution = vec3(viewport_width, viewport_height, 0.0);

uniform float iGlobalTime;

// ------- Below is the unmodified Shadertoy code ----------

//vec3 COLOR1 = vec3(0.0, 0.0, 0.3);
//vec3 COLOR2 = vec3(0.5, 0.0, 0.0);
//float BLOCK_WIDTH = 0.01;

void main(void)
{
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    
    // To create the BG pattern
    vec4 wave_color = vec4(0.0);
    
    // To create the waves
    float wave_width = 0.1;
    uv  = -1.0 + 2.0 * uv;
    //uv.y += 0.35;

    for(float i = 0.0; i < 3.0; i++)
    {
        
        uv.y += (0.1 * sin(uv.x + i / 7.0 + iGlobalTime ));
        wave_width = abs(1.0 / (100.0 * uv.y));
        //wave_color += vec4(wave_width * 1.0, wave_width, wave_width * 1.9, wave_width * 2.0);
        wave_color += vec4(wave_width * (5.0 - i), wave_width, wave_width * i, 1.0);
    }
    
    gl_FragColor = wave_color;
}
    "
}
