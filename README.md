# Web Server (ESP32)
A simple web server that runs on an ESP-32 microcontroller.

# Instructions
Follow the given instructions to deploy this server to your own ESP32 microcontroller.

For the examples, assume the port to be accessible at `/dev/ttyUSB0`.

## Installing Dependencies
Install all Python and Node dependenies locally and download the firmware.
```bash
make deps
```

## Firmware
Deploy the firmware.
```bash
make burn port=/dev/ttyUSB0
```

## Save the Script
Save the script to the microcontroller.

Assume the Wi-Fi SSID to be `mywifi` and the password to be `mypass`.
```bash
make port=/dev/ttyUSB0 ssid="mywifi" password="mypass"
```

You're done! You now have a HTTP server running on your microcontroller, accessible on the Wi-Fi network.

If you connect to the serial monitor, you'll be able to see the IP address at which the server is running.

# Made with ❤ by [Param](https://www.paramsid.com).