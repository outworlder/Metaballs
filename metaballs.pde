// http://www.student.cs.uwaterloo.ca/~swhitmor/article_metaballs.html

int isofield_width;
int isofield_height;
float isofield_max;

int num_metaballs;
float min_threshold;
float max_threshold;
float[][] isofield;
int[][] squares;
Metaball[] metaballs;

class Metaball {
    public float x;
    public float y;
    public float radius;

    Metaball(float x, float y, float radius) {
	this.x = x;
	this.y = y;
	this.radius = radius;
    }
};

float equation(Metaball m, float x, float y) {
    float _x = m.x;
    float _y = m.y;
    float _radius = m.radius;
	
    return (_radius / sqrt( (x-_x)*(x-_x) + (y-_y)*(y-_y) ) );
}

void calculateIsofield() {
    isofield_max = 0;
    // Calcula a contribuição de cada metaball para a grade
    for (int x = 0; x < isofield_width; x++) {
	for (int y = 0; y < isofield_height; y++) {
	    float sum = 0;
	    for (int i = 0; i < num_metaballs; i++) {
		sum += equation(metaballs[i], x, y);
	    }
	    isofield[x][y] = sum;
	    if (sum > isofield_max) {
		isofield_max = sum;
	    }
	}
    }
}

void marchingSquares() {
    float threshold = min_threshold;
    boolean[] v;
    squares = new int[isofield_width-1][isofield_height-1];
  
    for (int x = 0; x < isofield_width-1; x++) {
      for (int y = 0; y < isofield_height-1; y++, squares++) {
        int type = 0;
        // Calculando os vertices acima do threshold
        if (isofield[x][y] >= threshold) {
          squares[x][y] = squares[x][y] || 1;
        }
        if (isofield[x+1][y] >= threshold) {
          squares[x][y] = squares[x][y] || 2;
        }
        if (isofield[x][y+1] >= threshold) {
          squares[x][y] = squares[x][y] || 4;
        }
        if (isofield[x+1][y+1] >= threshold) {
          squares[x][y] = squares[x][y] || 8;
        }
      }
    }
}

void setup() {
    min_threshold = 0.85;
    max_threshold = 1.05;
    metaballs = new Metaball[3];
    metaballs[0] = new Metaball(50.0,50.0,10.0);
    metaballs[1] = new Metaball(1.0,50.0,3.0);
    metaballs[2] = new Metaball(10.0,3.0,2.0);
    num_metaballs = 3;
    isofield_width = 100;
    isofield_height = 100;
    isofield = new float[isofield_width][isofield_height];
    calculateIsofield();

    size(isofield_width*8, isofield_height*8, P2D);
    background(125);
    fill(255);
    smooth();
    noLoop();
    noStroke();
}

void draw() {
    //animateMetaballs();
    calculateIsofield();
    drawMetaballs();
}

void mousePressed() {
    int cx;
    int cy;
    if (mouseX == 0) {
	cx = 0;
    } else {
	cx = mouseX/8;
    }
    if (mouseY == 0) {
	cy = 0;
    } else {
	cy = mouseY/8;
    }
    
    metaballs[1].x = cx;
    metaballs[1].y = cy;
    redraw();
}

void animateMetaballs() {
//    x = metaballs[1].x;
//   if (x > isofield_width + metaballs[1].radius) {
//	x = 0;
//    }
//    else {
//	x+=1;
//    }
//    
//    metaballs[1].x = x;
}

void drawMetaballs() {
    float intensity;
    float value;
    for (int x = 0, ix = 0; x < isofield_width-1; ix+=8, x++) {
    	for (int y = 0, iy = 0; y < isofield_height-1; iy+=8, y++) {
          int type = squares[x][y];
          switch (type) {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
            case 15:
          }
    	}
    }
}
