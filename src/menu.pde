import controlP5.*;
import java.util.Map;

class Menu{
    ControlP5 menu;
    int center_x;
    int center_y;
    int defaultWidth;
    int defaultHeight;
    HashMap<String,Button> menuButtons;

    public Menu(PApplet sketch){
        menu = new ControlP5(sketch);
        center_x = width/2;
        center_y = height/2;
        defaultWidth = 150;
        defaultHeight = 50;
        menuButtons = new HashMap<String, Button>();
    }

    public Map loadLevel(String levelName){
        Map mapData = new Map("maps/" + levelName + ".json");
        return mapData;
    }

    public void hide(Button buttonToHide){
        buttonToHide.setVisible(false);
    }

    public void addButton(String name){
        menuButtons.put(name, menu.addButton(name));
    }

    public Button getButton(String name){
        return menuButtons.get(name);
    }
}

class MainMenu extends Menu{
    Button play;

    public MainMenu(PApplet sketch){
        super(sketch);
        super.addButton("Play");
        play = super.getButton("Play");
        play.setPosition(center_x - defaultWidth, center_y - defaultHeight).setSize(defaultWidth, defaultHeight);
    }

    public void display(){

    }
}

void mouseClicked(){

}