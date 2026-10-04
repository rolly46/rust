# Playdate flush wall dock

A wall-mounted magnetic charging dock for the Playdate, based on the
[Playdate Magnetic Charging Dock](https://makerworld.com/en/models/1635754)
on MakerWorld. It is one thin printed plate, 4.4 mm thick, that screws flat
to the wall. The USB cable comes out of a hole in the wall behind the centre
of the plate, so no cable shows.

![Front (left) and back (right)](preview.png)

This is a new design. It works the same way as the original (8 × 3 mm
magnets carry 5 V to the Playdate) but contains none of the original
model's files.

## How it works

- Four 8 × 3 mm neodymium magnets sit flush in the front face and hold the
  Playdate. Two of them are wired: +5 V (red) to a top magnet and ground
  (black) to the bottom magnet on the same side, as on the original dock.
- The back face is completely flat. Grooves in it run from the centre hole
  to each magnet, and the wires lie in them.
- Behind each magnet is a small window. The stripped end of a wire sits
  there, and screwing the plate to the wall clamps it against the magnet.
- Two countersunk screws through the front fix it to the wall. The Playdate
  covers them when it is docked.

## Check before printing

The magnets have to land on the Playdate's back corner screws for charging
to work. Measure your Playdate and set these in `playdate_flush_dock.scad`:

| Parameter | Default | What to measure |
| --- | --- | --- |
| `magnet_dx` | 67 | Centre-to-centre of the back corner screws, side to side |
| `magnet_dy` | 65 | Centre-to-centre of the back corner screws, top to bottom |
| `groove_w` | 1.8 | Outer diameter of the cable's red and black wires, plus a little |

Then export the STL in OpenSCAD, or from the command line:

```sh
openscad -o playdate_flush_dock.stl playdate_flush_dock.scad
```

The included `playdate_flush_dock.stl` uses the defaults.

## Printing

- Print it back face down. The back stays dead flat for the wall, and no
  supports are needed.
- PLA or PETG, 0.2 mm layers, 100% infill is cheap at this size and makes
  the thin plate stiff.

## Parts

- 4 × 8 × 3 mm neodymium disc magnets
- A USB-A cable you can cut (5 V, 2 wires used)
- 2 × 3.5 mm (#6) countersunk wood screws, about 30 mm, plus wall plugs
- Superglue for the magnets

## Fitting

1. Mark the wall with the plate held level: the centre hole and the two
   screw holes. Drill the centre hole about 10 mm across and check for
   pipes and cables behind the wall first.
2. Feed the cable through the wall so its end comes out of the centre hole.
   Strip the outer jacket back to the wall surface. Cut off the data wires
   (usually white and green).
3. Glue the magnets into their pockets, flush with the front. Check that all
   four pull the same way toward the Playdate before the glue sets.
4. Thread the red and black wires through the centre hole from the back and
   lay them in the grooves to a top magnet (red) and the bottom magnet on
   the same side (black). Strip about 8 mm, twist it into a small flat coil
   and tuck it into the window behind the magnet.
5. Push the cable slack back into the wall, hold the plate flat, and drive
   both screws until the plate is tight against the wall. That clamps the
   wire coils onto the magnets.
6. Dock the Playdate and check it charges. If it doesn't, swap which magnets
   the red and black wires go to.
