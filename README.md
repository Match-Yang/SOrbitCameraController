# SOrbitCameraController
A orbir camera controller for Qt3D(QML)

The Qt3D.Extras model provide a camera controller name with OrbitCameraController. But you can not specity which button of mouse for rotation or translation. So I make one. The default action is:

| Input                            | Action                                                       |
| -------------------------------- | ------------------------------------------------------------ |
| Left mouse button                | While the right mouse button is pressed, mouse movement along x-axis pans the camera around the camera view center and movement along y-axis tilts it around the camera view center. |
| Right mouse button               | While the right mouse button is pressed, mouse movement along x-axis pans the camera around the camera view center and movement along y-axis tilts it around the camera view center. |
| Both left and right mouse button | While both the left and the right mouse button are pressed, mouse movement along y-axis zooms the camera in and out without changing the view center. |

You can change the action by yourself ofcourse.

You can simply put the SOrbitCameraController.qml into you project and use it just like OrbitCameraController. Even the property is same as OrbitCameraController.

![screenshot_20181111_001729](https://user-images.githubusercontent.com/5242852/48303620-36d27100-e547-11e8-91ba-cf5aaf855efb.png)
