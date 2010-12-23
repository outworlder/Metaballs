// http://www.student.cs.uwaterloo.ca/~swhitmor/article_metaballs.html

int isofield_width;
int isofield_height;
float isofield_max;

int num_metaballs;
float min_threshold;
float max_threshold;
float[][] isofield;
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
    for (int x = 0, ix = 0; x < isofield_width; ix+=8, x++) {
    	for (int y = 0, iy = 0; y < isofield_height; iy+=8, y++) {
    	    // Calcula influencia de cada metaball no pixel
	    intensity = isofield[x][y];
	    //value = min(intensity*255,255);
	     if (intensity >= min_threshold && intensity <= max_threshold) {
	     	value = min(intensity*255,255);
	     } else {
	     	value = 0;
	     }
    	    // Desenha o pixel
    	    stroke(value);
    	    fill(value);
    	    rect(ix,iy, 8,8);
    	}
    }
}
