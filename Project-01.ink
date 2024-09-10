/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

VAR time = -1 //  0 Early Evening, 1 Late Evening, 2 Past Midnight, 3 Witching Hour

VAR seashell = 0
VAR tranquility =0
VAR crown =0

-> beach_shore

== beach_shore ==
You stand at the waters edge, gazing into the near infinite sea. You hear what sounds like a sweet melody, calling to you from the stars reflecting in the water. Behind you lies a dark cave, cold and unfeeling.
It is {advance_time()}
{tranquility == 0: You don't yet feel at peace} 
{tranquility > 0: You're a little at peace, maybe you need more tranquility}
Your tranquility is at {tranquility}

*[Listen to the song.] 
     ~tranquility = tranquility +1
    ->listen_beach
*[Head for the cave.] ->dark_cave
*[Wade out into the waves.] ->wade_waters
*[Look around the shore.] -> gazing_shore
*{time ==3} [Lay in the sand] ->lay_sand
*[Stroll down the beach] -> further_beach
 
 
==gazing_shore==
The sand all around you glistens like tiny stars in the night sky. Many seashells dot the shore, like galaxies in the distance.
    ~tranquility = tranquility + 1
Your tranquility is now at {tranquility}

*[Gaze back out to the sea.] ->beach_shore
*{seashell < 1}[Pick up a seashell.] ->seashell_pickup 

==dark_cave==
{darkest_cave: You escaped, yet you are right back where you started.}The cave you now stand in is dark, cold, and unfeeling. A single point of light exists at the end of the tunnel. You feel as though just standing here is enough to make your skin crawl. You can hear your heatbeat, pulsating through your chest. Fear. Yet, perhaps this is your only option to make a choice that is your own.
*[Head deeper into the darkness.] ->darkest_cave
*[Head to the light] -> deep_cave
*[Turn back.] ->beach_shore

==deep_cave==
{tranquility > 1: You begin heading home.} You feel the rush of wind against your face. You stand at the edge of a cliff, staring into the great beyond. You're back home. It almost feels as though you never left. {tranquility == 1: Though something is missing, you can't quite figure out what.} Your father calls for you, worried since you went missing.
"Welcome back," he says with a smile. {tranquility ==0:"Tell me, did you find what you were looking for?"}
{tranquility >=2 <= 4: You made it home, you feel happy, a smile still planted on your face. {listen_beach:The song still radiating in your soul. Making the whole world seem brighter.} } 
{tranquility == 2: "Welcome home," your father says, a smile on his face. "You look happy today! Let's head home, your mother is worried. You can tell us about your adventure when we get back."} 
{tranquility >= 5: You feel almost scared. The pull of the ocean almost took you away. Perhaps you should never return.}

You have {seashell} seashells

{seashell > 0: "Hey, that's a beautiful shell you have there. I'm sure you mother would love it."}

You have {crown} coral crown

{crown > 0: "Oh... I remember that crown. I'm sorry about what happened. Perhaps...we can display it at home."}

*{seashell > 0} [Give the seashell as a present for your mother.]->seashell_gift
*[Go home] ->END

==darkest_cave==
You now stand in almost complete darkness. Slight fear and panic begin to settle in. You are trapped. The silence stabbing into your ears and the century old air burns your lungs.
*{tranquility >= 2}[Try to escape] ->dark_cave
*{tranquility < 2} [Try to escape] -> cave_abyss
*[Accept, go deeper] -> cave_abyss

==cave_abyss==
You have utterly lost yourself in a dark void. One without light and without hope. You can't even hear the allure of the Ocean's Song anymore. You have totally vanished from this world. No desire...and no sense of self.
{tranquility >= 2: Perhaps this was the answer you searched for. To completly dissapear from this world in both body and soul.}
->END

==listen_beach==
You stand there, listening to the song. It makes you feel...at peace. That your worries can finally dissapear. The answers to that question burning deep within your heart, may finally be understood. All you must do, is head forward and never look back. {not seashell_pickup: Though the beautiful shell on the ground may make you feel better.}

{tranquility == 1: you feel more at peace, but something is still missing}
your tranquility is now {tranquility}

You have {seashell} seashells

*[Sprint for the cave.] ->sprint_cave
*[Wade out into the waves.] ->wade_waters
*[Gaze back out to the sea] ->beach_shore
*{seashell < 1}[Pick up the seashell.] ->seashell_pickup 

==seashell_pickup==
    ~seashell = seashell + 1
You now have a seashell, perhaps your mother would like it.

you have {seashell} seashell
-> beach_shore

==sprint_cave==
You ran, trying to break free from the calling sea. You're out of breath, gasping for air. The air tastes old, stale, and damp.{seashell == 1: You must have dropped the shell during your sprint.} {tranquility > 3: You must have ran straight into the cave.}You know that if you head back now, your father should be waiting with open arms.

    ~seashell = 0
you have {seashell} seashells

*[Head home.] ->deep_cave
*[Go deeper into the darkness.] -> darkest_cave
*[Go back to the water.] ->beach_shore

==wade_waters==
{not melody_ponder:You wade out, feeling the cold water rush around you. It makes you feel alive. You feel, happy.} 
    ~tranquility = tranquility + 1
{melody_ponder: You return to the cold waters, gazing into an abyss.}
{listen_beach:You feel at peace. Listening to the song of the waves.}

your tranquility is now at {tranquility}

*[Go deeper.] ->deep_waves
*{listen_beach}[Consider the melody] -> melody_ponder
*[Head home.] -> deep_cave

==melody_ponder==
You condsider the song of the waves. It's captivating, yet utterly alien to you. It makes you feel both understood and at home.
    ~tranquility = tranquility +1
your tranquility is now at {tranquility}
-> wade_waters

==seashell_gift==
You gave the seashell to your mother when you got home. She noticed how happy you seemed from your day and acepted the seashell with a smile that matched yours.
{crown > 0: You notice a slight look of sadness in your mother's eye as she sees the coral crown. Yet the memory eludes you, what is the significance of this crown.}
{tranquility > 1: Perhaps this is the meaning in your life you have been searching for. The happiness and joy of those you love.}
-> END

==deep_waves==
You feel ensared by the song of the waves. You feel at peace, yet you desire more. You need to go deeper.
    ~tranquility = tranquility + 2
your tranquility is now at {tranquility}
*[Go even deeper.]
    ~ tranquility = tranquility + 6
    ->deeper_waves
*{tranquility < 6} [Resist the pull, run away] -> sprint_cave
*{crown > 0} [Clutch the crown tight, try to remember.] -> remember_crown

==remember_crown==
You hold tightly to the crown, trying desperatly to remember what happened. Yet... you can't seem to remember it. Maybe...you will never understand.
    ~tranquility = tranquility - 2
->deep_waves

==deeper_waves==
You feel as though you are floating in an infinite void. You feel good, you feel happy. Almost as though nothing matters at all. Almost as though you no longer exist.
{tranquility > 9: You feel more at peace than ever before. Perhaps this was the meaning in your life you longed for. Your own peace and enjoyment.}
your tranquility is at {tranquility}
-> END

==lay_sand==
You lay there in the sand, staring up into the night sky. The world feels so vast, almost like it never ends. You consider your life, your mother's homemade cooking and your father's overly positive attitude. You've always wondered what was at the end of the sky, and you think that maybe that is what you want to do when you grow up. Search the vast sea of stars for you.rself.
* [Head Home] -> deep_cave
* [Stay] -> stay_sand
* [Wear the crown once again] ->crown_sands

==crown_sands==
You place the crown once again on your head, it feels right. It is both comforting to wear this again and uncomfortable, given your reason for coming here. It was a year ago...you can't remember what took place...but you know this is the one year anniversary. You feel tears forming in your eyes, a deep sadness fills your heart...a longing for something...or someone. You're not sure if it's a good idea to stay here anymore.
*[...Return home.] ->crown_home

==crown_home==
You make your way home, the tears pouring from your eyes without control. Your father notices your return, offering a warm embrace in solace.
"I'll have your mother meet us at the tree, let's go visit them," he says, a hint of sadness in his voice.

You and your father make your way to an old tree...one you used to call the Tree on the Hill. Your mother soon joins you, placing her hand on your shoulder.
*{seashell > 0} [Offer the seashell to your mother] -> seashell_gift2
*[Step forward] ->tree_on_the_hill

==seashell_gift2==
Your mother accepts the seashell with tears in her eyes, though she fakes a smile for you. She looks back to the tree, a look that invites you to take a step forward.
*[Reach out for the tree] -> tree_on_the_hill

==tree_on_the_hill ==
You step forward towards the tree. The sadness turns slowly into hope. You know that this is all you can offer. You place the coral crown atop the gravestone...remembering what they meant to you. You can't be sure if this is truly the life you wished for...but, it's the life you have.
Perhaps...this was the answer you longed for all this time. The answer to the meaning of life. The truth scares you, but at the same time, gives you peace. Life inherently has no meaning. The purpose of our lives is to find something so meaningful, that we wish to call it our entire reason for living. So that in the end, we can take pride in how we met them.
-> END


==stay_sand==
You remain, almost joining the shells and grains of sand. A small dot in the vast expanse of the universe. You wonder, if you will ever learn how to leave this place. This place at the end of your sky.
{tranquility >= 2: Perhaps this was the meaning in your life you have been searching for. To lose yourself completly in the reality of our Universe.}
->END

== further_beach ==
You stroll down the beach, taking in the salty breeze. You're reminded of your last visit to the beach. You remember your childhood friend, it was around here where the two of you made a sand castle years ago. If you remember right, there should be a small cove nearby where you two stached a secret treasure.
    ~tranquility = tranquility + 1

*[Head back to main shore] ->beach_shore
*[Look for the cove] -> secret_cove

== secret_cove ==
You look around, trying to remember where that cove was. You see an odd piece of coral, sticking out from the ground. You rememeber placing it there long ago so that you may find your way. You press onward, finding the path you once took. You now stand in a small cove, from here the moon seems to beam directly onto the sand you stand on, illuminating your soul.
    ~tranquility = tranquility + 1
* [Return to the shores] -> beach_shore
* [Search for the treasure] -> crown_pickup

== secret_treasure ==
You look around, reminiscing. You find a small box tucked away behind a rock. The box has a crescent moon depicted on it. You open up the box, finding a crown made of coral within. 
*[Take the crown] -> crown_pickup
*[Leave it here for someone else] -> leave_crown

==leave_crown==
You left the crown where you found it, hoping your message will reach them. You decide to head back to the shore where you started this trip.
->beach_shore

==crown_pickup==
You decide to take the crown with you, hoping it will bless you with fortune on your travels. You decide to head back to the shores where you stared, a new purpose burning wihtin your heart.
    ~crown = crown + 1
You now have {crown} coral crown

->beach_shore

== function advance_time ==

    ~ time = time + 1
    
    {
        - time > 3:
            ~ time = 0
    }    
    
    {    
        - time == 0:
            ~ return "Early in the Evening"
        
        - time == 1:
            ~ return "Late in the Evening"
        
        - time == 2:
            ~ return "Past Midnight"
            
        -time == 3:
            ~return "The Witching Hour"
    
    }
    
    
        
    ~ return time
    
    