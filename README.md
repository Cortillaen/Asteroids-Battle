# Asteroid Battle
A two-player competitive game based on the classic Asteroids written by Trenton Nale as a class project for CSC303 at MSU.
## Game Overview
After decades of blowing asteroids into progressively smaller chunks of rock, our plucky spaceship pilots realized they could be doing so much more... and decided to blow up each other, instead.  Since everyone uses the same blaster, creating shields to nullify each other's shots was trivial.  To get around this, a new type of blaster was developed that polarizes asteroids to a pilot's custom shield wavelength, allowing pilots to ram the polarized asteroids without harm and produce shrapnel deadly to anyone else.
Two factions coallesced from the following carnage, and now the Blue and Red alliances wage a pointless war amongst the asteroids they used to blast just as pointlessly.  Isn't life grand?

[Give it a try here!](https://cortillaen.github.io/Asteroids-Battle/)

![Screenshot](/docs/Demo.png?raw=true)
## Controls
* Player Blue controls his ship via W (forward thrust), A (rotate left), D (rotate right), S (brake), and LeftControl/Space (shoot).
* Player Red uses Home, Delete, PageDown, End, and the right Control.
## Tips
* Somebody finally figured out how to install spacebrakes on these ships, and they're pretty powerful.  It's about time.
* A maximum of five shots can exist in a battlefield at once, and firing a sixth will cause the oldest shot to destabilize and vanish, even if it was fired by the enemy.  Nobody really knows why this happens, but there's probably a lesson there about the connectedness and oneness of all things.  Too bad they're all too busy trying to kill each other to notice.
* Asteroids keep their color when they are broken apart, so shattering a few asteroids can make a much larger impact than just converting a few.
* Better yet, there's no limit to how many times asteroids can be shattered; the pieces just get smaller and faster each time, so fill the battlefield with high-velocity death (preferably of your color)!
## Running Offline
1. If you want to have an executable version of Asteroids Battle to play offline, first you'll need a friend to play with.  Or an enemy.  Or just some random person you grabbed.  I won't judge.
2. Next, make sure you have [Haxe](http://www.haxe.org/download) and [HaxeFlixel](http://www.haxeflixel.com) installed on your computer.  Make sure you also follow the instructions on setting up the lime command.
3. Now download this repository to your computer (use the "Clone or Download" button) and open a command prompt in the Asteroids-Battle folder.
3. Run the command "lime test neko" to build and run the game.
 * After the first run, an executable will be created in `\Asteroids-Battle\export\windows\neko\bin` that you can use instead of the command line.
## Future Plans
If I have time to do more work on this, here are some features I'd like to implement:
* User-configurable options for starting number of asteroids, number produced when shattered, max speeds, and other current constants.
* Power-ups like spread-shot and splinter-shot.
* Configurable gravity wells to alter the battlefield.
* A shield with limited (or slowly recharging) uses that can protect a player for a second or two.
## Contribution Guidelines
* Fork this repository using the button at the top-right of the page.
* Create a new branch from `master` and give it a descriptive name.
* Make your changes/additions and commit them to your branch as you go.
 * Descriptive commits at each step of your work will help me easily follow what you have done.
* When your branch is ready, come back here and open a pull request from your branch into `master`.
* As soon as I can, I'll check out your contribution and let you know if I have any questions or concerns.  Once everything is ironed out, you should see your branch merged in!
## Contacts
[@Cortillaen](https://github.com/Cortillaen) - Designer and programmer
