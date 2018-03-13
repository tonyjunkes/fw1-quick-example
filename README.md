# FW/1 & Quick Example
An example of using Quick as a Subsystem in an FW/1 application.

### How to use:

- Make sure you have [Commandbox installed](https://commandbox.ortusbooks.com/content/setup/installation.html).
- Clone the repo or drop the zipped contents into a directory.
- Fire up Commandbox by entering `box` in your terminal and `cd` into the project root directory.
- Run `install && start`.
- Start hacking away!

No database required! - The example application uses an H2 database that is defined in Application.cfc. _See below._

> NOTE: This example application is currently set up to support Lucee 5+. If you choose to use Lucee 5, you will need to install the H2 extention from the admin. For Adobe ColdFusion to, you will need to either implement the setup for an H2 database yourself or use a different database all together.