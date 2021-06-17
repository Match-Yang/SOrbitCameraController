import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0

Entity{
    id: root
    property Camera camera;
    property real dt: 0.001
    property real linearSpeed: 1
    property real lookSpeed: 500
    property real zoomLimit: 0.16


    MouseDevice {
        id: mouseDevice
        sensitivity: 0.001 // Make it more smooth
    }
    KeyboardDevice {
        id: keyboardDevice
    }

    MouseHandler {
        id: mh
        readonly property vector3d upVect: Qt.vector3d(0, 1, 0)
        property point lastPos;
        property real pan;
        property real tilt;
        sourceDevice: mouseDevice

        onPanChanged: root.camera.panAboutViewCenter(pan, upVect);
        onTiltChanged: root.camera.tiltAboutViewCenter(tilt);

        onPressed: {
            lastPos = Qt.point(mouse.x, mouse.y);


        }
        onPositionChanged: {
            if(!root.enabled) return;

            // You can change the button as you like for rotation or translation
            if (mouse.buttons === 1){ // Left button for rotation
                pan = -(mouse.x - lastPos.x) * dt * lookSpeed;

                tilt = (mouse.y - lastPos.y) * dt * lookSpeed;

            } else if (mouse.buttons === 2) { // Right button for translate
                var rx = -(mouse.x - lastPos.x) * dt * linearSpeed;
                var ry = (mouse.y - lastPos.y) * dt * linearSpeed;

                camera.translate(Qt.vector3d(rx, ry, 0))
            } else if (mouse.buttons === 3) { // Left & Right button for zoom
                ry = (mouse.y - lastPos.y) * dt * linearSpeed
                zoom(ry)
            }

            lastPos = Qt.point(mouse.x, mouse.y)
        }
        onWheel: {
            if(!root.enabled) return;

            zoom(wheel.angleDelta.y * dt * linearSpeed)
        }


    }

    KeyboardHandler {
        id: keyboardHandler
        sourceDevice: keyboardDevice
        focus: true

        onPressed: {

            switch(event.key)
            {

            case Qt.Key_PageUp:
            {
                zoom(120 * dt * linearSpeed)

                break;

            }
            case Qt.Key_PageDown:
            {

                zoom(-120 * dt * linearSpeed)

                break;

            }


            case Qt.Key_Up:
            {
                upODown(100 * dt * linearSpeed)

                break;
            }


            case Qt.Key_Down:
            {
                upODown(-100 * dt * linearSpeed)

                break;
            }


            case Qt.Key_Left:
            {

                leftORight(-100 * dt * linearSpeed)

                break;

            }


            case Qt.Key_Right:
            {
                leftORight(100 * dt * linearSpeed)

                break;

            }


            }


        }

    }


    function zoom(rz) {
        if (rz > 0 && zoomDistance(camera.position, camera.viewCenter) < zoomLimit) {
            return
        }

        camera.translate(Qt.vector3d(0, 0, rz), Camera.DontTranslateViewCenter)
    }

    function zoomDistance(posFirst, posSecond) {
        return posSecond.minus(posFirst).length()
    }

    function leftORight(rx)
    {
        if (rx > 0 && zoomDistance(camera.position, camera.viewCenter) < zoomLimit) {
            return
        }
        camera.setUpVector(Qt.vector3d( 0.0, 1.0, 0.0 ))

        camera.translate(Qt.vector3d(rx, 0, 0))


    }

    function upODown(ry)
    {
        if (ry > 0 && zoomDistance(camera.position, camera.viewCenter) < zoomLimit) {
            return
        }
        camera.setUpVector(Qt.vector3d( 0.0, 1.0, 0.0 ))

        camera.translate(Qt.vector3d(0, ry, 0))

    }
}
