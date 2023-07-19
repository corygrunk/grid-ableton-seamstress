--- ableton control surface
--
-- Note MIDI happens on channel 1
-- Control MIDI happens on channel 6
--
-- TODO: Add toggles and momentary lights
-- TODO: Need formatter to be supported for adding a parameter
--       in order to display the note name in the params page

local MusicUtil = require "musicutil"
local note_display_name = '--'

g = grid.connect() -- if no argument is provided, defaults to port 1
grid_connected = true
Midi = midi.connect_output()

scale_names = {}
notes = {} -- this is the table that holds the scales' notes

function init()

  for i = 1, #MusicUtil.SCALES do table.insert(scale_names, MusicUtil.SCALES[i].name) end

  params:add_separator('Scale Options')
  -- setting root notes using params
  params:add{
    type = "number", 
    id = "root_note", 
    name = "root note",
    min = 0, max = 127, default = 24, 
    formatter = function(param) return MusicUtil.note_num_to_name(param:get(), true) end,
    action = function() build_scale() end
  } -- by employing build_scale() here, we update the scale

  -- setting scale type using params
  params:add{
    type = "option", 
    id = "scale", 
    name = "scale",
    options = scale_names, default = 5,
    action = function() build_scale() end
  } -- by employing build_scale() here, we update the scale

  build_scale() -- builds initial scale

  midi:connect_output(1)

  grid_dirty = true -- initialize with a redraw
  screen_dirty = true -- initialize with a redraw
  clock.run(grid_redraw_clock) -- start the grid redraw clock
end


function build_scale()
  notes = MusicUtil.generate_scale(params:get("root_note"), params:get("scale"), 6)
  for i = 1, 64 do
    table.insert(notes, notes[i])
  end
end

function play_note(note)
  Midi:note_on(note, 96, 1)
  note_display_name = MusicUtil.note_num_to_name(note)
  screen_dirty = true
end

function stop_note(note)
  Midi:note_off(note, 96, 1)
end

-- BUTTON PRESSES
function g.key(x,y,z)
  -- all control MIDI is on channel 6
  if x == 1 and y == 1 then if z == 1 then Midi:note_on(1, 60, 6) end end -- metronome
  if x == 3 and y == 1 then if z == 1 then Midi:note_on(2, 60, 6) end end -- play
  if x == 4 and y == 1 then if z == 1 then Midi:note_on(3, 60, 6) end end -- stop
  if x == 5 and y == 1 then if z == 1 then Midi:note_on(4, 60, 6) end end -- rec
  if x == 7 and y == 1 then if z == 1 then Midi:note_on(5, 60, 6) end end -- capture
  if x == 8 and y == 1 then if z == 1 then Midi:note_on(6, 60, 6) end end -- session rec

  if x == 1 and y == 2 then if z == 1 then Midi:note_on(7, 60, 6) end end -- track 1 clip 1
  if x == 1 and y == 3 then if z == 1 then Midi:note_on(8, 60, 6) end end -- track 1 clip 2
  if x == 1 and y == 4 then if z == 1 then Midi:note_on(9, 60, 6) end end -- track 1 clip 3
  if x == 1 and y == 5 then if z == 1 then Midi:note_on(10, 60, 6) end end -- track 1 clip 4
  if x == 1 and y == 6 then if z == 1 then Midi:note_on(11, 60, 6) end end -- track 1 -------
  if x == 1 and y == 7 then if z == 1 then Midi:note_on(12, 60, 6) end end -- track 1 mute
  if x == 1 and y == 8 then if z == 1 then Midi:note_on(13, 60, 6) end end -- track 1 arm

  if x == 2 and y == 2 then if z == 1 then Midi:note_on(14, 60, 6) end end -- track 2 clip 1
  if x == 2 and y == 3 then if z == 1 then Midi:note_on(15, 60, 6) end end -- track 2 clip 2
  if x == 2 and y == 4 then if z == 1 then Midi:note_on(16, 60, 6) end end -- track 2 clip 3
  if x == 2 and y == 5 then if z == 1 then Midi:note_on(17, 60, 6) end end -- track 2 clip 4
  if x == 2 and y == 6 then if z == 1 then Midi:note_on(18, 60, 6) end end -- track 2 -------
  if x == 2 and y == 7 then if z == 1 then Midi:note_on(19, 60, 6) end end -- track 2 mute
  if x == 2 and y == 8 then if z == 1 then Midi:note_on(20, 60, 6) end end -- track 2 arm

  if x == 3 and y == 2 then if z == 1 then Midi:note_on(21, 60, 6) end end -- track 3 clip 1
  if x == 3 and y == 3 then if z == 1 then Midi:note_on(22, 60, 6) end end -- track 3 clip 2
  if x == 3 and y == 4 then if z == 1 then Midi:note_on(23, 60, 6) end end -- track 3 clip 3
  if x == 3 and y == 5 then if z == 1 then Midi:note_on(24, 60, 6) end end -- track 3 clip 4
  if x == 3 and y == 6 then if z == 1 then Midi:note_on(25, 60, 6) end end -- track 3 -------
  if x == 3 and y == 7 then if z == 1 then Midi:note_on(26, 60, 6) end end -- track 3 mute
  if x == 3 and y == 8 then if z == 1 then Midi:note_on(27, 60, 6) end end -- track 3 arm

  if x == 4 and y == 2 then if z == 1 then Midi:note_on(28, 60, 6) end end -- track 4 clip 1
  if x == 4 and y == 3 then if z == 1 then Midi:note_on(29, 60, 6) end end -- track 4 clip 2
  if x == 4 and y == 4 then if z == 1 then Midi:note_on(30, 60, 6) end end -- track 4 clip 3
  if x == 4 and y == 5 then if z == 1 then Midi:note_on(31, 60, 6) end end -- track 4 clip 4
  if x == 4 and y == 6 then if z == 1 then Midi:note_on(32, 60, 6) end end -- track 4 -------
  if x == 4 and y == 7 then if z == 1 then Midi:note_on(33, 60, 6) end end -- track 4 mute
  if x == 4 and y == 8 then if z == 1 then Midi:note_on(34, 60, 6) end end -- track 4 arm

  if x == 5 and y == 2 then if z == 1 then Midi:note_on(35, 60, 6) end end -- track 5 clip 1
  if x == 5 and y == 3 then if z == 1 then Midi:note_on(36, 60, 6) end end -- track 5 clip 2
  if x == 5 and y == 4 then if z == 1 then Midi:note_on(37, 60, 6) end end -- track 5 clip 3
  if x == 5 and y == 5 then if z == 1 then Midi:note_on(38, 60, 6) end end -- track 5 clip 4
  if x == 5 and y == 6 then if z == 1 then Midi:note_on(39, 60, 6) end end -- track 5 -------
  if x == 5 and y == 7 then if z == 1 then Midi:note_on(40, 60, 6) end end -- track 5 mute
  if x == 5 and y == 8 then if z == 1 then Midi:note_on(41, 60, 6) end end -- track 5 arm

  if x == 6 and y == 2 then if z == 1 then Midi:note_on(42, 60, 6) end end -- track 6 clip 1
  if x == 6 and y == 3 then if z == 1 then Midi:note_on(43, 60, 6) end end -- track 6 clip 2
  if x == 6 and y == 4 then if z == 1 then Midi:note_on(44, 60, 6) end end -- track 6 clip 3
  if x == 6 and y == 5 then if z == 1 then Midi:note_on(45, 60, 6) end end -- track 6 clip 4
  if x == 6 and y == 6 then if z == 1 then Midi:note_on(46, 60, 6) end end -- track 6 -------
  if x == 6 and y == 7 then if z == 1 then Midi:note_on(47, 60, 6) end end -- track 6 mute
  if x == 6 and y == 8 then if z == 1 then Midi:note_on(48, 60, 6) end end -- track 6 arm

  if x == 7 and y == 2 then if z == 1 then Midi:note_on(49, 60, 6) end end -- track 7 clip 1
  if x == 7 and y == 3 then if z == 1 then Midi:note_on(50, 60, 6) end end -- track 7 clip 2
  if x == 7 and y == 4 then if z == 1 then Midi:note_on(51, 60, 6) end end -- track 7 clip 3
  if x == 7 and y == 5 then if z == 1 then Midi:note_on(52, 60, 6) end end -- track 7 clip 4
  if x == 7 and y == 6 then if z == 1 then Midi:note_on(53, 60, 6) end end -- track 7 -------
  if x == 7 and y == 7 then if z == 1 then Midi:note_on(54, 60, 6) end end -- track 7 mute
  if x == 7 and y == 8 then if z == 1 then Midi:note_on(55, 60, 6) end end -- track 7 arm

  if x == 8 and y == 2 then if z == 1 then Midi:note_on(56, 60, 6) end end -- track 8 clip 1
  if x == 8 and y == 3 then if z == 1 then Midi:note_on(57, 60, 6) end end -- track 8 clip 2
  if x == 8 and y == 4 then if z == 1 then Midi:note_on(58, 60, 6) end end -- track 8 clip 3
  if x == 8 and y == 5 then if z == 1 then Midi:note_on(59, 60, 6) end end -- track 8 clip 4
  if x == 8 and y == 6 then if z == 1 then Midi:note_on(60, 60, 6) end end -- track 8 -------
  if x == 8 and y == 7 then if z == 1 then Midi:note_on(61, 60, 6) end end -- track 8 mute
  if x == 8 and y == 8 then if z == 1 then Midi:note_on(62, 60, 6) end end -- track 8 arm

  -- live play buttons
  for i = 1, 8 do
    if z == 1 then
      if y == 8 then if x == i + 8 then play_note(notes[i + 7]) end end
      if y == 7 then if x == i + 8 then play_note(notes[i + 10]) end end
      if y == 6 then if x == i + 8 then play_note(notes[i + 13]) end end
      if y == 5 then if x == i + 8 then play_note(notes[i + 16]) end end
      if y == 4 then if x == i + 8 then play_note(notes[i + 19]) end end
      if y == 3 then if x == i + 8 then play_note(notes[i + 22]) end end
      if y == 2 then if x == i + 8 then play_note(notes[i + 25]) end end
      if y == 1 then if x == i + 8 then play_note(notes[i + 28]) end end
    else
      if y == 8 then if x == i + 8 then stop_note(notes[i + 7]) end end
      if y == 7 then if x == i + 8 then stop_note(notes[i + 10]) end end
      if y == 6 then if x == i + 8 then stop_note(notes[i + 13]) end end
      if y == 5 then if x == i + 8 then stop_note(notes[i + 16]) end end
      if y == 4 then if x == i + 8 then stop_note(notes[i + 19]) end end
      if y == 3 then if x == i + 8 then stop_note(notes[i + 22]) end end
      if y == 2 then if x == i + 8 then stop_note(notes[i + 25]) end end
      if y == 1 then if x == i + 8 then stop_note(notes[i + 28]) end end
    end
  end
end

function grid_redraw()
  if grid_connected then -- only redraw if there's a grid connected
    g:all(0) -- turn all the LEDs off

    -- light up control buttons
    g:led(1,1,3) -- metronome
    g:led(3,1,6) -- play
    g:led(4,1,6) -- stop
    g:led(5,1,6) -- rec
    g:led(7,1,3) -- capture
    g:led(8,1,3) -- session rec

    g:led(1,2,2) -- track 1 clip 1
    g:led(1,3,2) -- track 1 clip 1
    g:led(1,4,2) -- track 1 clip 1
    g:led(1,5,2) -- track 1 clip 1
    g:led(1,6,0) -- track 1 -------
    g:led(1,7,2) -- track 1 mute
    g:led(1,8,2) -- track 1 arm

    g:led(2,2,2) -- track 2 clip 1
    g:led(2,3,2) -- track 2 clip 1
    g:led(2,4,2) -- track 2 clip 1
    g:led(2,5,2) -- track 2 clip 1
    g:led(2,6,0) -- track 2 -------
    g:led(2,7,2) -- track 2 mute
    g:led(2,8,2) -- track 2 arm

    g:led(3,2,2) -- track 3 clip 1
    g:led(3,3,2) -- track 3 clip 1
    g:led(3,4,2) -- track 3 clip 1
    g:led(3,5,2) -- track 3 clip 1
    g:led(3,6,0) -- track 3 -------
    g:led(3,7,2) -- track 3 mute
    g:led(3,8,2) -- track 3 arm

    g:led(4,2,2) -- track 4 clip 1
    g:led(4,3,2) -- track 4 clip 1
    g:led(4,4,2) -- track 4 clip 1
    g:led(4,5,2) -- track 4 clip 1
    g:led(4,6,0) -- track 4 -------
    g:led(4,7,2) -- track 4 mute
    g:led(4,8,2) -- track 4 arm

    g:led(5,2,2) -- track 5 clip 1
    g:led(5,3,2) -- track 5 clip 1
    g:led(5,4,2) -- track 5 clip 1
    g:led(5,5,2) -- track 5 clip 1
    g:led(5,6,0) -- track 5 -------
    g:led(5,7,2) -- track 5 mute
    g:led(5,8,2) -- track 5 arm

    g:led(6,2,2) -- track 6 clip 1
    g:led(6,3,2) -- track 6 clip 1
    g:led(6,4,2) -- track 6 clip 1
    g:led(6,5,2) -- track 6 clip 1
    g:led(6,6,0) -- track 6 -------
    g:led(6,7,2) -- track 6 mute
    g:led(6,8,2) -- track 6 arm

    g:led(7,2,2) -- track 7 clip 1
    g:led(7,3,2) -- track 7 clip 1
    g:led(7,4,2) -- track 7 clip 1
    g:led(7,5,2) -- track 7 clip 1
    g:led(7,6,0) -- track 7 -------
    g:led(7,7,2) -- track 7 mute
    g:led(7,8,2) -- track 7 arm

    g:led(8,2,2) -- track 8 clip 1
    g:led(8,3,2) -- track 8 clip 1
    g:led(8,4,2) -- track 8 clip 1
    g:led(8,5,2) -- track 8 clip 1
    g:led(8,6,0) -- track 8 -------
    g:led(8,7,2) -- track 8 mute
    g:led(8,8,2) -- track 8 arm

    -- light up live pads
    for x = 9,16 do
      for y = 1,8 do
        g:led(x,y,3)
        -- manually lighting roots
        g:led(9,1,6)
        g:led(16,1,6)
        g:led(12,2,6)
        g:led(15,3,6)
        g:led(11,4,6)
        g:led(14,5,6)
        g:led(10,6,6)
        g:led(13,7,6)
        g:led(9,8,6)
        g:led(16,8,6)
      end
    end
  end
  g:refresh()
end

function redraw()
  screen.clear()
  screen.color(180, 255, 252, 0.8)
  screen.move(20, 20)
  screen.text('Ableton control surface')
  screen.color(236, 195, 216, 0.8)
  screen.move(20, 40)
  screen.text('Note played: ' .. note_display_name)

  screen.refresh()
end

function grid_redraw_clock() -- our grid redraw clock
  while true do -- while it's running...
    clock.sleep(1/30) -- refresh at 30fps.
    if grid_dirty then -- if a redraw is needed...
      grid_redraw() -- redraw...
      grid_dirty = false -- redraw...
    end
    if screen_dirty then -- if a redraw is needed...
      redraw() -- redraw...
      screen_dirty = false -- then redraw is no longer needed.
    end
  end
end


function grid.add(new_grid) -- must be grid.add, not g.add (this is a function of the grid class)
  print(new_grid.name.." says 'hello!'")
   -- each grid added can be queried for device information:
  print("new grid found at port: "..new_grid.port)
  g = grid.connect(new_grid.port) -- connect script to the new grid
  grid_connected = true -- a grid has been connected!
  grid_dirty = true -- enable flag to redraw grid, because data has changed
end

function grid.remove(g) -- must be grid.remove, not g.remove (this is a function of the grid class)
  print(g.name.." says 'goodbye!'")
  grid_connected = false -- a grid has been connected!
end


cleanup = function ()
  g:all(0)
  g:refresh()
end
