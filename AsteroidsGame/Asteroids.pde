class Asteroids
{
  PShape asteroid;
  PShape asteroid2;
  PShape asteroid3;
  PVector velocity;
  PVector direction;
  PVector position;
  float speed;
  ArrayList<PShape> allAsteroids;
  int number;
  int randomPositionX, randomPositionY;
  float scaleAsteroid;
  boolean getHit;
  boolean splitOnce;
  boolean hitTwise;
  
  Asteroids()
  {

    // Random position for the asteroids
    randomPositionX = (int)random(0, width/2 - 100);
    randomPositionY = (int)random(0, height/2 - 100);
      
    position = new PVector(randomPositionX,randomPositionY);
    velocity = new PVector(0,0);
    direction = new PVector(random(-1,1),random(-1,1));
    speed = 2;
    scaleAsteroid = 1.0;
    splitOnce = false; 
    hitTwise = false;
    
    //FirstAsteroid
    asteroid = createShape();
    asteroid.beginShape();
    asteroid.vertex(width/60, height/30);
    asteroid.vertex(width/40, height/70);
    asteroid.vertex(width/30, height/30);
    asteroid.vertex(width/24,height/70);
    asteroid.vertex(width/20,height/30);
    asteroid.vertex(width/24,height/25);
    asteroid.vertex(width/20, height/18);  
    asteroid.vertex(width/26, height/15);
    asteroid.vertex(width/40, height/14);
    asteroid.vertex(width/60, height/18);
    asteroid.endShape(CLOSE);  

   //SecondAsteroid
    asteroid2 = createShape();
    asteroid2.beginShape();
    asteroid2.vertex(width/60, height/30);
    asteroid2.vertex(width/40, height/70);
    asteroid2.vertex(width/30,height/30);
    asteroid2.vertex(width/20, height/70);
    asteroid2.vertex(width/18, height/30);
    asteroid2.vertex(width/20, height/25);
    asteroid2.vertex(width/18, height/18);
    asteroid2.vertex(width/20, height/13);
    asteroid2.vertex(width/30, height/15);
    asteroid2.vertex(width/35, height/13);
    asteroid2.vertex(width/60, height/18);
    asteroid2.vertex(width/45, height/25);
    asteroid2.endShape(CLOSE);

    // ThirdAsteroid  
    asteroid3 = createShape();
    asteroid3.beginShape();
    asteroid3.vertex(width/60, height/30);
    asteroid3.vertex(width/40, height/50);
    asteroid3.vertex(width/20, height/25);
    asteroid3.vertex(width/20, height/20); 
    asteroid3.vertex(width/25, height/18);
    asteroid3.vertex(width/20, height/15);
    asteroid3.vertex(width/23, height/13);
    asteroid3.vertex(width/25, height/15);
    asteroid3.vertex(width/35, height/13);
    asteroid3.vertex(width/80,height/25);
    asteroid3.endShape(CLOSE);

    // Add asteroids to the list
    allAsteroids = new ArrayList<PShape>();
    allAsteroids.add(asteroid);
    allAsteroids.add(asteroid2);
    allAsteroids.add(asteroid3);
    strokeWeight(2);
    
    // set for all asteroids stroke, weight and fill
    for(PShape aster : allAsteroids)
    {
      aster.setStroke(#FFFFFF);
      aster.setFill(0);
      aster.setStrokeWeight(3);
      
    }

   // get asteroid shape number
    number = (int)random(3);
  }
  
  // Updates position of the asteroid
  void updateAsteroidPosition()
  {
    velocity = PVector.mult(direction,speed);
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


//Display asteroid
  void displayAsteroid()
  {
  
      pushMatrix();
      translate(position.x, position.y);
      scale(scaleAsteroid);
      shape(allAsteroids.get(number));
      fill(128,128,128,128);
      strokeWeight(3);
      popMatrix();

  }
  
  

}
