class Ship
{
  PVector position;
  PVector velocity;
  PVector direction;
  float speed;
  float maxSpeed;
  float friction;
  PShape ship;
  PShape accelerationShape;
  int radiusForCollisiton;
  float distance;
  boolean collisionDetected; 
  boolean isAlive;
  PFont font;
  PImage boomImage;
  int timer;
  
  
  Ship()
  {
    position = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    direction = new PVector(0,0);
    PVector.fromAngle(radians(-90),direction);
    speed = 0;
    maxSpeed = speed + 6;
    friction = 0.99;
    radiusForCollisiton = ((width/30) / 2) + ((width/25) / 2); // radius sum asteroid + ship
    distance = 0;
    collisionDetected = false;
    isAlive = true;
    timer = 0;
    
   boomImage = loadImage("Boom.png");
   font = loadFont("Jokerman-Regular-32.vlw");
   
   // Draw Ship
   ship = createShape();
   ship.beginShape();
   ship.vertex(0,0);
   ship.vertex(0 + height/30, 0 + width/95);
   ship.vertex(0, ((width/95)*2));
   ship.vertex(0 + height/70, 0 + width/95);
   ship.endShape(CLOSE);
   
   //Draw acceleration Shape
   accelerationShape = createShape();
   accelerationShape.beginShape();
   accelerationShape.vertex(0,0);
   accelerationShape.vertex(0 - width/75, height/110);
   accelerationShape.vertex(0, height/70);
   accelerationShape.endShape(CLOSE);
   
  }

//Update Ship position
  void updatePositionOfTheShip()
  {
    if(turnRight){
      direction.rotate(radians(2));
    }
    if(turnLeft)
    {
      direction.rotate(radians(-2));
    }
    if(!accelerate)
    {
      speed *= friction;
    }
    if(accelerate)
    {
      speed += 0.1;
    }
    
     velocity = PVector.mult(direction,speed);
     velocity.limit(maxSpeed);
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
  


// Display ship
  void displayShip()
  {

    ship.setStrokeWeight(1);
    ship.setStroke(#FFFFFF);
    // check is ship is still alive and then display
    if(isAlive == true)
    {
      pushMatrix();
      shapeMode(CENTER);
      translate(position.x, position.y);
      rotate(direction.heading());
      shape(ship);
      if(accelerate == true)
      {
         shape(accelerationShape);
      }
      fill(128,128,128,128);
      popMatrix();
    }
    else
    {
      timer++;
      if(timer < 120) // timer for the "BOM" picture 
      {
        image(boomImage,position.x, position.y,width/10, height/10); 
      }
      else
      {
        textFont(font,width/30);
        textAlign(CENTER);
        text("GAME OVER", width/2,height/2);
      }
    }
  }
  
  // Check for collision between ship and asteroid
  void detectCollisionShip(Asteroids asteroid)
  {
    float x = asteroid.position.x;
    float y = asteroid.position.y;
    PVector compare = new PVector(x,y); 
    distance = PVector.dist(compare, position);
    if(distance < radiusForCollisiton)
    {
      isAlive = false;
      player4.play();  
    }
  }
  

  
  
}
