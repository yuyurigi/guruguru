import java.util.Calendar;

PImage source;

float radius = 10;     // 最初の円の半径
float thickness = 0.2; //線の太さの最小値
float thickMax = 5.2;  //線の太さの最大値
float addAng = 5;
float addRadius = 0.1;

void setup(){
size(800, 800);
background(241, 240, 238); // 背景色
stroke(0);                 // 線の色
int centx = width/2;       // 円の中心値
int centy = height/2;
float lastRadius = width/2 - 18; // 最後の円の半径
float rot = ((lastRadius) / addRadius ) * addAng;

source = loadImage("image.jpg");  // 画像をロード
source.resize(width, height); // 画面サイズに画像をリサイズ
source.loadPixels();

float x, y;
float lastx = -999;
float lasty = -999;
for (float ang = 0; ang <= rot; ang +=addAng){
  radius += addRadius;
  float rad = radians(ang);
  x = centx + (radius * cos(rad));
  y = centy + (radius * sin(rad));
  int pos = (int(y) * source.width) + int(x);
  // 画像の色を取得
  color c = source.pixels[pos];
  // 暗い色を太い線に、明るい色を細い線にする
  float b = map(brightness(c), 0, 255, thickMax, thickness);
  if( lastx > -999){
    strokeWeight(b);
    line(x, y, lastx, lasty);
  }
  lastx = x;
  lasty = y;
}
}

void draw(){
}

void keyReleased() {
  // 画面を画像に保存
  if (key == 's' || key == 'S')saveFrame(timestamp()+"_####.png");
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
