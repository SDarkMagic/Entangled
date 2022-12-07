public boolean isColliding(Sprite s1, Sprite s2){
    boolean xOverlap = s1.getRight() >= s2.getLeft() || s1.getLeft() <= s2.getRight();
    boolean yOverlap = s1.getTop() <= s2.getBottom() || s1.getBottom() >= s2.getTop();
    if (xOverlap || yOverlap){
        return true;
    }
    else {
        return false;
    }
}

public ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> collisionList){
    ArrayList<Sprite> colliders = new ArrayList<Sprite>();
    for (Sprite item: collisionList){
        if(isColliding(s, item)){
            colliders.add(item);
        }
    }
    return colliders;
}
