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