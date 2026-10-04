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
| Neodymium disc magnet, 8 mm × 3 mm, N52, nickel plated | 4 | The charging magnets. Plated magnets conduct, which is what carries the charge. Buy a few spares. |
| Neodymium disc magnet, 15 mm × 3 mm | 3 | The holding magnets in the middle. Any coating; they carry no current. |
| USB-C female breakout board, 5 V | 1 | See below. Anything up to 22 × 20 mm fits the bay. |
| USB-C cable | 1 | Straight plug. Runs through the wall to your charger. |
| Thin wire, red and black | about 10 cm each | 24 to 28 AWG, from board to magnets. |
| Countersunk wood screw, 3.5 mm (#6), about 30 mm | 2 | Plus wall plugs. |
| Superglue | | For the magnets and the board. |

### Which board

Search for **"USB-C female breakout board 2 pin 5V"** (often listed as
"Type-C 2P PCB" or "USB-C power socket board"). They cost very little, are
about 10 to 15 mm square, and have just two solder pads, VBUS (+) and GND.

The one thing that matters: it must have the **two 5.1 kΩ resistors on the
CC pins** (two tiny "512" parts next to the socket). Without them a USB-C
charger won't switch on 5 V and nothing charges. Bare 24-pin breakouts
usually leave them off; the 2-pin "5V" boards have them.

If you'd rather buy from a known brand, the Adafruit USB Type C Breakout
Board, Downstream Connection (product 4090) has the resistors; check its
listed size is under 22 × 20 mm before you order.

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
- Three 15 × 3 mm magnets near the middle do most of the holding, the way
  the [Minimalist Playdate Stand](https://www.printables.com/model/238033-minimalist-playdate-stand)
  holds the Playdate. Two sit either side of the plug at the Playdate's
  centre height and one sits below.
- Two countersunk screws through the front, low on the plate, fix it to the
  wall. The Playdate covers them when it is docked.

## Check before printing

Measure these and set them in `playdate_flush_dock.scad`, then export the
STLs (OpenSCAD's Customizer, or `openscad -o playdate_flush_dock.stl
playdate_flush_dock.scad` and the same with `-D 'part="pins"'` for the pins):

| Parameter | Default | What to measure |
| --- | --- | --- |
| `magnet_dx` | 67 | Centre-to-centre of the Playdate's back corner screws, side to side |
| `magnet_dy` | 65 | Centre-to-centre of the back corner screws, top to bottom |
| `board_w`, `board_l` | 22, 20 | Bay size; only change it if your board is bigger |
| `plug_w`, `plug_t`, `plug_l` | 12.4, 6.6, 22 | Your cable's plug: width, thickness, length to the end of the moulding |

The plate's thickness follows the plug: it is the plug thickness plus
1.6 mm. A slimmer plug makes a thinner plate.

## Printing

- Print the plate back face down. The back stays dead flat for the wall,
  and no supports are needed.
- PLA or PETG, 0.2 mm layers, 100% infill.

## Fitting

1. Hold the plate level on the wall and mark the centre and the two screw
   holes (40 mm apart, 24 mm below the centre). Drill the centre hole 12 mm and check for pipes and cables first.
2. Glue all seven magnets in flush with the front. The 15 mm ones can face
   either way; the 8 mm ones should all face the same way.
3. Solder red to the board's VBUS (+) pad and black to GND. Glue the board
   into its bay, socket facing the plug channel, pushed against the plug end
   of the bay and centred side to side.
4. Lay red in the groove to a top magnet and black to the bottom magnet on
   the same side. Strip about 6 mm, coil it flat into the window behind the
   magnet, and press a pin in on top.
5. Pull the cable out of the wall, plug it into the board, and push the
   slack back into the wall as you bring the plate up.
6. Drive both screws until the plate is tight on the wall.
7. Dock the Playdate and check it charges. If it doesn't, swap which magnets
   the red and black wires go to.
