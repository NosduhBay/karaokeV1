/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void pauseButton(GButton source, GEvent event) { //_CODE_:pause:277523:
  if(paused == true) {
    paused = false;
    song.start();
    pause.setText("Pause");
  } else {
    paused = true;
    song.pause();
    pause.setText("Resume");
  }

} //_CODE_:pause:277523:

public void volumeSlider(GCustomSlider source, GEvent event) { //_CODE_:volume:675395:
  println("volume - GCustomSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:volume:675395:

public void quitGame(GButton source, GEvent event) { //_CODE_:quit:425047:
  println("quit - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:quit:425047:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  pause = new GButton(this, 100, 325, 80, 20);
  pause.setText("Pause");
  pause.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  pause.addEventHandler(this, "pauseButton");
  volume = new GCustomSlider(this, 206, 310, 100, 50, "purple18px");
  volume.setShowValue(true);
  volume.setLimits(1.0, 0.0, 1.0);
  volume.setNumberFormat(G4P.DECIMAL, 2);
  volume.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  volume.setOpaque(false);
  volume.addEventHandler(this, "volumeSlider");
  quit = new GButton(this, 332, 325, 80, 20);
  quit.setText("Quit");
  quit.addEventHandler(this, "quitGame");
}

// Variable declarations 
// autogenerated do not edit
GButton pause; 
GCustomSlider volume; 
GButton quit; 
