Zombie :: struct {
    position: [2]f32,
    speed: f32,
    health: int,
    path: [][2]int,
    width, height: f32,
}

ZOMBIES := make(map[i32]Zombie)
SPAWN_RATE: f32 = 1.0

spawn_zombie :: proc() {
    alive_zombies := len(ZOMBIES)
    if alive_zombies < TOTAL_ZOMBIES && alive_zombies < ZOMBIE_LIMIT {
        random_num := rand.int31()
        spawn_point := rand.choice(ZOMBIE_SPAWNS[:])

        x := spawn_point.pos % LEVEL_HEIGHT
        y := spawn_point.pos / LEVEL_HEIGHT

        pos := [2]f32{f32(x)*32,f32(y)*32}
        pos_int := [2]int{x,y}

        new_zombie := Zombie{
            position = pos,
            speed = 100,
            health = 100,
            path = spawn_point.path,
            width = 32,
            height = 32,
        }
        _, ok := ZOMBIES[random_num]
        for ok {
            random_num = rand.int31()
            _, ok = ZOMBIES[random_num]
        }
        ZOMBIES[random_num] = new_zombie
        populate_edge_array(random_num, .Zombie)
    }
}
