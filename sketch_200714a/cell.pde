class cell{
  float x,y,h,res,w,ry,rows_,cols_;
  int id,xpos,ypos,walls,parent = -1,chainid=-1,counter,cols,rows;
  boolean visited,wall,link,edge,border,v1,v2,v3,v4;
  ArrayList <cell> cells;
  ArrayList <cell> neighbours = new ArrayList<cell>();
  ArrayList <cell> neighbours2 = new ArrayList<cell>();
  ArrayList< ArrayList<cell>> regions = new ArrayList<ArrayList<cell>>();
  ArrayList< ArrayList<cell>> wallRegions = new ArrayList<ArrayList<cell>>();
  ArrayList< ArrayList<cell>> sortedEdges = new ArrayList<ArrayList<cell>>();
  ArrayList< ArrayList<cell>> unsortedEdges = new ArrayList<ArrayList<cell>>();
  
  ArrayList<cell> region = new ArrayList<cell>();
  ArrayList<cell> edges = new ArrayList<cell>();
  ArrayList <Boolean> wallFlags = new ArrayList<Boolean>();
  ArrayList <Boolean> wallFlags2 = new ArrayList<Boolean>();
  ArrayList <Boolean> vertices = new ArrayList<Boolean>();
  color col = color(random(255),random(255),random(255));
  
  cell(int a,int b){
    cols = a;
    rows = b;
    rows_ = float(b);
    cells = new ArrayList<cell>();
    w = width;
    h = height;
    res = width/cols;
    ry = height/100.0;
    counter = rows * cols -1;
    
    for(int i=0;i<cols;i++){
      for(int j=0;j<rows;j++){
        int p = j + i * cols;
        float h = floor(random(100));
        cell c = new cell(p,res*i,ry*j,j,i,h,this);
        if(h>cutoff)c.wall = true;
        else c.wall = false;
        cells.add(c); 
    }}
  };
  
  cell(PImage img,int a,int b){
    cols = a;
    rows = b;
    //cols = img.width;
    //rows = img.height;
    rows_ = float(rows);
    cols_ = float(cols);
    cells = new ArrayList<cell>();
    w = width;
    h = H;
    res = img.width/cols_;
    //res = 1;
    ry = img.height/rows;
    //ry = 1;
    counter = rows * cols -1;
    
    float n = map(cutoff,0,100,0,255);
      for(int i=0;i<cols;i++){
        for(int j=0;j<rows;j++){
          int p = int(i*res + j*ry * img.width);
          if(p<img.pixels.length){
            float r = red(img.pixels[p]);
            float g = green(img.pixels[p]);
            float bb = blue(img.pixels[p]);
            float br = brightness(img.pixels[p]);
            float h = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
            //h = ;
            //if(r>h)h = r;
            //if(g>h)h = g;
            //if(bb>h)h = bb;
            //if(br>h)h = br;
            //h = map(blue(img.pixels[p]),0,ma,0,100);
            println(h);
            cell c = new cell(p,img.width/cols*i,img.height/rows*j,j,i,h,this);
            if(h>n)c.wall = true;
            else c.wall = false;
            cells.add(c); 
    }}}
  };
  
  cell(int id,float x,float y,int xpos,int ypos,float h,cell c){
    this.id = id;
    this.x = x;
    this.y = y;
    this.h = h;
    this.xpos = xpos;
    this.ypos = ypos;
    res = c.res;
    ry = c.ry;
    //for(int i=0;i<4;i++){
    //  wallFlags.add(true);
    //}
  };
  
  void connectWalls(){
    
  };
  
  void getNeighbours(){
    
     for(int k=0;k<cells.size();k++){
        cell c1 = cells.get(k);
        
        for(int i=c1.xpos-1;i<=c1.xpos+1;i++){
          for(int j=c1.ypos-1;j<=c1.ypos+1;j++){
            int p = i+j * cols;
            
            if(i>=0&&i<cols&&j>=0&&j<rows){
              cell c2 = cells.get(p);
              if(c2!=c1){
                
                if((c1.xpos==c2.xpos||c1.ypos==c2.ypos)){
                  if(!c1.neighbours.contains(c2))c1.neighbours.add(c2);
                }
                if(!c1.neighbours2.contains(c2))c1.neighbours2.add(c2);
              }
          }else {
            c1.neighbours2.add(null);
            c1.neighbours.add(null);
          }}}}
  };
  
  void findSpaces(){
    cell c = null;
    while(counter>=0){
      c = cells.get(counter);
      queue = new ArrayList<cell>();
      
      if(!c.visited&&!c.wall){
        queue.add(c);
        temp = new ArrayList<cell>();
        temp2 = new ArrayList<cell>();
        while(queue.size()>0){
          c = queue.get(0);
          int w = 0;
          if(!temp2.contains(c)){
            temp.add(c);
            temp2.add(c);
          }
          if(!c.visited&&!c.wall){
          c.visited = true;
          
          for(int i=0;i<c.neighbours.size();i++){
              
              cell c1 = c.neighbours.get(i);
              if(c1!=null){
                if(c1.wall){
                  w++;
                }else if(!queue.contains(c1)&&!c1.visited)queue.add(c1);
           }else w++;}}
           c.walls = w;
           if(temp.size()>0){
             int count = 0;
             for(int i=0;i<regions.size();i++){
               //for(int j=0;j<temp.size();j++){
                if(regions.get(i).contains(temp2.get(0)))count ++;
                break;
              }
             if(count==0){
                 regions.add(temp);
                 c.region = temp;
             }
           }
           if(queue.size()>=1){
             c = queue.remove(0);
             
        }}}else counter --;
    }
    
    for(int i=0;i<regions.size();i++){
      if(regions.get(i).size()<minr||regions.get(i).size()>maxr){
        //println("remove regions " + regions.get(i).size());
        for(int j=0;j<regions.get(i).size();j++){
          cell c1 = regions.get(i).get(j);
          c1.visited = false;
          c1.wall = true;
        }
      }
      //else println("inner regions " + regions.get(i).size());
    }
    regions = new ArrayList<ArrayList<cell>>();
  };
  
  void findWalls(){
    cell c = null;
    counter = rows * cols - 1;
    while(counter>=0){
      c = cells.get(counter);
      queue = new ArrayList<cell>();
      
      if(!c.v1&&c.wall){
        queue.add(c);
        temp = new ArrayList<cell>();
        temp2 = new ArrayList<cell>();
        while(queue.size()>0){
          c = queue.get(0);
          int w = 0;
          if(!temp2.contains(c)){
            temp.add(c);
            temp2.add(c);
          }
          if(!c.v1){
          c.v1 = true;
          
          for(int i=0;i<c.neighbours.size();i++){
            
              cell c1 = c.neighbours.get(i);
              if(c1!=null){
                  if(!c1.wall){
                    w++;
                  }else {
                    if(!temp2.contains(c1)){
                      queue.add(c1);
            }}}else w++;}
            
          }else if(!c.wall)c.v1 = true;
                          
           c.walls = w;
           if(temp.size()>0){
           
             int count = 0;
             for(int i=0;i<wallRegions.size();i++){
               //for(int j=0;j<temp2.size();j++){
                if(wallRegions.get(i).contains(temp2.get(0))){
                  count ++;
                  break;
                }}
             if(count==0){
                   wallRegions.add(temp);
                   c.region = temp;
             }
           }
           if(queue.size()>=1){
             c = queue.remove(0);
             
        }}}else counter --;
    }
    
    for(int i=wallRegions.size()-1;i>-1;i--){
      if(wallRegions.get(i).size()<minwr||wallRegions.get(i).size()>maxwr){
        
        for(int j=0;j<wallRegions.get(i).size();j++){
          cell c1 = wallRegions.get(i).get(j);
          c1.visited = false;
          c1.wall = false;
        }
        wallRegions.remove(i);
      }
      //else println("wall inner regions " + wallRegions.get(i).size());
    }
  
    println("wall regions " + wallRegions.size());
    println("regions " + regions.size());
    regions = new ArrayList<ArrayList<cell>>();
  };
  
  void findEdges(){
    cell c = null;
    counter = cols * rows -1;
    while(counter>=0){
      c = cells.get(counter);
      queue = new ArrayList<cell>();
      
      if(!c.v2&&!c.wall){
        queue.add(c);
        temp = new ArrayList<cell>();
        temp2 = new ArrayList<cell>();
        temp3 = new ArrayList<cell>();
        while(queue.size()>0){
          c = queue.get(0);
          int w = 0;
          temp.add(c);
          temp3.add(c);
          if(!c.v2){
          c.v2 = true;
          
          for(int i=0;i<c.neighbours2.size();i++){
            
              cell c1 = c.neighbours2.get(i);
              if(c1!=null){
                if(c1.wall){
                  w++;
                }else if(!temp3.contains(c1)&&!c1.v2)queue.add(c1);
          }else w++;}
          c.walls = w;
          if(w>0){
            c.edge = true;
            if(!temp2.contains(c))temp2.add(c);
          }}else if(c.wall)c.v2 = true;
          if(queue.size()>0){
             c = queue.remove(0);
          }}
        
        if(temp.size()>0){
              
             int count = 0;
             for(int i=0;i<regions.size();i++){
               //for(int j=0;j<temp3.size();j++){
                if(regions.get(i).contains(temp3.get(0))){
                  count ++;
                  break;
                }}
             if(count==0){
                 
                 for(int i=temp2.size()-1;i>-1;i--){
                   if(!temp2.get(i).edge)temp2.remove(i);
                 }
                 unsortedEdges.add(temp2);
                 regions.add(temp);
                 c.region = temp;
             }
           }
        }else counter --;
    }
    println("wall regions " + wallRegions.size());
    println("regions " + regions.size());
    
  };
  
  void sortEdges(){
     cell c = null;
     for(int i=unsortedEdges.size()-1;i>-1;i--){
        
        //println("region "+ i + " " + regions.get(i).size());
        if(unsortedEdges.get(i).size()>0){
          //println("adding edge " + unsortedEdges.get(i).size() +" " + unsortedEdges.get(i).size());
        for(int j=0;j<unsortedEdges.get(i).size();j++){
          c = unsortedEdges.get(i).get(j);
          c.visited = false;
          c.edge = true;
        }}
        else unsortedEdges.remove(i);
        
      }
      //regions = new ArrayList<ArrayList<cell>>();
      for(int i=0;i<unsortedEdges.size();i++){
          c = null;
          //println("Unsorted size " + unsortedEdges.get(i).size());
          while(unsortedEdges.get(i).size()>0){
            c = unsortedEdges.get(i).remove(0);
            queue = new ArrayList<cell>();
            temp = new ArrayList<cell>();
            temp2 = new ArrayList<cell>();
            if(!c.v4&&c.edge){
              queue.add(c);
              temp2.add(c);
              //c.connect();
              while(queue.size()>0){
                c = queue.get(0);
                int w = 0;
                if(!temp.contains(c))temp.add(c);
                if(!c.v4){
                c.v4 = true;
                for(int j=0;j<c.neighbours.size();j++){
                  
                    cell c1 = c.neighbours.get(j);
                    if(c1!=null){
                      if(c1.wall){
                        w++;
                      }
                      if(c1.edge&&!c1.v4)queue.add(c1);
                }else w++;}
                c.walls = w;
                if(w>0)c.edge = true;
                }else if(!c.edge)c.v4 = true;
                if(temp.size()>0){
                  
                  int count = 0;
                  for(int j=0;j<sortedEdges.size();j++){
                    
                    if(sortedEdges.get(j).contains(temp.get(0))){
                      count ++ ;
                      break;
                    }
                  }
                if(count==0){
                  sortedEdges.add(temp);
                  c.edges = temp;
                }}
                if(queue.size()>=1){
                  c = queue.remove(0);
                 }
        
      }}if(!c.edge)c.v4 = true;
    }}
    println("sorted " + sortedEdges.size());
    println("wall regions " + wallRegions.size());
    println("regions " + regions.size());
    println("Begin");
  };
  
  void draw(){
    
    fill(0,0,255);
    rect(0,0,width,height);
    fill(0);
    //for(int i=0;i<regions.size();i++){
    //  //text(regions.size(),40,10);
    //  for(int j=0;j<regions.get(i).size();j++){
    //    cell c = regions.get(i).get(j);
    //    c.display();
    //    //text(i,c.x + res/2,c.y + ry/2);
    //}}
    int p = floor(map(mouseX,0,width,0,sortedEdges.size()));
    text(p,200,100);
    for(int i=0;i<sortedEdges.size();i++){
      for(int j=0;j<sortedEdges.get(i).size();j++){
        cell c = sortedEdges.get(i).get(j);
        //if(p==i)
        c.display();
        //c.debug();
        
        //if(c.edges!=null)c.display2();
        //text(j,c.x + r/2,c.y + ry/2);
      }
    }
    fill(255);
    
    //for(int i=0;i<cells.size();i++){
    //  cell c = cells.get(i);
    //  //println(str(c.wall));
    //  //if(mousePressed)
    //  //if(mousePressed)c.display2();
    //  c.display();
    //  //text(i,c.x + res/2,c.y + ry/2);
    //  //if(c.edge&&!c.wall)c.display3();
    //}
    
    fill(0);
    //text("regions " + regions.size(),110,20);
    //for(int i=0;i<regions.size();i++){
    //  text(regions.get(i).size(),110,30+10*i);
    //}
    //fill(0);
    //text("wall Regions " + wallRegions.size(),190,20);
    for(int i=0;i<wallRegions.size();i++){
      //text(wallRegions.get(i).size(),190,30+10*i);
      for(int j=0;j<wallRegions.get(i).size();j++){
        cell c = wallRegions.get(i).get(j);
        c.display();
      }
    }
    fill(0);
    if(mousePressed)fill(255);
    text("sorted Edges " + sortedEdges.size(),100,20);
    
      for(int i=0;i<sortedEdges.size();i++){
        //println(sortedEdges.get(i).size());
        text(sortedEdges.get(i).size(),10+40,30+10*i);
      }
      
    //  for(int i=0;i<sortedEdges.size();i++){
    //  for(int j=0;j<sortedEdges.get(i).size();j++){
    //    cell c = sortedEdges.get(i).get(j);
    //    c.display();
    //    c.debug();
    //    //text(j,c.x + r/2,c.y + ry/2);
    //  }
    //}
  };
  
  void displayNeighbours(){
    for(int i =0;i<neighbours.size();i++){
      cell c = neighbours.get(i);
      if(c!=null)c.display3();
    }
  };
  
  void display(){
    //ry = 6.6;
    if(!wall){
      
      noStroke();
      
      fill(0,0,255);
      if(edge&&mousePressed)fill(255,0,255);
      //if(link)fill(0,0,0);
      rect(x,y,res,ry);
    }
    else{
      noStroke();
      
      fill(0);
      //if(edges.size()>0)fill(255,0,0);
      rect(x,y,res,ry);
    }
    //stroke(0);
    //drawWalls();
  };
  
  void display2(){
    fill(0);
    rect(x,y,res,ry);
  };
  
  void display3(){
    stroke(0);
    noFill();
    rect(x,y,res,ry);
  };
  
  //boolean pos(){
  //  //return
  //};
  
  void debug(){
    noStroke();
    if(mouseX>x&&mouseX<x+res&&mouseY>y&&mouseY<y+ry){
      
      for(int i=0;i<neighbours2.size();i++){
        cell c = neighbours2.get(i);
        fill(255,0,0,100);
        if(c!=null)rect(c.x,c.y,res,ry);
      }
    }  
  };
  
  void drawWalls(){
    stroke(0);
    strokeWeight(1);
    //if(wallFlags.size()>0)println(wallFlags.size());
    for(int i=0;i<wallFlags.size();i++){
      
       boolean b = wallFlags.get(i);
       cell c = neighbours.get(i);
       if(!b&&edge){
           text(chainid,x + res/2,y +ry/2);
           if(c.xpos<xpos){
             
             //line(x,y,x,y+ry);
             //vertex(x,y);
             //vertex(x,y+ry);
           }
           if(c.xpos>xpos){
             //line(x+r,y,x+r,y+ry);
             //vertex(x+r,y);
             //vertex(x+r,y+ry);
           }
           if(c.ypos<ypos){
             //line(x,y,x+r,y);
             //vertex(x,y);
             //vertex(x+r,y);
           }
           if(c.ypos>ypos){
             line(x,y+ry,x+res,y+ry);
             //vertex(x,y+ry);
             //vertex(x+r,y+ry);
           }
               
       }
    }
  };
  void connect(){
    stroke(0);
    strokeWeight(1);
    fill(0);
    //if(region.size()>0)text(region.size(),x + r/2,y+res/2);
    //rect(x,y,res,ry);
    
    for(int i=0;i<region.size();i++){
      cell c = region.get(i);
      //c.col = col;
      c.link = true;
      c.parent = id;
      //if(line(x+res/2,y+res/2,c.x+res/2,c.y+res/2);
    }
  };
  
  
};
