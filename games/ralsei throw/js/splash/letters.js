letters = [
    { texture: "letter_d", y: 180, x: 200, bounce_fn: (time) => { return [interp_clamp(time, 0, 2900, 200, 60), parabola(time, 0, 2900, 180, -1600)]; } },
    { texture: "letter_e", y: 180, x: 275, bounce_fn: (time) => { return [interp_clamp(time, 0, 1700, 275, 137), parabola(time, 0, 1700, 180, -1600)]; } },
    { texture: "letter_l", y: 180, x: 530, bounce_fn: (time) => { return [interp_clamp(time, 0, 2200, 530, 182), parabola(time, 0, 2200, 180, -1600)]; } },
    { texture: "letter_t", y: 180, x: 405, bounce_fn: (time) => { return [interp_clamp(time, 0, 2950, 405, 230), parabola(time, 0, 2950, 180, -1600)]; } },
    { texture: "letter_a", y: 180, x: 475, bounce_fn: (time) => { return [interp_clamp(time, 0, 1500, 475, 300), parabola(time, 0, 1500, 180, -1600)]; } },
    { texture: "letter_r", y: 180, x: 340, bounce_fn: (time) => { return [interp_clamp(time, 0, 2800, 340, 375), parabola(time, 0, 2800, 180, -1600)]; } },
    { texture: "letter_u", y: 180, x: 60, bounce_fn: (time) => { return [interp_clamp(time, 0, 2700, 60, 445), parabola(time, 0, 2700, 180, -1600)]; } },
    { texture: "letter_n", y: 180, x: 130, bounce_fn: (time) => { return [interp_clamp(time, 0, 2550, 130, 515), parabola(time, 0, 2550, 180, -1600)]; } },
    { texture: "letter_e", y: 180, x: 585, bounce_fn: (time) => { return [interp_clamp(time, 0, 2300, 585, 585), parabola(time, 0, 2300, 180, -1600)]; } },
    
    { texture: "letter_r", y: 325, x: 325, bounce_fn: (time) => { return [interp_clamp(time, 0, 1650, 325, 190), parabola(time, 0, 1650, 325, -1600)]; } },
    { texture: "letter_a", y: 325, x: 190, bounce_fn: (time) => { return [interp_clamp(time, 0, 2100, 190, 260), parabola(time, 0, 2100, 325, -1600)]; } },
    { texture: "letter_l", y: 325, x: 470, bounce_fn: (time) => { return [interp_clamp(time, 0, 1600, 470, 310), parabola(time, 0, 1600, 325, -1600)]; } },
    { texture: "letter_s", y: 325, x: 260, bounce_fn: (time) => { return [interp_clamp(time, 0, 2400, 260, 355), parabola(time, 0, 2400, 325, -1600)]; } },
    { texture: "letter_e", y: 325, x: 423, bounce_fn: (time) => { return [interp_clamp(time, 0, 2000, 423, 425), parabola(time, 0, 2000, 325, -1600)]; } },
    { texture: "letter_i", y: 325, x: 371, bounce_fn: (time) => { return [interp_clamp(time, 0, 2250, 371, 470), parabola(time, 0, 2250, 325, -1600)]; } },

    { texture: "letter_h", y: 435, x: 240, bounce_fn: (time) => { return [interp_clamp(time, 0, 2500, 240, 175), parabola(time, 0, 2500, 435, -1600)]; } },
    { texture: "letter_w", y: 435, x: 455, bounce_fn: (time) => { return [interp_clamp(time, 0, 1800, 455, 255), parabola(time, 0, 1800, 435, -1600)]; } },
    { texture: "letter_r", y: 435, x: 300, bounce_fn: (time) => { return [interp_clamp(time, 0, 3000, 300, 335), parabola(time, 0, 3000, 435, -1600)]; } },
    { texture: "letter_o", y: 435, x: 370, bounce_fn: (time) => { return [interp_clamp(time, 0, 1900, 370, 410), parabola(time, 0, 1900, 435, -1600)]; } },
    { texture: "letter_t", y: 435, x: 175, bounce_fn: (time) => { return [interp_clamp(time, 0, 2600, 175, 480), parabola(time, 0, 2600, 435, -1600)]; } },
]