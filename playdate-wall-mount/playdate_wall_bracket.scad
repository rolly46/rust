// Playdate magnetic dock: wall bracket
//
// Replaces the angled desk foot ("playdate base.stl") of the MakerWorld model
// 1635754 so the dock hangs flat on a wall. It clamps onto the dock with the
// original cable nut and the two alignment pegs, exactly like the desk foot,
// and hangs on two wall screws through keyhole slots on its back.
//
// Coordinates (as mounted): X along the wall, Y away from the wall, Z up.
// The wall is the plane y = 0; the bottom edge of the dock sits at z = 0.
//
// Print upright, as mounted (bottom face on the bed). No supports needed.
//
// Values marked MEASURE are estimates taken from the model's photos. Check
// them against your printed dock (calipers on the original foot are best)
// before printing.

/* [Dock interface] */
dock_width      = 78;    // MEASURE: dock outer width
dock_depth      = 16;    // MEASURE: dock thickness, back plate to magnet face
iface_z         = 10;    // MEASURE: dock bottom edge to centre of cable nut
peg_spacing     = 50;    // MEASURE: centre-to-centre of the two alignment pegs
peg_d           = 6.0;   // MEASURE: alignment peg diameter
peg_depth       = 6;     // depth of the peg sockets
holder_d        = 14.0;  // MEASURE: OD of the threaded nut holder boss
mount_t         = 4;     // MEASURE: thickness of the original foot's top plate
                         // (the holder thread is sized to clamp this)
nut_flange_d    = 22;    // MEASURE: largest diameter of the cable nut
clearance       = 0.4;   // added to hole diameters for fit

/* [Bracket] */
standoff        = 20;    // wall to dock back; room for the nut and cable bend
bracket_h       = 40;    // height of the bracket behind the dock
width_inset     = 2;     // bracket is this much narrower than the dock per side

/* [Playdate safety ledge] */
ledge           = false; // optional shelf under the dock and Playdate, in case it slips
ledge_t         = 3;     // shelf thickness
playdate_depth  = 9;     // Playdate thickness
ledge_extra     = 2;     // extra shelf depth beyond the Playdate
lip_h           = 4;     // raised lip at the front edge of the shelf

/* [Wall screws] */
screw_spacing   = 54;    // horizontal distance between the two wall screws
screw_shank_d   = 4.5;   // #8 / 4 mm wood screw
screw_head_d    = 9.0;
keyhole_travel  = 8;     // how far the bracket drops onto the screws
keyhole_z       = 16;    // height of the entry holes
keyhole_wall    = 2.5;   // material between wall and screw head

$fn = 64;
eps = 0.01;

bw        = dock_width - 2 * width_inset;
cavity_d  = standoff - mount_t;
cavity_w  = nut_flange_d + 6;
cavity_top = iface_z + nut_flange_d / 2 + 2;

assert(cavity_top + cavity_w / 2 <= bracket_h - 2,
       "bracket_h too small: nut cavity roof would break through the top");
assert(peg_spacing / 2 + peg_d / 2 + 2 <= bw / 2,
       "peg sockets fall outside the bracket");

// Horizontal hole that prints without supports: a circle with a 45 degree
// peak on top. Axis along Y, spanning y0..y1.
module teardrop_y(d, y0, y1) {
    translate([0, y1, 0]) rotate([90, 0, 0])
        linear_extrude(y1 - y0)
            union() {
                circle(d = d);
                rotate(45) square(d / 2);
            }
}

module body() {
    translate([-bw / 2, 0, 0]) cube([bw, standoff, bracket_h]);
    if (ledge) {
        shelf = standoff + dock_depth + playdate_depth + ledge_extra;
        translate([-bw / 2, 0, -ledge_t]) cube([bw, shelf, ledge_t]);
        // Front lip with a 45 degree back face so it prints cleanly.
        translate([-bw / 2, shelf, 0]) rotate([90, 0, 90])
            linear_extrude(bw)
                polygon([[0, -eps], [0, lip_h], [-2, lip_h], [-2 - lip_h, -eps]]);
    }
}

// Pocket behind the mount plate for the cable nut. Open to the wall (so the
// nut can be tightened before hanging) and open at the bottom, through the
// ledge, so the cable can bend down and out. The pointed roof prints without support.
module nut_cavity() {
    top = cavity_top;
    translate([0, -eps, 0]) rotate([-90, 0, 0])
        linear_extrude(cavity_d + eps)
            mirror([0, 1, 0])
                polygon([
                    [-cavity_w / 2, -ledge_t - 1],
                    [ cavity_w / 2, -ledge_t - 1],
                    [ cavity_w / 2, top],
                    [0, top + cavity_w / 2],
                    [-cavity_w / 2, top],
                ]);
}

module dock_holes() {
    translate([0, 0, iface_z]) {
        teardrop_y(holder_d + clearance, cavity_d - eps, standoff + eps);
        for (sx = [-1, 1])
            translate([sx * peg_spacing / 2, 0, 0])
                teardrop_y(peg_d + clearance, standoff - peg_depth, standoff + eps);
    }
}

// Keyhole: the screw head enters the round hole, then the bracket drops so
// the shank rides up the slot and the head is trapped behind keyhole_wall.
module keyhole() {
    head  = screw_head_d + 1;
    shank = screw_shank_d + 0.5;
    pocket = screw_head_d * 0.5 + 1.5;   // depth of the head pocket
    // shank slot through the wall-side skin
    translate([0, -eps, 0]) rotate([-90, 0, 0])
        linear_extrude(keyhole_wall + 2 * eps)
            hull() {
                circle(d = shank);
                translate([0, -keyhole_travel]) circle(d = shank);
            }
    // entry hole for the head
    teardrop_y(head, -eps, keyhole_wall + pocket);
    // pocket the head slides along
    translate([0, keyhole_wall, 0]) rotate([-90, 0, 0])
        linear_extrude(pocket)
            hull() {
                circle(d = head);
                // peak at the top of the slot so the pocket roof self-supports
                translate([0, -keyhole_travel]) rotate(225) square(head / 2);
                translate([0, -keyhole_travel]) circle(d = head);
            }
}

module bracket() {
    difference() {
        body();
        nut_cavity();
        dock_holes();
        for (sx = [-1, 1])
            translate([sx * screw_spacing / 2, 0, keyhole_z]) keyhole();
    }
}

bracket();
