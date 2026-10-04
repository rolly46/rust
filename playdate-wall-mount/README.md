# Playdate flush wall dock

A wall-mounted magnetic charging dock for the Playdate, based on the
[Playdate Magnetic Charging Dock](https://makerworld.com/en/models/1635754)
on MakerWorld. It is one printed plate, 8.2 mm thick, that screws flat to
the wall. A USB-C cable comes out of a hole in the wall behind the centre of
the plate and plugs into a small 5 V board hidden in the back, so no cable
shows and nothing needs cutting.

![Front (left) and back (right)](preview.png)

This is a new design. It works the same way as the original (magnets carry
5 V to the Playdate) but contains none of the original model's files.

## Parts

| Part | Qty | Notes |
| --- | --- | --- |
| Neodymium disc magnet, 8 mm × 3 mm, N52, nickel plated | 4 | Plated magnets conduct, which is what carries the charge. Buy a few spares. |
| USB-C female breakout board, "5V" 2-pin type | 1 | The kind with the two 5.1 kΩ CC resistors fitted, so a USB-C charger switches on 5 V. Board about 13 × 11 mm. |
| USB-C cable | 1 | Straight plug. Runs through the wall to your charger. |
| Thin wire, red and black | about 10 cm each | 24 to 28 AWG, from board to magnets. |
| Countersunk wood screw, 3.5 mm (#6), about 30 mm | 2 | Plus wall plugs. |
| Superglue | | For the magnets and the board. |

Print `playdate_flush_dock.stl` (the plate) and `playdate_contact_pins.stl`
(four small pins; you need two).

## How it works

- Four magnets sit flush in the front face and hold the Playdate. Two are
  wired: +5 V to a top magnet and ground to the bottom magnet on the same
  side, as on the original dock.
- The back face is completely flat. A compartment in it holds the USB-C
  board, with the cable's plug lying flat against the wall. The cable turns
  into the wall right at the centre of the plate.
- Grooves on the back run from the board to each magnet. Behind each magnet
  is a small window: the bare end of a wire goes in there, a printed pin
  goes on top, and the wall pushes the pin in so the wire presses on the
  magnet.
- Two countersunk screws through the front fix it to the wall. The Playdate
  covers them when it is docked.

## Check before printing

Measure these and set them in `playdate_flush_dock.scad`, then export the
STLs (OpenSCAD's Customizer, or `openscad -o playdate_flush_dock.stl
playdate_flush_dock.scad` and the same with `-D 'part="pins"'` for the pins):

| Parameter | Default | What to measure |
| --- | --- | --- |
| `magnet_dx` | 67 | Centre-to-centre of the Playdate's back corner screws, side to side |
| `magnet_dy` | 65 | Centre-to-centre of the back corner screws, top to bottom |
| `board_w`, `board_l` | 13, 11 | Your breakout board's width and length |
| `plug_w`, `plug_t`, `plug_l` | 12.4, 6.6, 22 | Your cable's plug: width, thickness, length to the end of the moulding |

The plate's thickness follows the plug: it is the plug thickness plus
1.6 mm. A slimmer plug makes a thinner plate.

## Printing

- Print the plate back face down. The back stays dead flat for the wall,
  and no supports are needed.
- PLA or PETG, 0.2 mm layers, 100% infill.

## Fitting

1. Hold the plate level on the wall and mark the centre and the two screw
   holes. Drill the centre hole 12 mm and check for pipes and cables first.
2. Glue the magnets in flush with the front.
3. Solder red to the board's VBUS (+) pad and black to GND. Glue the board
   into its bay, socket facing the plug channel.
4. Lay red in the groove to a top magnet and black to the bottom magnet on
   the same side. Strip about 6 mm, coil it flat into the window behind the
   magnet, and press a pin in on top.
5. Pull the cable out of the wall, plug it into the board, and push the
   slack back into the wall as you bring the plate up.
6. Drive both screws until the plate is tight on the wall.
7. Dock the Playdate and check it charges. If it doesn't, swap which magnets
   the red and black wires go to.
