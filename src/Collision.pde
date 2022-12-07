public boolean isColliding(Sprite s1, Sprite s2){
    boolean xOverlap = s1.getRight() >= s2.getLeft() || s1.getLeft() <= s2.getRight();
    boolean yOverlap = s1.getTop() >= s2.getBottom() || s1.getBottom() <= s2.getTop();
    if (!xOverlap || !yOverlap){
        return true;
    }
    else {
        return false;
    }
}

// Checks all four sides of both input sprites and returnes an arraylist containing a number for each side of s1 that has a collision
public IntList getCollidingEdges(Sprite s1, Sprite s2){
    IntList sides = new IntList();
    if (s1.getRight() >= s2.getLeft()){
        sides.append(1);
    }
    if (s1.getLeft() <= s2.getRight()){
        sides.append(3);
    }
    if (s1.getTop() >= s2.getBottom()){
        sides.append(0);
    }
    if (s1.getBottom() <= s2.getTop()){
        sides.append(2);
    }
    return sides;
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
