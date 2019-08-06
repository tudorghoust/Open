import processing.serial.*;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.MouseInfo;
import java.awt.event.*;

Serial myPort;  
String val;  
char v;
int a=0,c=0;
int contor = 1;

void setup()
{
  myPort = new Serial(this, "COM6", 9600);
}

void draw()
{
  while(true){
  if ( myPort.available() > 0) 
  {  
  val = myPort.readStringUntil('\n');
  if(val!=null)
     v = val.charAt(0);
  } 
   println(val);
     if(v == '1')
        moveMouse(0,-2);
     if(v == '2')
        moveMouse(0,2);
     if(v == '3')
         moveMouse(2,0);
       if(v == '4')
        moveMouse(-2,0);
     if(v == '5')
        moveMouse(1,-1);
     if(v == '6')
        moveMouse(-1,-1);
     if(v == '7')
        moveMouse(-1,1);
     if(v == '8')
        moveMouse(1,1);
     if(v == 'l'){
        leftClickDown();
        leftClickUp();
        v = 'i';
     }
     if(v == 'r')
        rightClick();
        
     if(v == 'd')
       leftClickDown();
        
     delay(1);
             /*if(a == 0)
             {
         delay(1);
             } 
             if(v == 'd' && a == 0)
             {
               a=1;
               v='e';
           }
                        if( a == 1)
                        {
                          delay(0);
                        }
                                    if(v == 'd' && a == 1)
                                  {
                                       a=0;
                                  }*/


           
 }
 
}

public void moveMouse(int x, int y){
   
   int movex = MouseInfo.getPointerInfo().getLocation().x;
   int movey = MouseInfo.getPointerInfo().getLocation().y;
  
   try
    {
    Robot robot = new Robot();
    robot.mouseMove(movex+x,movey+y);  
    }
    catch (AWTException e)
    {
    e.printStackTrace();
    }
    

  
} 


void leftClickDown(){
   try
    {
    Robot robot = new Robot();    
    robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
   // robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
    }
    catch (AWTException e)
    {
    e.printStackTrace();
    }
} 

void leftClickUp(){
   try
    {
    Robot robot = new Robot();    
    //robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
    robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
    }
    catch (AWTException e)
    {
    e.printStackTrace();
    }
}


void rightClick(){
  try
    {
    Robot robot = new Robot();    
    robot.mousePress(InputEvent.BUTTON3_DOWN_MASK);
    robot.mouseRelease(InputEvent.BUTTON3_DOWN_MASK);
    }
    catch (AWTException e)
    {
    e.printStackTrace();
    }
}
