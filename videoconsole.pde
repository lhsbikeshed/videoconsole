import apwidgets.*;
import oscP5.*;
import netP5.*;
import android.os.AsyncTask;
import java.util.ArrayList;
import android.view.MotionEvent;

OscP5 oscP5;

NetAddress myRemoteLocation;                            
String serverIP = "10.0.0.100"; 

APWidgetContainer widgetContainer; 
APButton button1;
APButton button2;
APButton button3;
APButton button4;
APToggleButton overrideToggle1;
APToggleButton overrideToggle2;
APToggleButton overrideToggle3;
APToggleButton overrideToggle4;
APToggleButton overrideToggle5;
APToggleButton overrideToggle6;
APToggleButton overrideToggle7;
APToggleButton overrideToggle8;
APToggleButton overrideToggle9;
APToggleButton overrideToggle10;
APToggleButton overrideToggle11;
APToggleButton overrideToggle12;

APRadioGroup radioGroup;

void setup(){
  
  orientation(PORTRAIT);
  background(0);
  
  oscP5 = new OscP5(this, 12005);
  
  widgetContainer = new APWidgetContainer(this); //create new container for widgets
  button1 = new APButton(20, 20, 100, 70, "Start\r\nSystem"); 
  widgetContainer.addWidget(button1);
  button2 = new APButton(130, 20, 100, 70, "Stop\r\nSystem");
  widgetContainer.addWidget(button2);
  button3 = new APButton(240, 20, 100, 70, "Force Start Sequence");
  widgetContainer.addWidget(button3);
  button4 = new APButton(350, 20, 100, 70, "Force End Sequence");
  widgetContainer.addWidget(button4);
  
  stroke(255);
  line(0, 100, 480, 100);
  
  stroke(255);
  line(0, 495, 480, 495);
  
  textSize(20);
  text("Override Focus", 160, 515);
  
  widgetContainer = new APWidgetContainer(this); //create new container for widgets
  overrideToggle1 = new APToggleButton(20, 520, 100, 70, "Pilot\r\nVideo Cam"); 
  widgetContainer.addWidget(overrideToggle1);
  overrideToggle2 = new APToggleButton(130, 520, 100, 70, "Pilot\r\nScreen");
  widgetContainer.addWidget(overrideToggle2);
  overrideToggle3 = new APToggleButton(240, 520, 100, 70, "Main Room\r\nCam");
  widgetContainer.addWidget(overrideToggle3);
  overrideToggle4 = new APToggleButton(350, 520, 100, 70, "Main Screen\r\nVideo");
  widgetContainer.addWidget(overrideToggle4);
  
  
  
  overrideToggle5 = new APToggleButton(20, 600, 100, 70, "Tactical\r\nVideo Cam");
  widgetContainer.addWidget(overrideToggle5);
  overrideToggle6 = new APToggleButton(130, 600, 100, 70, "Tactical\r\nScreen");
  widgetContainer.addWidget(overrideToggle6);
  overrideToggle7 = new APToggleButton(240, 600, 100, 70, "Captain\r\nCam");
  widgetContainer.addWidget(overrideToggle7);
  overrideToggle8 = new APToggleButton(350, 600, 100, 70, "Chase Cam\r\nVideo");
  widgetContainer.addWidget(overrideToggle8);
  
  
  
  overrideToggle9 = new APToggleButton(20, 680, 100, 70, "Engineer\r\nVideo Cam");
  widgetContainer.addWidget(overrideToggle9);
  overrideToggle10 = new APToggleButton(130, 680, 100, 70, "Engineer\r\nScreen");
  widgetContainer.addWidget(overrideToggle10);
  overrideToggle11 = new APToggleButton(240, 680, 100, 70, "RESERVED");
  widgetContainer.addWidget(overrideToggle11);
  overrideToggle12 = new APToggleButton(350, 680, 100, 70, "RESERVED"); 
  widgetContainer.addWidget(overrideToggle12);
  
  //overrideToggle1.setChecked(true); //toggle button is on from the beginning
  
  //the following methods specify individual labels for on and off
  //overrideToggle1.setTextOn("Rectangle\r\nOn");
  //overrideToggle1.setTextOff("Rectangle\n\rOff");
}

/*void draw(){
  
  background(0); //black background
  
  if(overrideToggle.isChecked()){ //if the toggle button is on
    rect(50, 20, 100, 100); // draw the rectangle
  }
}*/

//onClickWidget is called when a widget is clicked/touched
void onClickWidget(APWidget widget){
  
  if(widget == overrideToggle1){ //if it was button1 that was clicked
    if(overrideToggle1.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(1);
      new SendOSCTask().execute(m);
      
      overrideToggle2.setChecked(false);
      overrideToggle3.setChecked(false);
      overrideToggle4.setChecked(false);
      overrideToggle5.setChecked(false);
      overrideToggle6.setChecked(false);
      overrideToggle7.setChecked(false);
      overrideToggle8.setChecked(false);
      overrideToggle9.setChecked(false);
      overrideToggle10.setChecked(false);
      overrideToggle11.setChecked(false);
      overrideToggle12.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
  }else if(widget == overrideToggle2){ //if it was button1 that was clicked
    if(overrideToggle2.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(2);
      new SendOSCTask().execute(m);
      
      overrideToggle1.setChecked(false);
      overrideToggle3.setChecked(false);
      overrideToggle4.setChecked(false);
      overrideToggle5.setChecked(false);
      overrideToggle6.setChecked(false);
      overrideToggle7.setChecked(false);
      overrideToggle8.setChecked(false);
      overrideToggle9.setChecked(false);
      overrideToggle10.setChecked(false);
      overrideToggle11.setChecked(false);
      overrideToggle12.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
  }else if(widget == overrideToggle3){ //if it was button1 that was clicked
    if(overrideToggle3.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(3);
      new SendOSCTask().execute(m);
      
      overrideToggle1.setChecked(false);
      overrideToggle2.setChecked(false);
      overrideToggle4.setChecked(false);
      overrideToggle5.setChecked(false);
      overrideToggle6.setChecked(false);
      overrideToggle7.setChecked(false);
      overrideToggle8.setChecked(false);
      overrideToggle9.setChecked(false);
      overrideToggle10.setChecked(false);
      overrideToggle11.setChecked(false);
      overrideToggle12.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
  }else if(widget == overrideToggle4){ //if it was button1 that was clicked
    if(overrideToggle4.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(4);
      new SendOSCTask().execute(m);
      
      overrideToggle1.setChecked(false);
      overrideToggle2.setChecked(false);
      overrideToggle3.setChecked(false);
      overrideToggle5.setChecked(false);
      overrideToggle6.setChecked(false);
      overrideToggle7.setChecked(false);
      overrideToggle8.setChecked(false);
      overrideToggle9.setChecked(false);
      overrideToggle10.setChecked(false);
      overrideToggle11.setChecked(false);
      overrideToggle12.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
  }else if(widget == overrideToggle5){ //if it was button1 that was clicked
    if(overrideToggle5.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(5);
      new SendOSCTask().execute(m);
      
      overrideToggle1.setChecked(false);
      overrideToggle2.setChecked(false);
      overrideToggle3.setChecked(false);
      overrideToggle4.setChecked(false);
      overrideToggle6.setChecked(false);
      overrideToggle7.setChecked(false);
      overrideToggle8.setChecked(false);
      overrideToggle9.setChecked(false);
      overrideToggle10.setChecked(false);
      overrideToggle11.setChecked(false);
      overrideToggle12.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
  }else if(widget == overrideToggle6){ //if it was button1 that was clicked
    if(overrideToggle6.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(6);
      new SendOSCTask().execute(m);
      
      overrideToggle1.setChecked(false);
      overrideToggle2.setChecked(false);
      overrideToggle3.setChecked(false);
      overrideToggle4.setChecked(false);
      overrideToggle5.setChecked(false);
      overrideToggle7.setChecked(false);
      overrideToggle8.setChecked(false);
      overrideToggle9.setChecked(false);
      overrideToggle10.setChecked(false);
      overrideToggle11.setChecked(false);
      overrideToggle12.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
  }else if(widget == overrideToggle7){ //if it was button1 that was clicked
    if(overrideToggle7.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(7);
      new SendOSCTask().execute(m);
      
      overrideToggle1.setChecked(false);
      overrideToggle2.setChecked(false);
      overrideToggle3.setChecked(false);
      overrideToggle4.setChecked(false);
      overrideToggle5.setChecked(false);
      overrideToggle6.setChecked(false);
      overrideToggle8.setChecked(false);
      overrideToggle9.setChecked(false);
      overrideToggle10.setChecked(false);
      overrideToggle11.setChecked(false);
      overrideToggle12.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
  }else if(widget == overrideToggle8){ //if it was button1 that was clicked
    if(overrideToggle8.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(8);
      new SendOSCTask().execute(m);
      
      overrideToggle1.setChecked(false);
      overrideToggle2.setChecked(false);
      overrideToggle3.setChecked(false);
      overrideToggle4.setChecked(false);
      overrideToggle5.setChecked(false);
      overrideToggle6.setChecked(false);
      overrideToggle7.setChecked(false);
      overrideToggle9.setChecked(false);
      overrideToggle10.setChecked(false);
      overrideToggle11.setChecked(false);
      overrideToggle12.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
  }else if(widget == overrideToggle9){ //if it was button1 that was clicked
    if(overrideToggle9.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(9);
      new SendOSCTask().execute(m);
      
      overrideToggle1.setChecked(false);
      overrideToggle2.setChecked(false);
      overrideToggle3.setChecked(false);
      overrideToggle4.setChecked(false);
      overrideToggle5.setChecked(false);
      overrideToggle6.setChecked(false);
      overrideToggle7.setChecked(false);
      overrideToggle8.setChecked(false);
      overrideToggle10.setChecked(false);
      overrideToggle11.setChecked(false);
      overrideToggle12.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
  }else if(widget == overrideToggle10){ //if it was button1 that was clicked
    if(overrideToggle10.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(10);
      new SendOSCTask().execute(m);
      
      overrideToggle1.setChecked(false);
      overrideToggle2.setChecked(false);
      overrideToggle3.setChecked(false);
      overrideToggle4.setChecked(false);
      overrideToggle5.setChecked(false);
      overrideToggle6.setChecked(false);
      overrideToggle7.setChecked(false);
      overrideToggle8.setChecked(false);
      overrideToggle9.setChecked(false);
      overrideToggle11.setChecked(false);
      overrideToggle12.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
  }else if(widget == overrideToggle11){ //if it was button1 that was clicked
    if(overrideToggle11.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(11);
      new SendOSCTask().execute(m);
      
      overrideToggle1.setChecked(false);
      overrideToggle2.setChecked(false);
      overrideToggle3.setChecked(false);
      overrideToggle4.setChecked(false);
      overrideToggle5.setChecked(false);
      overrideToggle6.setChecked(false);
      overrideToggle7.setChecked(false);
      overrideToggle8.setChecked(false);
      overrideToggle9.setChecked(false);
      overrideToggle10.setChecked(false);
      overrideToggle12.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
  }else if(widget == overrideToggle12){ //if it was button1 that was clicked
    if(overrideToggle12.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(12);
      new SendOSCTask().execute(m);
      
      overrideToggle1.setChecked(false);
      overrideToggle2.setChecked(false);
      overrideToggle3.setChecked(false);
      overrideToggle4.setChecked(false);
      overrideToggle5.setChecked(false);
      overrideToggle6.setChecked(false);
      overrideToggle7.setChecked(false);
      overrideToggle8.setChecked(false);
      overrideToggle9.setChecked(false);
      overrideToggle10.setChecked(false);
      overrideToggle11.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/video/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
  }else if(widget == button1){ //if it was button1 that was clicked
    // TODO SEND OSC
    OscMessage m = new OscMessage("/video/system");
    m.add(1);
    new SendOSCTask().execute(m);
  }else if(widget == button2){ //if it was button1 that was clicked
    // TODO SEND OSC
    OscMessage m = new OscMessage("/video/system");
    m.add(0);
    new SendOSCTask().execute(m);
  }else if(widget == button3){ //if it was button1 that was clicked
    // TODO SEND OSC
    OscMessage m = new OscMessage("/video/playSequence");
    m.add(1);
    new SendOSCTask().execute(m);
  }else if(widget == button4){ //if it was button1 that was clicked
    // TODO SEND OSC
    OscMessage m = new OscMessage("/video/playSequence");
    m.add(2);
    new SendOSCTask().execute(m);
  }
  
}

private class SendOSCTask extends AsyncTask<OscMessage, Void, String> {
  protected String doInBackground(OscMessage... Messages) {
    for (OscMessage message : Messages) {
 
      oscP5.send(message, new NetAddress(serverIP, 12000));
      println("Sending: " + message.addrPattern());
    }
 
    return "done";
  }
  protected void onProgressUpdate() {
    // setProgressPercent(progress[0]);
  }
 
  protected void onPostExecute() {
    // showDialog("Downloaded " + result + " bytes");
  }
}
