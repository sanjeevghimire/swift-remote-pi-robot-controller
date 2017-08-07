# swift-remote-pi-robot-controller
A Remote for a Robot powered by Raspberry PI and using server-side Kitura as a middle ware.

 ![Remote Robot Demo](https://github.com/sanjeevghimire/swift-remote-pi-robot-controller/blob/master/assets/RobotRemoteControlWithKitura.png "Remote Robot Demo")

# Full Stack Development using IBM Kitura
We will be creating a Remote for a Robot powered by Raspberry PI and using server-side Kitura as a middle ware. The Robot will also be integrated with Watson Text-To-Speech services. The remote will be able to control the robot for two things:
* Enter a text for the robot to speak out
* Choose a color for the robot to blink

# Architecture

 ![Remote Robot Demo Architecture](https://github.com/sanjeevghimire/swift-remote-pi-robot-controller/blob/master/assets/robot-remote-control-architecture.png "Remote Robot Demo Architecture")

The remote is built using swift and runs on iOS devices.The Robot Remote Control app communicates with Kitura based server using REST APIs that are exposed. The server has CRUD APIs as well as an API which takes the remote input and send it to the IBM IoT platform. The API on the server receives the JSON data from the remote app and publishes as a MQTT messages to the IoT platform. The server uses Aphid MQTT client to publish messages to the IBM IoT platform to a topic. The robot is built using raspberry-PI. The LED and the speaker are connected to the raspberry-PI. The PI runs a nodejs application that is listening for a MQTT messages from the IoT platform in the same topic where the Kitura based server publishes the messages. Once it receives the MQTT messages, the text received is converted to speech using Watson developer cloud SDK and pipes it to the speaker that was installed in raspberry-PI. The raspberry PI also runs a Python code to send the right color signal to the led so that it blinks.

# Steps to Run Remote UI Client and Remote Robot Server

1. Open Remote-Robot in Xcode
2. Replace /sources/Remote-Robot/Credentials.swift with IBM IoT platform credentials
3. Build and Run and access server using url: http://localhost:8080
4. Open Remote-UI in Xcode
5. Build and Run using Xcode

# Steps to Create Robot and Run RobotPI

Creating Raspberry-PI powered Robot

We will be creating a Robot that can talk and blink the LED attached to it. This robot is powered by Raspberry-PI. For this we need
* Bluetooth speaker or speaker with audio jack connected via (https://www.adafruit.com/product/1475)
* NeoPixel Diffused 8mm Through-Hole LED - 5 Pack (https://www.adafruit.com/product/1734)
For installing and configuring please see the following instruction where it was configured for tjBOt https://github.com/ibmtjbot/tjbot

1. Go to RobotPI folder
2. Replace IBM Watson Text-To-Speech with the credentials and IoT platform Credentials in Credentials.js
3. Run node index.js
4. Now you can use the Remote-UI to send LED color and text for the robot.





