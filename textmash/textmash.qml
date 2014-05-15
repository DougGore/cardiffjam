// TextMash

// TextMash is a simple interactive program that displays characters that you
// type on the keyboard at random locations then slowly fades them out. This
// was inspired by "baby smash!" (http://www.hanselman.com/babysmash/) to
// create something fun for my children.

import QtQuick 2.0
import QtQuick.Window 2.0

import "textmash.js" as TM

// This rectangle will be our application view
Rectangle {
    id: textmashWindow

    // Make it the width and height of the screen (you have to import
    // QtQuick.Window to use Screen
    width: Screen.width
    height: Screen.height

    color: "white"

    focus: true

    // Whenever a key is pressed run this JavaScript in our imported code
    Keys.onPressed: TM.generateTextObject(event.key)
}
