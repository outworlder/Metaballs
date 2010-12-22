// http://www.student.cs.uwaterloo.ca/~swhitmor/article_metaballs.html

float[] metaballs;

void setup() {
    size(400, 400);
    background(125);
    fill(255);
    smooth();
}

void draw() {
    //ellipse(mouseX, mouseY, 40, 40);
    drawMetaballs();
}

void drawMetaballs() {
    for (int x = 0; x < width; x = x + 4) {
	for (int y = 0; y < width; y = y + 4) {
	    // Calcula influencia de cada metaball no pixel
	    value = max(random()*255,0);
	    // Desenha o pixel
	    stroke(value);
	    fill(value);
	    rect(x,y, 4,4);
	//pixels[p] = influence;
	}
    }
}