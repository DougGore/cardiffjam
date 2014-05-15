// textmash.js - These are our JavaScript functions for our application

// Create an object dynamically and give it the character of the key presed
function generateTextObject(key) {
    var charComponent;
    var charObj;

    charComponent = Qt.createComponent("char.qml");

    if (charComponent === null) {
        console.log("Error creating dynamic component");
        return;
    }

    charObj = charComponent.createObject(textmashWindow);

    if (charObj === null) {
        console.log("Error creating object");
        return;
    }

    // Create a string from the character code of the key we pressed, e.g.
    // 120 would become "x"
    charObj.text = String.fromCharCode(key);
}
