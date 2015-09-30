import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


// Audio Player
Minim minim;
AudioPlayer player1;
AudioPlayer player2;
AudioPlayer player3;
AudioPlayer player4;

// Font
PFont font;
PFont font2;

Menu gameMenu;
Ship battleShip;
Asteroids aster;
Bullet strike;

boolean turnRight = false;
boolean turnLeft = false;
boolean accelerate = false;
boolean temp;

ArrayList<Asteroids> asteroidsList;
ArrayList<Bullet> bulletList;

int bulletsCount;
int gameScore;
int sumRadiusBulletAndAsteroid;
int volume;
int controlVolume;

void setup()
{
  
 size(displayWidth,displayHeight, P2D); // set to a full screen
  gameMenu = new Menu();
  battleShip = new Ship();
  aster = new Asteroids();
  strike = new Bullet();
  volume = -30;
  
  // Load Sounds
  minim = new Minim(this);
  player1 = minim.loadFile("Escape.mp3");
  player2 = minim.loadFile("Self-Destruct-Sequence.mp3");
  player3 = minim.loadFile("Laser.mp3");
  player4 = minim.loadFile("Blast.mp3");
  
  //Load Fonts
  font = loadFont("Jokerman-Regular-32.vlw");
  font2 = loadFont("OCRAStd-48.vlw");
  
  
  controlVolume = 5; // Volume Control
  
  gameScore = 0; // Game Score
  
  asteroidsList = new ArrayList<Asteroids>();
  bulletList = new ArrayList<Bullet>();
  
  //Fill ArrayList with bullets
  for(int b = 0; b < 5; b++)
  {
    Bullet createBullet = new Bullet();
    bulletList.add(createBullet);
  }
  
  //Fill AsteroidsList with asteroids
  for(int i = 0; i < 5; i++)
  {
    Asteroids as = new Asteroids();
    asteroidsList.add(as);
  }
  
  
  bulletsCount = 0; // set bullet count to 0
  temp = false;

  sumRadiusBulletAndAsteroid = 3 + ((width/25) / 2); // sum of the radius between asteroid and bullet
}


void draw()
{
  // Draw Main menu
  if(gameMenu.StateMode() == 0)
  {
    player1.play();
   gameMenu.display();
   gameMenu.mouseOverButtons();

  }
  
  // Draw Game itself
   if(gameMenu.StateMode() == 1)
   {
     // Pause main menu song and play in game song
    player1.pause();
    player2.play();
    
    background(0);
     
     // Draw Score
     textFont(font2,width/30);
     textAlign(CENTER);
     text("Score: " + gameScore, width/2, height/20);
     
     // Check for collision between asteroids and ship
     for(int i = 0; i < asteroidsList.size(); i++)
     {
       battleShip.detectCollisionShip(asteroidsList.get(i));
       
   
     }
    
    // update ship positioon and display
      battleShip.updatePositionOfTheShip();
      battleShip.displayShip();
     

     // update Asteroids position and display
     for(Asteroids getAsteroid : asteroidsList)
     {
       getAsteroid.updateAsteroidPosition();
       getAsteroid.displayAsteroid();
     }
     
 
     // checks collision between bullets and asteroids. if asteroid hit once and if it wasn't split before
     //scale this asteroid to the half of the size and create one more asteroid. Add to the list
      for(Bullet strikes : bulletList)
      {
         for(int y = 0; y < asteroidsList.size(); y++)
        {
          strikes.detectCollision(asteroidsList.get(y));
          if(asteroidsList.get(y).getHit == true)
          {
            if(asteroidsList.get(y).splitOnce == false)
            {
              asteroidsList.get(y).scaleAsteroid = 0.5;
              Asteroids tempAster = new Asteroids();
              tempAster.position = asteroidsList.get(y).position.get();
              tempAster.direction = asteroidsList.get(y).direction.get();
              tempAster.direction.rotate(-45);
              tempAster.scaleAsteroid = 0.5;
              tempAster.splitOnce = true;
              asteroidsList.add(tempAster);
              asteroidsList.get(y).splitOnce = true;
              break;
            }
          }
        }
        // Update bullet position and display
        strikes.updateBulletPosition();
        strikes.displayBullet(battleShip);  
      }
    
    //remove asteroids that were hit twice
     for(int t = 0; t < asteroidsList.size(); t++)
      {
         if(asteroidsList.get(t).hitTwise == true)
         {
            asteroidsList.remove(t);
         } 
         
      }

     //If all asteroids are gone, you won the game. Display.
      if(asteroidsList.size() == 0)
      {
        textFont(font,width/30);
        textAlign(CENTER);
        text("YOU WON ! Congratulations!", width/2,height/2);
      }
     }
     
     // Options State. Draws volume control panel.
    if(gameMenu.StateMode() == 2)
    {
      background(0);
      stroke(255);
      strokeWeight(5);
 
      rectMode(CENTER);
      fill(152,178,191);
      rect(width/2,height/2, width/4, height/2);
      fill(0);
      textFont(font2,width/30);
      textAlign(CENTER);
      text("Volume", width/2,height/3);
      fill(63,170,222);
      rect(width/2,height/2 - (height/12), width/6, height/11);
      rect(width/2, height/2 + height/12, width/6, height/11 );
      noStroke();
      fill(11,224,112);
      rect(width/2 - width/20, height/2 - (height/12), width/30, height/20);
      rect(width/2 + width/20, height/2 - (height/12), width/30, height/20);
      fill(0);
      text("BACK", width/2, height/2 + height/9.5);
      textFont(font2,width/50);
      text(controlVolume, width/2, height/2 - (height/14));
      fill(0);
      textFont(font2,width/20);
      text("+", width/2 + width/20, height/2 - height/20);
      text("-", width/2 - width/20, height/2 - height/20);

    }
     
     //Exit State. Exit application
    if(gameMenu.StateMode() == 3)
    {
      exit();
    }
}

//Used to display full screen
boolean sketchFullScreen()
{
  return true;
}


  void keyPressed()
  {
    
    switch(keyCode){
      case RIGHT:
        turnRight = true;
        break;
      case LEFT:
        turnLeft = true;
        break;
      case UP:
        accelerate = true;
        break;
    }
    // if space is pressed check for holding space. If spacebar was pressed, then check is ship is still alive
    // check number of bullets. If you still have bullets, set their position and fire.
    if(key == ' ')
    {
      
      if(temp == false)
      {
        if(battleShip.isAlive == true)
        {
            if(bulletsCount <= 3)
            {
                if(bulletList.get(bulletsCount).fired == false)
               {
                player3.play();
                player3.loop();
                player3.pause();
                player3.play();
                bulletList.get(bulletsCount).setBullet(battleShip.direction.get(),battleShip.position.get());
                bulletList.get(bulletsCount).fired = true;
                bulletsCount++;
              }
            }
            else
            {
              bulletsCount = 0;
            }
        }
      }
        temp = true;
    }
 
  }
  
  void keyReleased()
  {       
      temp = false;
      switch(keyCode){
      case RIGHT:
        turnRight = false;
        break;
      case LEFT:
        turnLeft = false;
      case UP:
        accelerate = false;
        break;
      }
  }
  
void mousePressed()
{
  // Check for decreasing volume button
  if(mouseX > (width/2 - width/15) && mouseX < (width/2 - width/30)
  && mouseY > (height/2 - height/9) && mouseY < height/2 - height/20)
  {
    if(controlVolume > 0)
    {
      volume -= 10;
    player1.setGain(volume);
    player2.setGain(volume);
    player3.setGain(volume);
    player4.setGain(volume);
    controlVolume -= 1;
      
    }

  }

 // check for increasing volume button
  if(mouseX > (width/2 + width/35) && mouseX < (width/2 + width/15)
  && mouseY > (height/2 - height/9) && mouseY < height/2 - height/20)
  {
    if(volume <= 10)
    {
      volume += 10;
      player1.setGain(volume);
      player2.setGain(volume);
      player3.setGain(volume);
      player4.setGain(volume);
      controlVolume += 1;

    }
  }
  // Return back button. Returns to the main screen
  if(mouseX > width/2 - width/12 && mouseX < (width/2 + width/12)
  && mouseY > height/2 + height/26 && mouseY < height/2 + height/8)
  {

    if(gameMenu.state == 2)
    {
       gameMenu.state = 0;
    }
    
  }
}

