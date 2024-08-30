# OpenComputers-Time
A script for use in Minecraft mod Open Computers to display local date and time.

**How it Works**

  Code starts with a GET request to a world time API with my time zone (e.g. https://worldtimeapi.org/api/timezone/America/Los_Angeles).

  With a successful request, the datetime that is in ISO8601 format is converted to be readable.

  The formatting of the time may be fixed for UTC

  Formatted date and time is: month day, year  hour:minute:second AM/PM. An example is August 28, 2024  3:54:32 PM.

  A separate function uses the formatted time and displays it on the OpenComputers Screen.

  An infinite while loop runs the prior code, updating the time every second.
