// Playdate magnetic charging dock: flush wall plate
//
// A one-piece, wall-mounted take on the MakerWorld "Playdate Magnetic
// Charging Dock" (model 1635754). The dock is a single plate:
//
//   - its back is completely flat and sits flush on the wall
//   - four 8 x 3 mm magnets sit flush in the front face, as on the original
//   - a compartment in the back holds a small USB-C 5 V breakout board, so
//     a normal USB-C cable plugs straight in; the cable comes out of a hole
//     in the wall behind the centre of the plate
//   - wires from the board's 5 V and GND pads run in grooves on the back to
//     the magnets; small printed pins press each bare wire onto its magnet,
//     and the wall holds the pins in
//   - three 10 x 2 mm magnets in the middle, over the steel strip inside the
//     Playdate's back cover, do most of the holding
//   - two countersunk screws through the front fix it to the wall; the
//     Playdate covers them when it is docked
//
// Coordinates (as printed): X across, Y up the wall, Z out from the wall.
// The back face is z = 0. Print it back face down: flat, no supports.
// Set `part` to "pins" to export the contact pins.

part = "plate";  // [plate, pins]

/* [Plate] */
plate_w        = 79;    // a little wider than the Playdate (76 mm)
plate_h        = 79;    // a little taller than the Playdate (74 mm)
corner_r       = 6;
edge_round     = 0.8;   // softened front edge
hold_floor     = 0.6;   // between the compartment and the holding magnets

/* [Magnets] */
// Centre-to-centre of the Playdate's back corner holes, across and up.
// 67 mm across is measured from the Minimalist Playdate Stand, whose M2 screws
// thread into those holes. 67 mm up is estimated from a photo of the inside
// of the back cover (roughly square hole pattern); check it if you can.
magnet_dx      = 67;
magnet_dy      = 67;
magnet_d       = 8;
magnet_t       = 3;
magnet_fit     = 0.15;  // added to the pocket diameter; glue the magnets in

/* [Holding magnets] */
// Inside the Playdate's back cover, dead centre, is a steel strip about
// 35 x 10 mm (it is what the Minimalist Playdate Stand's magnets grab). Three
// 10 x 2 mm magnets sit in a row right over it and do most of the holding.
// They carry no current. They sit in front of the plug channel, which is
// what sets the plate's thickness.
hold_d         = 10;
hold_t         = 2;
hold_fit       = 0.2;
hold_magnets   = [[-11, 0], [0, 0], [11, 0]];

/* [USB-C board and plug] */
// The board bay is deliberately roomy: 22 x 20 mm fits nearly every USB-C
// "5V" breakout board (the kind with the two 5.1 kOhm CC resistors fitted).
// Push the board against the plug end of the bay, socket centred, and glue
// it. Plug defaults suit a standard straight USB-C cable.
board_w        = 22;    // bay width, across the socket
board_l        = 20;    // bay length, along the plug direction
board_pcb_t    = 1.0;
socket_h       = 3.3;   // height of the socket above the PCB
plug_w         = 12.4;  // plug overmould width
plug_t         = 6.6;   // plug overmould thickness
plug_l         = 22;    // whole plug, metal tip to end of the overmould
plug_insert    = 6.6;   // how far the metal tip goes into the socket
fit            = 0.4;   // clearance around board and plug

/* [Wiring] */
groove_w       = 1.8;   // fits the board-to-magnet wires
groove_d       = 1.4;
contact_d      = 6;     // window behind each magnet for wire and pin

/* [Wall screws] */
screw_pos      = [[-20, -24], [20, -24]];
screw_d        = 3.5;   // #6 / 3.5 mm countersunk wood screw
screw_head_d   = 7;

$fn = 64;
eps = 0.01;

// Depth of the compartment (from the wall) is set by the plug, which lies
// flat against the wall.
bay_d    = plug_t + fit;
plate_t  = bay_d + hold_floor + hold_t;        // 9.6 mm with the defaults
back_layer = plate_t - magnet_t;               // behind the magnets
pin_l    = back_layer - 0.8;                   // leaves 0.8 mm for the wire coil

// The plug's cable end sits at the plate centre, where the cable turns into
// the wall. The plug points up; the board sits above it.
plug_y0  = 1;                                  // cable end of the plug
plug_y1  = plug_y0 + plug_l;                   // metal tip
mouth_y  = plug_y1 - plug_insert;              // socket mouth / board edge
board_y0 = mouth_y - 0.5;
board_y1 = board_y0 + board_l;
// The PCB rests on a shelf so the socket lines up with the plug's centre.
socket_c = board_pcb_t + socket_h / 2;         // socket centre above PCB back
board_floor = plug_t / 2 + socket_c;           // PCB back face, from the wall

assert(magnet_dx / 2 + magnet_d / 2 + 1.2 <= plate_w / 2, "magnets too close to the side edge");
assert(magnet_dy / 2 + magnet_d / 2 + 1.2 <= plate_h / 2, "magnets too close to the top or bottom edge");
assert(board_y1 + fit + 2 <= plate_h / 2, "board bay runs into the top edge");
assert(board_floor <= plate_t - 0.8, "board shelf leaves too little front skin");
assert(hold_d + 1 <= magnet_dy - magnet_d, "holding magnets too big for the plate");

magnets = [for (sx = [-1, 1], sy = [-1, 1]) [sx * magnet_dx / 2, sy * magnet_dy / 2]];

module rounded_rect(w, h, r) {
    offset(r) square([w - 2 * r, h - 2 * r], center = true);
}

module plate_body() {
    hull() {
        linear_extrude(plate_t - edge_round)
            rounded_rect(plate_w, plate_h, corner_r);
        linear_extrude(plate_t)
            rounded_rect(plate_w - 2 * edge_round, plate_h - 2 * edge_round, corner_r - edge_round);
    }
}

module magnet_pockets() {
    for (m = magnets) translate([m[0], m[1], 0]) {
        translate([0, 0, back_layer]) cylinder(d = magnet_d + magnet_fit, h = magnet_t + eps);
        translate([0, 0, -eps]) cylinder(d = contact_d, h = back_layer + 2 * eps);
    }
}

// Compartment, open to the wall: a channel for the plug, a deeper-set bay
// for the board, and room around the centre for the cable to turn into the
// wall hole.
module compartment() {
    pw = plug_w + 2 * fit;
    // plug channel, full depth
    translate([-pw / 2, plug_y0 - 9, -eps]) cube([pw, plug_l + 9 + 0.5, bay_d + eps]);
    // board bay, down to the shelf the PCB rests on
    bw = board_w + 2 * fit;
    translate([-bw / 2, board_y0 - fit, -eps]) cube([bw, board_l + 2 * fit, board_floor + eps]);
    // solder-pad end of the board: room for the wire joints, full depth
    translate([-bw / 2, board_y1 - 5, -eps]) cube([bw, 5 + fit, bay_d + eps]);
}

// Grooves on the back from the board end of the compartment to every magnet.
// Only two magnets are wired (+5 V to a top one, ground to a bottom one); the
// others just help hold the Playdate. Grooves go to all four so either side
// works.
module wire_grooves() {
    start = [0, board_y1 - 1.5];
    for (m = magnets)
        hull() {
            translate([start[0], start[1], -eps]) cylinder(d = groove_w, h = groove_d + eps, $fn = 16);
            translate([m[0], m[1], -eps]) cylinder(d = groove_w, h = groove_d + eps, $fn = 16);
        }
}

module hold_pockets() {
    for (m = hold_magnets)
        translate([m[0], m[1], plate_t - hold_t])
            cylinder(d = hold_d + hold_fit, h = hold_t + eps);
}

module screw_holes() {
    for (p = screw_pos) translate([p[0], p[1], 0]) {
        translate([0, 0, -eps]) cylinder(d = screw_d + 0.3, h = plate_t + 2 * eps);
        sink = (screw_head_d - screw_d) / 2;
        translate([0, 0, plate_t - sink - 0.2])
            cylinder(d1 = screw_d + 0.3, d2 = screw_head_d + 0.4, h = sink + 0.2 + eps);
    }
}

module plate() {
    difference() {
        plate_body();
        magnet_pockets();
        hold_pockets();
        compartment();
        wire_grooves();
        screw_holes();
    }
}

// Contact pins: push into the window behind a magnet, over the coiled bare
// wire. The wall holds them in. Print two (four if you wire both sides).
module pins() {
    for (i = [0 : 3])
        translate([i * (contact_d + 3), 0, 0])
            cylinder(d = contact_d - 0.3, h = pin_l);
}

if (part == "pins") pins(); else plate();
