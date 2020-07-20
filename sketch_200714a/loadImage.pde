PImage load(String s){
  PImage img = loadImage(s);
  img.loadPixels();
  for(int i=0;i<img.width;i++){
    for(int j=0;j<img.height;j++){
      int p = i + j * img.width;
      //float b = map(brightness(img.pixels[p]),0,255,0,100);
      float b = blue(img.pixels[p]);
      if(blue(img.pixels[p])>ma) ma = red(img.pixels[p]);
      //println(red(img.pixels[p]));
      //else img.pixels[p] = color(100,100,100,100);
      //if(red(img.pixels[p])<ma) ma = red(img.pixels[p]);
  }}
  img.updatePixels();
  //img.resize(0.5);
  return img;
};
