class TextShape {
public String message;
public int x, y, w, h;
int x_NW, y_NW, x_NE, y_NE, x_SW, y_SW, x_SE, y_SE;
public int font;

TextShape(String word, int xx, int yy, int wid, int hei, int fontSize)
{
  message = word;
   x = xx;
   y = yy;
   w = wid;
   h = hei; 
   font = fontSize;
//   //Set northwest corner
//   x_NW = x;
//   y_NW = y;
//   //Set southwest corner
//   x_SW = x;
//   y_SW = y + h; 
//   //Set northeast corner
//   x_NE = x + w;
//   y_NE = y;
//   //Set southeast corner
//   x_SE = x + w;
//   y_SE = y + h;

  
  //set nw corner
  x_NW = x;
  y_NW = y - h;
  //set sw corner
  x_SW = x;
  y_SW = y;
  //set ne corner
  x_NE = x + w;
  y_NE = y - h;
  //set set se corner
  x_SE = x + w;
  y_SE = y; 
   
}

public boolean Intersects(TextShape s)
{
  return intersects(s.x_NW, s.y_NW, s.x_NE, s.y_NE, s.x_SW, s.y_SW, s.x_SE, s.y_SE);
}


//Returns true if there's an intersection, false otherwise
private boolean intersects(int xnw, int ynw, int xne, int yne, int xsw, int ysw, int xse, int yse)
{
  //check SE corner of incoming shape
  if (  (xse >= x_NW) &&  (yse >= y_NW)   &&  (xse <= x_NE)  && (yse <= y_SE))
  {
//    println("SE CORNER INTERSECTS");
    return true;
  } 
  //check SW corner of incoming shape
  else if (  (xsw <= x_NE) && (ysw >= y_NE) && (ysw <= y_SE)  && (xsw >= x_NW))
  {
//    println("SW CORNER INTERSECTS");
    return true;
  }
  //check NE corner of incoming shape
  else if ( (xne >= x_SW)  && (yne <= y_SW) && (yne >= y_NW) && (xne <= x_SE) )
  {
//    println("NE CORNER INTERSECTS");
    return true;
  }
  //check NW corner of incoming shape
  else if ( (xnw <= x_SE) && (ynw <= y_SE) && ( xnw >= x_SW) && (ynw >= y_NE) )
  {
//    println("NW CORNER INTERSECTS");
    return true;
  }
  //check for cases where intersection without corners, top part of rectangle
 else if ( (ynw >= y_NW) &&  (ynw <= y_SW) && (xnw <= x_NW) && (xne >= x_NE))
 {
//   println("OVERLAPPING INTERSECTION ON TOP");
   return true;
 }
 //check bottom part of the rectangle
 else if ( (ysw >= y_NW) &&  (ysw <= y_SW) && (xnw <= x_NW) && (xne >= x_NE))
 {
//   println("OVERLAPPING INTERSECTION ON BOTTOM");
   return true;
 }
 else if ( (xnw >= x_NW) && (xnw <= x_NE) && (ynw <= y_NW) && (ynw >= y_SE))
 {
//   println("other overlapping left");
   return true;
 }
 else if ( (xne >= x_NW) && (xne <= x_NE) && (ynw <= y_NW) && (ynw >= y_SE))
 {
//   println("other overlapping left");
   return true;
 }
 else
  {
//    println("NO INTERSECTION!");
    return false;
  }
  
  
  
}
}
