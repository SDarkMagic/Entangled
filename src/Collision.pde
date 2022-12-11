public boolean isColliding(Sprite s1, Sprite s2){
    if (
        s2.getLeft() < s1.getRight() + s1.change_x &&
        s2.getRight() > s1.getLeft() + s1.change_x &&
        s2.getTop() < s1.getBottom() + s1.change_y &&
        s2.getBottom() > s1.getTop() + s1.change_y
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
        s2.getLeft() < s1.getRight() + s1.change_x &&
        s2.getRight() > s1.getLeft() + s1.change_x &&
        s2.getTop() < s1.getBottom() + s1.change_y &&
        s2.getBottom() > s1.getTop() + s1.change_y
    ){
        return true;
    }
    else {
        return false;
    }
}

public boolean isColliding(DynamicSprite s1, DynamicSprite s2){
    // Check if the next position will be a collision at all.
    if (
        s2.getLeft() < s1.getRight() + s1.change_x &&
        s2.getRight() > s1.getLeft() + s1.change_x &&
        s2.getTop() < s1.getBottom() + s1.change_y &&
        s2.getBottom() > s1.getTop() + s1.change_y
    ){
        return true;
    }
    else {
        return false;
    }
}

public boolean ensureInBounds(DynamicSprite s1, ArrayList<Actor> boundaries){
    boolean colliding = false;
    for (Actor boundary: boundaries){
        if (
        boundary.getTop() < s1.getBottom() + s1.change_y &&
        boundary.getBottom() > s1.getTop() + s1.change_y
        ){
            colliding = true;
            if (s1.change_y > 0){
                if (s1.getBottom() + s1.change_y > boundary.getTop()){
                    s1.setBottom(boundary.getTop());
                    s1.change_y = 0;
                }
            }
            // Moving up
            else if (s1.change_y < 0){
                if (s1.getTop() + s1.change_y < boundary.getBottom()){
                    s1.setTop(boundary.getBottom());
                    s1.change_y = 0;
                }
            }
        }
    }
    return colliding;
}

// Fix weird snapping issues with resolveCollision functions
public void resolveCollision(Sprite s1, Sprite s2){
    // Moving down
    if (s1.change_y > 0){
        if (s1.getBottom() + s1.change_y > s2.getTop()){
            s1.setBottom(s2.getTop());
            s1.change_y = 0;
        }
    }
    // Moving up
    else if (s1.change_y < 0){
        if (s1.getTop() + s1.change_y < s2.getBottom()){
            s1.setTop(s2.getBottom());
            s1.change_y = 0;
        }
    }

    // Moving right
    if (s1.change_x > 0){
        if (s1.getRight() + s1.change_x > s2.getLeft()){
            s1.setRight(s2.getLeft());
            s1.change_x = 0;
        }
    }
    // Moving left
    else if (s1.change_x < 0){
        if (s1.getLeft() + s1.change_x < s2.getRight()){
            s1.setLeft(s2.getRight());
            s1.change_x = 0;
        }
    }
}

public void resolveCollision(DynamicSprite s1, Sprite s2){
    // Moving down
    if (s1.change_y > 0){
        if (s1.getBottom() + s1.change_y > s2.getTop()){
            s1.setBottom(s2.getTop());
            s1.change_y = 0;
        }
    }
    // Moving up
    else if (s1.change_y < 0){
        if (s1.getTop() + s1.change_y < s2.getBottom()){
            s1.setTop(s2.getBottom());
            s1.change_y = 0;
        }
    }

    // Moving right
    if (s1.change_x > 0){
        if (s1.getRight() + s1.change_x > s2.getLeft()){
            s1.setRight(s2.getLeft());
            s1.change_x = 0;
        }
    }
    // Moving left
    else if (s1.change_x < 0){
        if (s1.getLeft() + s1.change_x < s2.getRight()){
            s1.setLeft(s2.getRight());
            s1.change_x = 0;
        }
    }
}

public void resolveCollision(DynamicSprite s1, DynamicSprite s2){
    // Moving down
    if (s1.change_y > 0){
        if (s1.getBottom() + s1.change_y > s2.getTop()){
            s1.setBottom(s2.getTop());
            s1.change_y = 0;
        }
    }
    // Moving up
    else if (s1.change_y < 0){
        if (s1.getTop() + s1.change_y < s2.getBottom()){
            s1.setTop(s2.getBottom());
            s1.change_y = 0;
        }
    }

    // Moving right
    if (s1.change_x > 0){
        if (s1.getRight() + s1.change_x > s2.getLeft()){
            s1.setRight(s2.getLeft());
            s1.change_x = 0;
        }
    }
    // Moving left
    else if (s1.change_x < 0){
        if (s1.getLeft() + s1.change_x < s2.getRight()){
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

public ArrayList<DynamicSprite> checkCollisionList(DynamicSprite s, ArrayList<DynamicSprite> collisionList){
    ArrayList<DynamicSprite> colliders = new ArrayList<DynamicSprite>();
    for (DynamicSprite item: collisionList){
        if(isColliding(s, item)){
            colliders.add(item);
        }
    }
    return colliders;
}