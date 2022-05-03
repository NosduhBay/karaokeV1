import g4p_controls.*;
import processing.core.PApplet;
import processing.sound.*;
import java.util.Collections;
import java.util.Map;
import java.util.HashMap;
import g4p_controls.*;

static final int BANDS = 2048;
String gameState = "menu";
float vol = 1.0;
PImage b;
PImage img;
String[] pics = {"MR_S_ARMUP.png", "MR_S_ARMMID.png", "MR_S_ARMDOWN.png", "MR_S_ARMMID.png"};
int currentPic = 0;
int bpm = 85;
String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
String note;
String previousNote;
ArrayList<PVector> movingNotes = new ArrayList<PVector>();
ArrayList<String> noteName = new ArrayList<String>();

boolean paused = false;

Map<Float, String> frequencyTable;
Microphone mic;
Song song;
String micNote, songNote;
float micFrequency, songFrequency;
int accuracy;
float accuracySum = 0;
int divisor = 0;

void setup() {
  size(512, 360);
  frameRate(10);
  textAlign(CENTER);
  PFont candara;
  candara = createFont("Candara-48.vlw", 40);
  textFont(candara);
  b = loadImage("Curtains img 1.jpg");
  img = loadImage(pics[currentPic]);
  frequencyTable = generateFrequencyTable();
  createGUI();
}

void draw() {
  if (gameState == "menu") {
    background(img);
  } else if (gameState == "play") {
    changeBackground();

    for (int i = 0; i < BANDS; i++) {
      line(i, height, i, height - mic.spectrum[i] * height * 5);
    }
  
    if (frameCount % 10 == 0) {
      micFrequency = mic.getFrequency();
      songFrequency = song.getFrequency();
      micNote = mic.getClosestNote(micFrequency);
      songNote = song.getClosestNote(songFrequency);
      song.compare(mic, accuracySum, divisor);
      findNote();
    }
  
    showNotes();
    drawLyrics(song);
  }
}

/*
* Returns a hashmap of frequencies to the corresponding pitches.
 */
Map<Float, String> generateFrequencyTable() {
  Map<Float, String> table = new HashMap<Float, String>();
  BufferedReader reader = createReader("freq_to_note.txt");
  String line;

  try {
    while ((line = reader.readLine()) != null) {
      String[] pieces = split(line, ",");
      String note = pieces[0];
      float freq = float(pieces[1]);
      table.put(freq, note);
    }
  }
  catch (IOException e) {
  }

  return table;
}

/*
* Returns the index of the max value in an array of floats.
*/
public int argMax(float[] vals) {
  int maxIndex = 0;
  float max = 0;

  for (int i = 0; i < vals.length; i++) {
    if (vals[i] > max) {
      maxIndex = i;
      max = vals[i];
    }
  }

  return maxIndex;
}

/*
* Determines when to change the background image.
*/
void changeBackground() {
  background(img);
  int changesPerMin = round(frameRate*60/bpm);

  if (frameCount % changesPerMin == 0) {
    currentPic ++;
    img = loadImage(pics[currentPic%4]);
  }
}

/*
* Returns the average accuracy as a float.
*/
float getAverageAccuracy() {
  return accuracySum / divisor;
}
