class Bullet
{
    PVector position;
    PVector velocity;
    PVector direction;
    float speed;
    boolean fired;
    int timer;
    boolean hit;
    float distance;
    int radiusForCollisiton;
  
    Bullet()
    {
      position = new PVector(width/2,height/2);
      velocity = new PVector(0,0);
      direction = new PVector(0,0);
      speed = 10;
      fired = false;
      distance = 0;
      radiusForCollisiton = 3 + ((width/25) / 2);
      hit = false;
    }
    
    // Update Bullet Position
    void updateBulletPosition()
    {
      velocity = PVector.mult(direction, speed);
      position.add(velocity);
        
      if(position.x > width)
      {
        position.x = 0;
      }
      if(position.x < 0)
      {
        position.x = width;
      }
      if(position.y > height)
      {
        position.y = 0;
      }
      if(position.y < 0)
      {
        position.y = height;
      }
    }


   // Display Bullet
    void displayBullet(Ship battle)
    {
         fill(255);
         
       // Check if ship is still alive and if bullet was fired. Then display the bullet
       if(battle.isAlive == true)
       {
        if(fired == true)
        {
          ellipse(position.x, position.y ,3,3);
          timer++;
          
          //bullet reset.
          if(timer % 90 == 0)
          {
            fired = false;
          }
        }
       }
    }


  // Sets bullets position.
    void setBullet(PVector bulletDirection, PVector bulletPosition)
    {
        position = bulletPosition;
        direction = bulletDirection;
      
    }
    
    
  // Detects collision between bullet and asteroid 
  void detectCollision(Asteroids asteroid)
  {
    float x = asteroid.position.x;
    float y = asteroid.position.y;
    PVector compare = new PVector(x,y); 
    distance = PVector.dist(compare, position);
    if(distance < radiusForCollisiton && fired == true)
    {
      //if collide set bullet to active again. set asteroid being hit to true. add score  and check if asteroid was hit previously.
      fired = false;
      asteroid.getHit = true;
        gameScore += 100;
        println(gameScore);
      if(asteroid.splitOnce == true)
      {
        asteroid.hitTwise = true;
      }
    }

  }
}
