public boolean isColliding(Sprite s1, Sprite s2){
    if (
        s2.getLeft() < s1.getRight() + s1.change_x &&
        s2.getRight() > s1.getLeft() - s1.change_x &&
        s2.getTop() < s1.getBottom() + s1.change_y &&
        s2.getBottom() > s1.getTop() - s1.change_y
    ){
        return true;
    }
    else {
        return false;
    }
}

public boolean isColliding(DynamicSprite s1, Sprite s2){
    // Check if the next position will be a collision at all.
    if (
        s2.getLeft() < s1.getRight() &&
        s2.getRight() > s1.getLeft() &&
        s2.getTop() < s1.getBottom() &&
        s2.getBottom() > s1.getTop()
    ){
        return true;
    }
    else {
        return false;
    }
}

public void resolveCollision(Sprite s1, Sprite s2){
    // fix vertical collisions
    s1.center_y += s1.change_y;
    // Moving down
    if (s1.change_y > 0){
        if (s1.getBottom() > s2.getTop()){
            s1.setBottom(s2.getTop());
            s1.change_y = 0;
        }
    }
    // Moving up
    else if (s1.change_y < 0){
        if (s1.getTop() < s2.getBottom()){
            s1.setTop(s2.getBottom());
            s1.change_y = 0;
        }
    }

    // fix horizontal collisions
    s1.center_x += s1.change_x;
    // Moving right
    if (s1.change_x > 0){
        if (s1.getRight() > s2.getLeft()){
            s1.setRight(s2.getLeft());
            s1.change_x = 0;
        }
    }
    // Moving left
    else if (s1.change_x < 0){
        if (s1.getLeft() < s2.getRight()){
            s1.setLeft(s2.getRight());
            s1.change_x = 0;
        }
    }
}

public void resolveCollision(DynamicSprite s1, Sprite s2){
    // fix vertical collisions
    s1.center_y += s1.change_y;
    // Moving down
    if (s1.change_y > 0){
        if (s1.getBottom() > s2.getTop()){
            s1.setBottom(s2.getTop());
            s1.change_y = 0;
        }
    }
    // Moving up
    else if (s1.change_y < 0){
        if (s1.getTop() < s2.getBottom()){
            s1.setTop(s2.getBottom());
            s1.change_y = 0;
        }
    }

    // fix horizontal collisions
    s1.center_x += s1.change_x;
    // Moving right
    if (s1.change_x > 0){
        if (s1.getRight() > s2.getLeft()){
            s1.setRight(s2.getLeft());
            s1.change_x = 0;
        }
    }
    // Moving left
    else if (s1.change_x < 0){
        if (s1.getLeft() < s2.getRight()){
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

public ArrayList<Sprite> checkCollisionList(DynamicSprite s, ArrayList<Sprite> collisionList){
    ArrayList<Sprite> colliders = new ArrayList<Sprite>();
    for (Sprite item: collisionList){
        if(isColliding(s, item)){
            colliders.add(item);
        }
    }
    return colliders;
}