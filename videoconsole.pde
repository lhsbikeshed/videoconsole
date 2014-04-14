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
APButton button1;
APButton button2;
APButton button3;
APButton button4;
APToggleButton streamingToggle1;
APToggleButton streamingToggle2;
APToggleButton streamingToggle3;
APToggleButton streamingToggle4;
APToggleButton audioToggle1;
APToggleButton audioToggle2;
APToggleButton audioToggle3;
APToggleButton audioToggle4;
APToggleButton techdiffToggle;
APToggleButton overrideToggle1;
APToggleButton overrideToggle2;
APToggleButton overrideToggle3;
APToggleButton overrideToggle4;
APToggleButton overrideToggle5;

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
  
  stroke(255,255,255);
  line(0, 100, 480, 100);
  
  streamingToggle1 = new APToggleButton(20, 110, 100, 70, "YouTube\r\nStream"); 
  widgetContainer.addWidget(streamingToggle1);
  streamingToggle2 = new APToggleButton(130, 110, 100, 70, "UStream\r\nStream");
  widgetContainer.addWidget(streamingToggle2);
  streamingToggle3 = new APToggleButton(240, 110, 100, 70, "Twitch\r\nStream");
  widgetContainer.addWidget(streamingToggle3);
  streamingToggle4 = new APToggleButton(350, 110, 100, 70, "Other\r\nStream");
  widgetContainer.addWidget(streamingToggle4);
  
  textSize(10);
  text("Offline", 20, 190);
  text("Connecting", 130, 190);
  text("Online", 240, 190);
  text("Error", 350, 190);
  
  stroke(255,255,255);
  line(0, 200, 480, 200);
  
  audioToggle1 = new APToggleButton(20, 210, 100, 70, "Mic 1\r\nMute"); 
  widgetContainer.addWidget(audioToggle1);
  audioToggle2 = new APToggleButton(130, 210, 100, 70, "Mic 2\r\nMute");
  widgetContainer.addWidget(audioToggle2);
  audioToggle3 = new APToggleButton(240, 210, 100, 70, "Mic 3\r\nMute");
  widgetContainer.addWidget(audioToggle3);
  audioToggle4 = new APToggleButton(350, 210, 100, 70, "Main Game\r\nMute");
  widgetContainer.addWidget(audioToggle4);
  
  stroke(255,255,255);
  line(0, 290, 480, 290);
  
  textSize(20);
  text("Status messages:", 20, 320);
  
  
  
  stroke(255,255,255);
  line(0, 375, 480, 375);
  
  techdiffToggle = new APToggleButton(20, 400, 430, 70, "T  E  C  H  N  I  C  A  L    D  I  F  F  I  C  U  L  T  I  E  S"); 
  widgetContainer.addWidget(techdiffToggle);
  
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
