ArrayList <cell> queue = new ArrayList<cell>();
ArrayList <cell> temp = new ArrayList<cell>();
ArrayList <cell> temp2 = new ArrayList<cell>();
ArrayList <cell> temp3 = new ArrayList<cell>();

int rows = 200,cols = 200,counter = cols*rows-1;
float ma = 0;
int minr = 20,minwr = 20,maxr = 1000000,maxwr = 1000000,W = 1200,H = 600;
float cutoff = 70;

PImage img;
cell tissue;

void settings(){
  size(W,H);
}
void setup(){
  img = load("btfly.jpeg");
  println(ma);
  tissue = new cell(img,cols,rows);
  tissue.getNeighbours();
  tissue.findSpaces();
  tissue.findWalls();
  tissue.findEdges();
  tissue.sortEdges();
  
};

void draw(){
  background(255);
  tissue.draw();
  fill(0);
  if(mousePressed)fill(255);
  text(frameRate,10,10);
  text(tissue.ry,10,20);
  //image(img,0,0);
  //text(tissue.cells.get(0).neighbours.size(),10,20);
};
