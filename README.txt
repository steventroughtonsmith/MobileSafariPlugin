PROJECT
MobileSafariPlugin

DESCRIPTION
This is a proof-of-concept project to show it's possible to create iPhoneOS Safari plugins. The code structure is pretty much exactly the same as a Safari plugin on the desktop except it uses UIView instead of NSView.

If you build and install this plugin, your browser will report itself Flash capable and show a red dummy view wherever you come across Flash content in any browser using the system WebKit.

NOTE
The final 3.2 GM SDK release broke the code I had cribbed from ClickToFlash, but I've left it in the project for reference and also so I can fix it later.

TO INSTALL
Project should build on any existing 3.x SDK without issue (I don't see any reasons it wouldn't work on 2.x either). To install, it must be codesigned and placed in the "/System/Library/Internet Plugins" directory of the device (or the corresponding directory in the iPhone Simulator if you're testing on the desktop)

LICENSE
Free-for-all. Go wild.