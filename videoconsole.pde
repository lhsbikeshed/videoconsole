import apwidgets.*;
import oscP5.*;
import netP5.*;
import android.os.AsyncTask;
import java.util.ArrayList;
import android.view.MotionEvent;

OscP5 oscP5;

NetAddress myRemoteLocation;                            
String serverIP = "192.168.1.12"; 

APWidgetContainer widgetContainer; 
APButton feedRestartButton1;
APButton feedRestartButton2;
APButton feedRestartButton3;
APButton feedRestartButton4;
APButton feedRestartButton5;
APButton button1;
APButton button2;
APToggleButton streamingToggle1;
APToggleButton audioToggle1;
APToggleButton screenToggle1;
APToggleButton screenToggle2;
APToggleButton screenToggle3;
APToggleButton overrideToggle1;
APToggleButton overrideToggle2;
APToggleButton overrideToggle3;
APToggleButton overrideToggle4;
APToggleButton overrideToggle5;


void setup(){
  
  orientation(PORTRAIT);
  background(0);
  
  oscP5 = new OscP5(this, 12010);
  
  widgetContainer = new APWidgetContainer(this); //create new container for widgets
  button1 = new APButton(20, 20, 100, 70, "Start\r\nSystem"); 
  widgetContainer.addWidget(button1);
  audioToggle1 = new APToggleButton(130, 20, 100, 70, "Cabin Mic\r\nMute"); 
  widgetContainer.addWidget(audioToggle1);
  streamingToggle1 = new APToggleButton(240, 20, 100, 70, "UStream\r\nStream"); 
  widgetContainer.addWidget(streamingToggle1);
  button2 = new APButton(350, 20, 100, 70, "Stop\r\nSystem");
  widgetContainer.addWidget(button2);
  
  stroke(255,255,255);
  line(0, 100, 480, 100);
  
  feedRestartButton1 = new APButton(20, 110, 80, 70, "Pilot\r\nCam"); 
  widgetContainer.addWidget(feedRestartButton1);
  feedRestartButton2 = new APButton(110, 110, 80, 70, "Tact\r\nCam"); 
  widgetContainer.addWidget(feedRestartButton2);
  feedRestartButton3 = new APButton(200, 110, 80, 70, "Engi\r\nCam"); 
  widgetContainer.addWidget(feedRestartButton3);
  feedRestartButton4 = new APButton(290, 110, 80, 70, "Cabin\r\nCam"); 
  widgetContainer.addWidget(feedRestartButton4);
  feedRestartButton5 = new APButton(380, 110, 80, 70, "Cap\r\nCam"); 
  widgetContainer.addWidget(feedRestartButton5);
  
  textSize(15);
  text("Restart Feeds", 180, 200);
  
  stroke(255,255,255);
  line(0, 210, 480, 210);
  
  
  textSize(20);
  text("Status messages:", 20, 230);
  
  
  
  stroke(255,255,255);
  line(0, 375, 480, 375);
  
  screenToggle1 = new APToggleButton(20, 400, 100, 70, "START\r\nSCREEN"); 
  widgetContainer.addWidget(screenToggle1);
  screenToggle2 = new APToggleButton(130, 400, 200, 70, "T  E  C  H  N  I  C  A  L\r\nD  I  F  F  I  C  U  L  T  I  E  S"); 
  widgetContainer.addWidget(screenToggle2);
  screenToggle3 = new APToggleButton(340, 400, 100, 70, "END\r\nSCREEN"); 
  widgetContainer.addWidget(screenToggle3);
  
  stroke(255,255,255);
  line(0, 495, 480, 495);
  
  textSize(20);
  text("Override Focus", 162, 515);
  
  //widgetContainer = new APWidgetContainer(this); //create new container for widgets
  overrideToggle1 = new APToggleButton(70, 520, 100, 70, "Pilot\r\nCam"); 
  widgetContainer.addWidget(overrideToggle1);
  overrideToggle2 = new APToggleButton(290, 520, 100, 70, "Tactical\r\nCam");
  widgetContainer.addWidget(overrideToggle2);
  overrideToggle3 = new APToggleButton(70, 680, 100, 70, "Engineering\r\nCam");
  widgetContainer.addWidget(overrideToggle3);
  overrideToggle4 = new APToggleButton(180, 600, 100, 70, "Cabin\r\nCam");
  widgetContainer.addWidget(overrideToggle4);
  overrideToggle5 = new APToggleButton(290, 680, 100, 70, "Captain\r\nCam");
  widgetContainer.addWidget(overrideToggle5);
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
  }else if(widget == audioToggle1){ //if it was button1 that was clicked
    // TODO SEND OSC
    OscMessage m = new OscMessage("/audio/mic1");
    if(audioToggle1.isChecked()){
      m.add(0);
    }else{
      m.add(1);
    }
    new SendOSCTask().execute(m);
  }else if(widget == streamingToggle1){ //if it was button1 that was clicked
    // TODO SEND OSC
    OscMessage m = new OscMessage("/streaming/ustream");
    if(audioToggle1.isChecked()){
      m.add(1);
    }else{
      m.add(0);
    }
    new SendOSCTask().execute(m);
  }else if(widget == feedRestartButton1){ //if it was button1 that was clicked
    // TODO SEND OSC
    OscMessage m = new OscMessage("/feed/restart/");
    m.add(1);
    new SendOSCTask().execute(m);
  }else if(widget == feedRestartButton2){ //if it was button1 that was clicked
    // TODO SEND OSC
    OscMessage m = new OscMessage("/feed/restart/");
    m.add(2);
    new SendOSCTask().execute(m);
  }else if(widget == feedRestartButton3){ //if it was button1 that was clicked
    // TODO SEND OSC
    OscMessage m = new OscMessage("/feed/restart/");
    m.add(3);
    new SendOSCTask().execute(m);
  }else if(widget == feedRestartButton4){ //if it was button1 that was clicked
    // TODO SEND OSC
    OscMessage m = new OscMessage("/feed/restart/");
    m.add(4);
    new SendOSCTask().execute(m);
  }else if(widget == feedRestartButton5){ //if it was button1 that was clicked
    // TODO SEND OSC
    OscMessage m = new OscMessage("/feed/restart/");
    m.add(5);
    new SendOSCTask().execute(m);
  }else if(widget == screenToggle1){ //if it was button1 that was clicked
    if(screenToggle1.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/screen/focus");
      m.add(1);
      new SendOSCTask().execute(m);
      
      screenToggle2.setChecked(false);
      screenToggle3.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/screen/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
  }else if(widget == screenToggle2){ //if it was button1 that was clicked
    if(screenToggle2.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/screen/focus");
      m.add(2);
      new SendOSCTask().execute(m);
      
      screenToggle1.setChecked(false);
      screenToggle3.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/screen/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
  }else if(widget == screenToggle3){ //if it was button1 that was clicked
    if(screenToggle3.isChecked()){ // Turn off all other buttons and set this focused
      // TODO SEND OSC
      OscMessage m = new OscMessage("/screen/focus");
      m.add(3);
      new SendOSCTask().execute(m);
      
      screenToggle1.setChecked(false);
      screenToggle2.setChecked(false);
    }
    else{ // Button is off, send auto camera switching
      // TODO SEND OSC
      OscMessage m = new OscMessage("/screen/focus");
      m.add(0);
      new SendOSCTask().execute(m);
    }
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
