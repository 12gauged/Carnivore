

## Player

- Able to pick up Throwables
	Walk over them to collect them;
	Can only hold one at a time;

- Can pick different Power-Ups inside the level
	A screen will appear every 5 waves asking the player to select a Power-Up;
	The screen will offer 2 different Power-Ups in different areas, like a Power-Up that increases health(stat increase) or one that gives you a special ability;


## Throwables

- Different projectiles that can be collected by the player
	Stone;
	Spear;
	Fireball


## Enemies

- Must always have PREDICTABLE STATES
	Example: Ant
	1. Walk;
	2. Dig for stone;
	3. Hold stone;
	4. Throw stone;
	5. Repeat.

- Enemy Classes
	1. Light
		Enemies that don't have much health, are easy to kill. Must never have a super Complicated Attack(like jumping, fire explosion, etc.), as these are the "fodder" enemies, they are meant to be easy to kill.
	1. Soldier
		The "medium" enemy class, tougher than the light enemies, these should hit harder than the light enemies, but should also stay away from Complicated Attacks
	2. Heavy
		The big bois. They must be able to change the arena, make the player think about their next move, and completely take the spotlight from any other enemy in the combat zone.
		Their attacks must always be Complicated, forcing the player to work around them to eliminate the enemy



