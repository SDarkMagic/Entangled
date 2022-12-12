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
    String title;
    String subtitle;
    Button play;

    public MainMenu(PApplet sketch, String text, String text2){
        super(sketch);
        title = text;
        subtitle = text2;
        super.addButton("Play");
        play = super.getButton("Play");
        play.setPosition(center_x - defaultWidth, center_y).setSize(defaultWidth, defaultHeight);
    }

    public void display(){
        image(loadImage("entanglement.jpg"), center_x, center_y, width, height);
        textSize(128);
        text(title, center_x, center_y - 250);
        textSize(64);
        text(subtitle, center_x, center_y - 100);
    }
}

class PostLevelMenu extends Menu{
    Button next;
    Button quit;

    public PostLevelMenu(PApplet sketch){
        super(sketch);
        super.addButton("Next");
        super.addButton("Quit");
        next = super.getButton("Next");
        quit = super.getButton("Quit");
        next.setPosition(center_x - defaultWidth, center_y - 50).setSize(defaultWidth, defaultHeight);
        quit.setPosition(center_x - defaultWidth, center_y + 50).setSize(defaultWidth, defaultHeight);
        hide(next);
        hide(quit);
    }

    public void hideMenu(){
        hide(next);
        hide(quit);
    }

    public void display(){
        textSize(64);
        text("Continue to Next Level?", center_x, center_y - 100);
        next.setVisible(true);
        quit.setVisible(true);
    }
}