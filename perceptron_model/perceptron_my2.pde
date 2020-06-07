
float[] inputx = new float[200];            
float[] inputy = new float[200];
int[] tar = new int[200];                //target
int[] ans = new int[200];                                          //answer by ML
float[] w = new float[3];                                          //weights for ML  
float lr=.05,m=0,c=0;                                              //learing rate,y=mx+c(m,c of pradict line)  
float Eqline( float m, float c ,float x,float y)
{
  float f=y-m*x-c;                                                 //equation of line (main line)
  return f;
}
void setup()
{
  size(800,400);
  for (int i=0;i<inputx.length;i++)
  {
    ans[i]=0;
    inputx[i]=random(-(width/2),width/2);
    inputy[i]=random(-height/2,height/2);
    float line = Eqline(5,200,inputx[i],inputy[i]);               //*** change in equation of line (main line)***
    if(0>line)
        tar[i] = 1;                                                // fixed target value=-1 or 1
    else 
        tar[i] = -1;    
  }
    for(int i=0;i<w.length;i++)
    {
      w[i]=random(-1,1);                                            //random value to weigths
    }     
}


void draw()
{
  background(255);
  for(int i=0;i<inputx.length;i++)
  {
    display(i);
  }
  fill(0,255,0);
  line(0,map(m*(-(width/2))+c,-(height/2),height/2,0,height),width,map(m*(width/2)+c,-(height/2),height/2,0,height));                    //draw pradict line 
  check();                                                                                             //check that answer from pradiction is equal to target
  println(w[0],w[1],w[2],c,mouseX,mouseY);
}

void display(int i)
{
  if(tar[i] == 1)
  {
    stroke(0);
    fill(0);
  }  
  else
  {
    stroke(0,0,255);
    fill(0,0,255);
  }
  float x= map(inputx[i],-width/2,width/2,0,width);
  float y= map(inputy[i],-height/2,height/2,height,0);

  ellipse(x,y,16,16);
  
}

void update(int i)
{
  float sum=0;
  sum = inputx[i]*w[0] + inputy[i]*w[1] + w[2];
  ans[i]= sign(sum);
  
  int error = tar[i] -ans[i];
  w[0] = w[0] + error*inputx[i]*lr;
  w[1] = w[1] + error*inputy[i]*lr;
  w[2] = w[2] +error*lr;
  m=w[0]/w[1];                                                          //update m,c;
  c=w[2]/w[1];
}

void check()
{
  for(int i=0;i<inputx.length;i++)
  {
    if(tar[i] == ans[i])
    {
      fill(0,255,0);
    }
    else
      fill(255,0,0);
    float x= map(inputx[i],-width/2,width/2,0,width);
    float y= map(inputy[i],-height/2,height/2,height,0);

    ellipse(x,y,9,9);  
  }
}

void mousePressed()
{
  for(int j=0;j<50;j++)
  {  
    for(int i=0;i<inputx.length;i++)
    {
      update(i);
    }
  }
}




int sign(float n)
{
  if (n>=0)  return 1;
  return -1;  
}


