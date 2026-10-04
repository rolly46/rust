// Playdate magnetic charging dock: flush wall plate
//
// A one-piece, wall-mounted take on the MakerWorld "Playdate Magnetic
// Charging Dock" (model 1635754). The dock is a single thin plate:
//
//   - its back is completely flat and sits flush on the wall
//   - four 8 x 3 mm magnets sit flush in the front face, as on the original
//   - the USB cable comes out of a hole in the wall directly behind the
//     centre of the plate; its two power wires run in grooves on the back
//     face to the magnets, where they are clamped against the magnets when
//     the plate is screwed down
//   - two countersunk screws through the front fix it to the wall; the
//     Playdate covers them when it is docked
//
// Coordinates (as printed): X across, Y up the wall, Z out from the wall.
// The back face is z = 0. Print it back face down: flat, no supports.

/* [Plate] */
plate_w        = 79;    // a little wider than the Playdate (76 mm)
plate_h        = 77;    // a little taller than the Playdate (74 mm)
corner_r       = 6;
edge_round     = 0.8;   // softened front edge

/* [Magnets] */
// MEASURE: centre-to-centre of the Playdate's back corner screws, across and
// up. The magnets must land on them for charging to work.
magnet_dx      = 67;
magnet_dy      = 65;
magnet_d       = 8;
magnet_t       = 3;
magnet_fit     = 0.15;  // added to the pocket diameter; glue the magnets in

/* [Wiring] */
back_layer     = 1.4;   // material behind the magnets, holds the wire grooves
groove_w       = 1.8;   // fits the cable's insulated power wires
groove_d       = 1.4;   // as deep as the back layer
contact_d      = 6;     // window behind each magnet where the bare wire touches it
cable_hole_d   = 7;     // centre hole the wires come up through

/* [Wall screws] */
screw_spacing  = 44;    // horizontal, centred
screw_d        = 3.5;   // #6 / 3.5 mm countersunk wood screw
screw_head_d   = 7;

$fn = 64;
eps = 0.01;

plate_t = back_layer + magnet_t;   // 4.4 mm with the defaults

assert(magnet_dx / 2 + magnet_d / 2 + 1.2 <= plate_w / 2, "magnets too close to the side edge");
assert(magnet_dy / 2 + magnet_d / 2 + 1.2 <= plate_h / 2, "magnets too close to the top or bottom edge");
assert(groove_d <= back_layer, "wire grooves deeper than the back layer");

magnets = [for (sx = [-1, 1], sy = [-1, 1]) [sx * magnet_dx / 2, sy * magnet_dy / 2]];

module rounded_rect(w, h, r) {
    offset(r) square([w - 2 * r, h - 2 * r], center = true);
}

module plate() {
    // flat back, straight sides, front edge softened
    hull() {
        linear_extrude(plate_t - edge_round)
            rounded_rect(plate_w, plate_h, corner_r);
        linear_extrude(plate_t)
            rounded_rect(plate_w - 2 * edge_round, plate_h - 2 * edge_round, corner_r - edge_round);
    }
}

module magnet_pockets() {
    for (m = magnets) translate([m[0], m[1], 0]) {
        // pocket from the front, magnet ends up flush with the front face
        translate([0, 0, back_layer]) cylinder(d = magnet_d + magnet_fit, h = magnet_t + eps);
        // window behind it so the wire can touch the magnet's back
        translate([0, 0, -eps]) cylinder(d = contact_d, h = back_layer + 2 * eps);
    }
}

// Grooves on the back face from the centre hole to every magnet. Only two
// magnets are wired (+5 V to a top one, ground to a bottom one); the others
// just help hold the Playdate. Grooves go to all four so either side works.
module wire_grooves() {
    for (m = magnets)
        hull() {
            translate([0, 0, -eps]) cylinder(d = groove_w, h = groove_d + eps, $fn = 16);
            translate([m[0], m[1], -eps]) cylinder(d = groove_w, h = groove_d + eps, $fn = 16);
        }
}

module cable_hole() {
    translate([0, 0, -eps]) cylinder(d = cable_hole_d, h = plate_t + 2 * eps);
}

module screw_holes() {
    for (sx = [-1, 1]) translate([sx * screw_spacing / 2, 0, 0]) {
        translate([0, 0, -eps]) cylinder(d = screw_d + 0.3, h = plate_t + 2 * eps);
        // 90 degree countersink, head ends flush with the front face
        sink = (screw_head_d - screw_d) / 2;
        translate([0, 0, plate_t - sink - 0.2])
            cylinder(d1 = screw_d + 0.3, d2 = screw_head_d + 0.4, h = sink + 0.2 + eps);
    }
}

difference() {
    plate();
    magnet_pockets();
    wire_grooves();
    cable_hole();
    screw_holes();
}
