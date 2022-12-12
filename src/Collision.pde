public boolean isColliding(Actor s1, Actor s2){
    if (s2.getTop() >= s1.getBottom() + s1.change_y ||
        s2.getBottom() <= s1.getTop() - s1.change_y ||
        s2.getRight() <= s1.getLeft() - s1.change_x ||
        s2.getLeft() >= s1.getRight() + s1.change_x
    ){
        return false;
    }
    else {
        return true;
    }
}

public boolean isColliding(DynamicActor s1, Actor s2){
    // Check if the next position will be a collision at all.
    if (s2.getTop() >= s1.getBottom() + s1.change_y ||
        s2.getBottom() <= s1.getTop() - s1.change_y ||
        s2.getRight() <= s1.getLeft() - s1.change_x ||
        s2.getLeft() >= s1.getRight() + s1.change_x
    ){
        return false;
    }
    else {
        return true;
    }
}

public boolean isColliding(DynamicActor s1, DynamicActor s2){
    // Check if the next position will be a collision at all.
    if (s2.getTop() >= s1.getBottom() + s1.change_y ||
        s2.getBottom() <= s1.getTop() - s1.change_y ||
        s2.getRight() <= s1.getLeft() - s1.change_x ||
        s2.getLeft() >= s1.getRight() + s1.change_x
    ){
        return false;
    }
    else {
        return true;
    }
}

public int ensureInBounds(DynamicActor s1, ArrayList<Actor> boundaries){
    int colliding = 0;
    for (Actor boundary: boundaries){
        if (
        boundary.getTop() < s1.getBottom() + s1.change_y &&
        boundary.getBottom() > s1.getTop() + s1.change_y
        ){
            colliding = 1;
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
public void resolveCollision(Actor s1, Actor s2){
    // Moving down
    if (s1.change_y > 0){
        s1.setBottom(s2.getTop());
        s1.change_y = 0;
    }
    // Moving up
    else if (s1.change_y < 0){
        s1.setTop(s2.getBottom());
        s1.change_y = 0;
    }

    // Moving right
    else if (s1.change_x > 0){
        s1.setRight(s2.getLeft());
        s1.change_x = 0;
    }
    // Moving left
    else if (s1.change_x < 0){
        s1.setLeft(s2.getRight());
        s1.change_x = 0;
    }
}

public void resolveCollision(DynamicActor s1, Actor s2){
    // Moving down
    if (s1.change_y > 0){
        s1.setBottom(s2.getTop());
        s1.change_y = 0;
    }
    // Moving up
    else if (s1.change_y < 0){
        s1.setTop(s2.getBottom());
        s1.change_y = 0;
    }

    // Moving right
    if (s1.change_x > 0){
        s1.setRight(s2.getLeft());
        s1.change_x = 0;
    }
    // Moving left
    else if (s1.change_x < 0){
        s1.setLeft(s2.getRight());
        s1.change_x = 0;
    }
}

public void resolveCollision(DynamicActor s1, DynamicActor s2){
    // Moving down
    if (s1.change_y > 0){
        s1.setBottom(s2.getTop());
        s1.change_y = 0;
    }
    // Moving up
    else if (s1.change_y < 0){
        s1.setTop(s2.getBottom());
        s1.change_y = 0;
    }

    // Moving right
    if (s1.change_x > 0){
        s1.setRight(s2.getLeft());
        s1.change_x = 0;
    }
    // Moving left
    else if (s1.change_x < 0){
        s1.setLeft(s2.getRight());
        s1.change_x = 0;
    }
}

public ArrayList<Actor> checkCollisionList(Actor s, ArrayList<Actor> collisionList){
    ArrayList<Actor> colliders = new ArrayList<Actor>();
    for (Actor item: collisionList){
        if(isColliding(s, item)){
            colliders.add(item);
        }
    }
    return colliders;
}

public ArrayList<Actor> checkCollisionList(DynamicActor s, ArrayList<Actor> collisionList){
    ArrayList<Actor> colliders = new ArrayList<Actor>();
    for (Actor item: collisionList){
        if(isColliding(s, item)){
            colliders.add(item);
        }
    }
    return colliders;
}

/*
public ArrayList<DynamicActor> checkCollisionList(DynamicActor s, ArrayList<DynamicActor> collisionList){
    ArrayList<DynamicActor> colliders = new ArrayList<DynamicActor>();
    for (DynamicActor item: collisionList){
        if(isColliding(s, item)){
            colliders.add(item);
        }
    }
    return colliders;
}
*/