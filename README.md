# Planetary System Simulation

A dynamic configurable planetary system fed by asset settings.json.

## Parameter

The simulation may be influenced by parameters:</BR>

    * windowSize: 1000: Size of Canvas
    * centerX: 500: Usually in the middle of thee canvas
    * centerY: 500: Usually in the middle of the canvas
    * font: "comicsans": Font family being used when text is shown
    * fontSize: 16: This text' size
    * astronomicalUnit: 149600000000000: in m
    * gravityConstant (G): 6.67428e-11 in m^3 kg^−1 s^−2
    * scaleFactor: 60: For calculation to normalize positioning of objects in canvas
    * updatePeriod: 1000: Render frequency in ms
    * timeStep: 86400: Step size to render (default: 1 Earth day)
    * backgroundColor": "#000000": Self-speaking

## Central Star

Assuming a single mass in the middle of the planetary system.
Defined by following characteristics:</BR>

<ul>
        <li> name: "Sun": Self-speaking
        <li> mass: 1989100 Normalized factor basing upon 10^24 kg
        <li> color: "#fffff6": Self-speaking
        <li> diameter: 1392000000: in m
        <li> centerX: Usually 0, but for misplacing the central mass a good start
        <li> centerY: Usually 0, but for misplacing the central mass a good start

## Planets

List of objects circling the central star with following characteristics for each:</BR>

<ul>
        <li> name: Self-speaking
        <li> mass: Normalized factor basing upon 10^24 kg
        <li> color: "#\<red in hex\>\<green in hex\>\<blue in hex\>" Self-speaking
        <li>diameter: in m
        <li>distance: as factor in AU (resulting in m)
        <li>velocityX: 0: Not used yet
        <li>velocityY: Circling speed in m/s