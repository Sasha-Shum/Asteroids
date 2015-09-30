class Menu
{
  int x,y;
  PFont font;
  ArrayList<Stars> stars;
  ArrayList<Asteroids> asteroids;
  int state;
  
  Menu()
  {
    x = width/2;
    y = height/2;
    font = loadFont("Jokerman-Regular-32.vlw");
   stars = new ArrayList<Stars>();
   
   // Draw stars
   for(int i = 0; i <= random(100,200); i++)
   {
     stars.add(new Stars((int)random(width), (int)random(height)));
    }
    
    // add asteroids to the list
    asteroids = new ArrayList<Asteroids>();
    for(int y = 0; y <= random(7,20); y++)
    {
      asteroids.add(new Asteroids());
      
    }
    
    
  state = 0;
  }
  
  void display()
  {
    background(0);
    // Display asteroids
    for(int y = 0; y < asteroids.size(); y++)
    {
      asteroids.get(y).updateAsteroidPosition();
      asteroids.get(y).displayAsteroid(); 
      
    }
    stroke(255);
    strokeWeight(5);
    
    //Display Stars
    for(int i = 0; i < stars.size(); i++)
    {
      stars.get(i).displayStars();
    }
    // End stars
    
    
    //Draw Options Menu
    stroke(0);
    rectMode(CENTER);
    fill(152,178,191);
    rect(x,y, width/4, height/2);
    fill(63,170,222);
    rect(x,y - (height/8), width/6, height/11);
    rect(x,y, width/6,height/11);
    rect(x,y + (height/8), width/6, height/11);
    fill(0);
    textFont(font,width/60);
    textAlign(CENTER);
    text("START", x, y - (height/9));
    text("OPTIONS", x, y + (height/50));
    text("EXIT",x,y+(height/7));

  }
  
  // Check if mouse over any of the buttons.
  void mouseOverButtons()
  {
    
    if(mouseX > (x - width/12) && mouseX < (x + width/12) &&
    mouseY > (y - height/6) && mouseY < y - height/10)
    {
      stroke(255);
      line(x - width/18, y - (height/10),x + width/18 , y - (height/10));
      if(mousePressed == true)
      {
        state = 1;
      }
      
    }
   
    if(mouseX > (x - width/12) && mouseX < (x + width/12) &&
    mouseY > (y - height/28) && mouseY < (y + height/25))
    {
      stroke(255);
      line(x - width/18, (y + height/35),x + width/18 , (y + height/35));
      if(mousePressed == true)
      {
        state = 2;
      }
    }
  
   if(mouseX > (x - width/12) && mouseX < (x + width/12) &&
    mouseY > (y + height/11) && mouseY < (y + height/6))
    {
      stroke(255);
      line(x - width/18, (y + height/6.7),x + width/18 , (y + height/6.7));
      if(mousePressed == true)
      {
        state = 3;
      }
    }
  }
  
 
  // get state
  int StateMode()
  {
    return state;
  }

}
