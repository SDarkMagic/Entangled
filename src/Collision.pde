public boolean isColliding(Sprite s1, Sprite s2){
    boolean noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
    boolean noYOverlap = s1.getTop() >= s2.getBottom() || s1.getBottom() <= s2.getTop();
    if (noXOverlap || noYOverlap){
        return false;
    }
    else {
        return true;
    }
}

public void resolveCollision(Sprite s1, Sprite s2){
    // fix vertical collisions
    s1.center_y += s1.change_y;
    if (s1.change_y > 0){
        if (s1.getBottom() >= s2.getTop()){
            s1.setBottom(s2.getTop());
            s1.change_y = 0;
        }
    }
    else if (s1.change_y < 0){
        if (s1.getTop() <= s2.getBottom()){
            s1.setTop(s2.getBottom());
            s1.change_y = 0;
        }
    }

    // fix horizontal collisions
    s1.center_x += s1.change_x;
    if (s1.change_x > 0){
        if (s1.getRight() <= s2.getLeft()){
            s1.setRight(s2.getLeft());
            s1.change_x = 0;
        }
    }
    else if (s1.change_x < 0){
        if (s1.getLeft() >= s2.getRight()){
            s1.setLeft(s2.getRight());
            s1.change_x = 0;
        }
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
