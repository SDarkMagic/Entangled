import controlP5.*;

class MainMenu{
    ControlP5 menu;
    Button play;
    Button next;
    Button quit;
    int center_x;
    int center_y;
    int defaultWidth;
    int defaultHeight;

    public MainMenu(PApplet sketch){
        center_x = width/2;
        center_y = height/2;
        defaultWidth = 150;
        defaultHeight = 50;
        menu = new ControlP5(sketch);
        play = menu.addButton("Play");
        next = menu.addButton("Next Level");
        quit = menu.addButton("Quit");
        play.setPosition(center_x - defaultWidth, center_y - defaultHeight).setSize(defaultWidth, defaultHeight);
        next.setPosition(center_x - defaultWidth, center_y - defaultHeight).setSize(defaultWidth, defaultHeight);
        quit.setPosition(center_x - defaultWidth, center_y - defaultHeight).setSize(defaultWidth, defaultHeight);
        next.setVisible(false);
        quit.setVisible(false);
    }

    public void hide(Button buttonToHide){
        buttonToHide.setVisible(false);
    }

    public Map loadLevel(String levelName){
        Map mapData = new Map(levelName + ".json");
        return mapData;
    }
}

void mouseClicked(){

}