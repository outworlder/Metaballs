// http://www.student.cs.uwaterloo.ca/~swhitmor/article_metaballs.html

int isofield_width;
int isofield_height;
int num_metaballs;
float min_threshold;
float max_threshold;

float[][] isofield;
Metaball[] metaballs;

class Metaball {
    float x;
    float y;
    float radius;

    Metaball(float x, float y, float radius) {
	this.x = x;
	this.y = y;
	this.radius = radius;
    }
};

float equation(Metaball m, float x, float y) {
    _x = m.x;
    _y = m.y;
    _radius = m.radius
	
    return (_radius / sqrt( (x-_x)*(x-_x) + (y-_y)*(y-_y) ) );
}

void calculateIsofield() {
    // Calcula a contribuição de cada metaball para a grade
    for (int x = 0; x < isofield_width; x++) {
	for (int y = 0; y < isofield_height; y++) {
	    sum = 0;
	    for (int i = 0; i < num_metaballs; i++) {
		sum += equation(metaballs[i], x, y);
	    }
	    isofield[x][y] = sum;
	}
    }
}

void setup() {
    min_threshold = 0.1;
    max_threshold = 1.01;
    metaballs = new Metaball[3];
    metaballs[0] = new Metaball(50.0,50.0,10.0);
    metaballs[1] = new Metaball(1.0,50.0,3.0);
    metaballs[2] = new Metaball(10.0,3.0,2.0);
    num_metaballs = 3;
    isofield_width = 100;
    isofield_height = 100;
    isofield = new float[isofield_width][isofield_height];
    calculateIsofield();

    size(isofield_width*4, isofield_height*4);
    background(125);
    fill(255);
    smooth();
}

void draw() {
    animateMetaballs();
    calculateIsofield();
    drawMetaballs();
}

void animateMetaballs() {
    x = metaballs[1].x;
    if (x > isofield_width + metaballs[1].radius) {
	x = 0;
    }
    else {
	x+=1;
    }
    
    metaballs[1].x = x;
}

void drawMetaballs() {
    for (int x = 0, ix = 0; x < isofield_width; ix+=4, x++) {
    	for (int y = 0, iy = 0; y < isofield_height; iy+=4, y++) {
    	    // Calcula influencia de cada metaball no pixel
	    intensity = isofield[x][y];
	    value = min(intensity*255,255);
	    // if (intensity >= min_threshold && intensity <= max_threshold) {
	    // 	value = 255-min(intensity*255,255);
	    // } else {
	    // 	value = 255;
	    // }
    	    // Desenha o pixel
    	    stroke(value);
    	    fill(value);
    	    rect(ix,iy, 4,4);
    	}
    }
}
