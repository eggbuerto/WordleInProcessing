//Final Project
//Wordle
//Evan Gould

import controlP5.*;
import g4p_controls.*;
//import TextShape;

ControlP5 control;
WordleMap map;
Textarea textArea;
Textfield field;
String text, displayText;

int maxFont = 60;
int minFont = 10;
int offset = 660;

int maxWeight, minWeight;

int weights[];
String words[];
int font_sizes[];
int font_colors[];
//int xpos[], ypos[];
boolean draw;

ArrayList<TextShape> placedWords;

void setup()
{

  size(900, 600);
  draw = false;
  text = "-Press Enter to transfer text from the above text box to this text field. \n-Press Paste to paste "
                     + "in text from the clipboard. \n-Press Create to create the word cloud after using Paste or Enter";
  displayText = "";
//  placedWords = new ArrayList<TextShape>();

  PFont font = createFont("arial", 12);
  control = new ControlP5(this);

  //Non editable text area
  textArea = control.addTextarea("output")
    .setPosition(20 + offset, 120)
      .setSize(200, 400)
        .setFont(font)
          .setLineHeight(14)
            .setColor(color(128))
              .setColorBackground(color(255, 100))
                .setColorForeground(color(255, 100));
                
   textArea.setText("-Press Enter to transfer text from the above text box to this text field. \n-Press Paste to paste "
                     + "in text from the clipboard. \n-Press Create to create the word cloud after using Paste or Enter");

  //Editable textfield  
  field = control.addTextfield("input")
    .setPosition(20 + offset, 20)
      .setSize(200, 40)
        .setFont(font)
          .setFocus(true)
            .setColor(color(255, 0, 0));

  control.addBang("Enter")
    .setPosition(20 + offset, 80)
      .setSize(80, 30)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);  

  control.addBang("Paste")
    .setPosition(120 + offset, 80)
      .setSize(100, 30)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

  control.addBang("Create")
    .setPosition(20 + offset, 540)
      .setSize(80, 30)
        .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

  textFont(font);



  //test some intersection
//  TextShape ts1 = new TextShape("hi", 100, 100, 100, 100, 12);
//  TextShape ts2 = new TextShape("bye", 100, 100, 100, 100, 12);
//  println(ts1.Intersects(ts2));
}

public void Paste()
{
  text = GClip.paste();
  textArea.setText(text);
  field.setText(text);
}

//Create the wordle
public void Create()
{
  
  map = new WordleMap(text);
  weights = map.getWeights();
  words = map.getWords();
  placedWords = new ArrayList<TextShape>();

  //assign fonts
  font_sizes = new int[weights.length];
  font_colors = new int[weights.length];
  //  xpos = new int[weights.length];
  //  ypos = new int[weights.length];

  maxWeight = map.getMax();
  minWeight = map.getMin();
//  println("got here");
  for (int i = 0; i < weights.length; i++)
  {
    font_sizes[i] = (int) map(weights[i], minWeight, maxWeight, minFont, maxFont);
    font_colors[i] = (int) map(weights[i], minWeight, maxWeight, 200, 0); 
    //    xpos[i] = (int) random(220, 800);
    //    ypos[i] = (int) random(20, 500);
  }

  //place the words!
  for (int i = 0; i < weights.length; i++)
  {
    place_shape(words[i], i, font_sizes[i]);
  }
  
  //allow the program to draw
  draw = true;
  println("size of placed words: " + placedWords.size());
}


public void Enter()
{
  text = control.get(Textfield.class, "input").getText();
  textArea.setText(text);
}

void draw()
{
  background(255);

  stroke(0);
  smooth();
  fill(0);
  //text(displayText, 20, 400);
  //x = 220 y = 20
  //size(900, 600);
//  textFont(createFont("futura"));
  if (draw == true && placedWords.size() == words.length)
  {
    for (TextShape s : placedWords)
    {
      fill(map(s.font, minFont, maxFont, 120, 0));
      textFont(createFont("futura", s.font));
      textSize(s.font);
      text(s.message, s.x, s.y);
      noFill();
//      strokeWeight(2);
//      point(s.x_NW, s.y_NW);
//      beginShape();
//      vertex(s.x_NW, s.y_NW);
//      vertex(s.x_NE, s.y_NE);
//      vertex(s.x_SE, s.y_SE);
//      vertex(s.x_SW, s.y_SW);
//      vertex(s.x_NW, s.y_NW);
//
//      endShape();
    }
  }


  //  text(w, 50, 50);
  //  place_shape(400, 300);
}


boolean place_shape(String word, int i, int f)
{

  int xpos = (int) random(200, 400);
  int ypos = (int) random(200, 400);
  int font_size = f;
  textSize(f); 
  int w = (int) textWidth(word);
  int h = (int) (textAscent() + textDescent()); 
  //  println("font " + f + " width " + w + " height " + h );
  TextShape s = new TextShape(word, xpos, ypos, w, h, font_size);

  //if it is the first word to be placed, add to the list of placed words
  //and return
  if (placedWords.isEmpty())
  {
    placedWords.add(s); 
    return true;
  } 

  //spiral variables
  double pi = Math.PI;
  double step = 2 * pi / 30;
  double condition = 30 * pi;
  double counter = step;

  //begin main loop
  boolean placed = false;
  while (placed == false)
  {
    int count = 0;
    //search for conflicts
    for (TextShape text : placedWords)
    {
      if (text.Intersects(s))
      {
        break;
      }
      count++;
    }

    //if the whole arraylist is iterated through and there are no conflicts, break out of the loop
    if (count == placedWords.size())
    {
      placed = true;
    }
    //otherwise, search for a suitable location along a spiral path
    else if (counter < condition)
    {
      //      vertex((float)(x + counter * Math.cos(counter)), (float)(y + counter * Math.sin(counter)));
      xpos = (int) (xpos + counter * Math.cos(counter));
      ypos = (int) (ypos + counter * Math.sin(counter));
      s = new TextShape(word, xpos, ypos, w, h, font_size);
      counter += step;
//      println("finding a new location : " + s.message + " " + xpos + " " + ypos);
    }
    //try a new starting location 
    else 
    {
      counter = step;
      xpos = (int) random(200, 400);
      ypos = (int) random(200, 400);
      s = new TextShape(word, xpos, ypos, w, h, font_size);
//      println("finding a new location : " + s.message + " " + xpos + " " + ypos);
    }
  }

  placedWords.add(s);
//  println("placing word: " + s.message + " " + xpos + " " + ypos + " font " + s.font);





  //  double pi = Math.PI;
  //  noFill();
  //  stroke(0);
  //  beginShape();
  //  double step = 2 * pi / 40;
  //  double condition = 60 * pi;
  //  double counter = step;
  //  while (counter < condition)
  //  {
  //    vertex((float)(x + counter * Math.cos(counter)), (float)(y + counter * Math.sin(counter)));
  //    counter += step;
  //  } 
  //  endShape(); 
  return true;
}

