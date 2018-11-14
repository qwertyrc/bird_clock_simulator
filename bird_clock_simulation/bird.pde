class Bird{
  float x,y;
  float kp, ki;
  float speedX,speedY;
  float propX,propY,inteX,inteY;
  color colour;
  
  
  Bird(float _x,float _y,float _kp, float _ki, color _colour){
    x = _x;
    y = _y;
    kp = _kp;
    ki = _ki;
    speedX = speedY = 0;
    colour = _colour;
  }
  
  void update(float targetX,float targetY){
    //degree
    float deltaX = targetX - x;
    float deltaY = targetY - y;
    
      float pre_inteX = inteX,pre_inteY = inteY;
     inteX = deltaX;
      inteY = deltaY;
      propX = inteX - pre_inteX;
      propY = inteY - pre_inteY;
      
      //        P            I            noise
      speedX += constrain(kp * propX + ki * inteX + random(-1,1),-40,40);
      speedY += constrain(kp * propY + ki * inteY + random(-1,1),-40,40);
      
      float dxdy = sqrt(speedX*speedX + speedY*speedY);
      x += speedX;
      y += speedY;
  }
  
  void display(){
    fill(colour);
    ellipse(x,y,20,20);
  }
}
