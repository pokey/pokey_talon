control mouse: user.mouse_toggle_control_mouse()
zoom mouse: user.mouse_toggle_zoom_mouse()
camera overlay: user.mouse_toggle_camera_overlay()
run calibration: user.mouse_calibrate()
touch:
	mouse_click(0)
	# close the mouse grid if open
	user.grid_close()
    	# End any open drags
	# Touch automatically ends left drags so this is for right drags specifically
	user.mouse_drag_end()

right click:
	mouse_click(1)
	# close the mouse grid if open
	user.grid_close()

midclick:
	mouse_click(2)
	# close the mouse grid
	user.grid_close()

#see keys.py for modifiers.
#defaults
#command
#control
#option = alt
#shift
#super = windows key
<user.modifiers> touch:
	key("{modifiers}:down")
	mouse_click(0)
	key("{modifiers}:up")
	# close the mouse grid
	user.grid_close()
<user.modifiers> righty:
	key("{modifiers}:down")
	mouse_click(1)
	key("{modifiers}:up")
	# close the mouse grid
	user.grid_close()
dubclick:
	mouse_click()
	mouse_click()
	# close the mouse grid
	user.grid_close()
(tripclick | triplick):
	mouse_click()
	mouse_click()
	mouse_click()
	# close the mouse grid
	user.grid_close()
left drag | drag:
	user.mouse_drag(0)
	# close the mouse grid
	user.grid_close()
right drag | righty drag:
	user.mouse_drag(1)
	# close the mouse grid
	user.grid_close()
end drag | drag end:
    user.mouse_drag_end()
(scroll | school) down: user.mouse_scroll_down()
(scroll | school) down here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_down()
(scroll | school) tiny [down]: user.mouse_scroll_down(0.2)
(scroll | school) tiny [down] here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_down(0.2)
(scroll | school) downer: user.mouse_scroll_down_continuous()
(scroll | school) downer here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_down_continuous()
(scroll | school) up: user.mouse_scroll_up()
(scroll | school) up here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_up()
(scroll | school) tiny up: user.mouse_scroll_up(0.2)
(scroll | school) tiny up here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_up(0.2)
(scroll | school) upper: user.mouse_scroll_up_continuous()
(scroll | school) upper here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_up_continuous()
(scroll | school) gaze: user.mouse_gaze_scroll()
(scroll | school) gaze here:
    user.mouse_move_center_active_window()
    user.mouse_gaze_scroll()
(scroll | school) stop: user.mouse_scroll_stop()
(scroll | school) stop here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_stop()
(scroll | school) left: user.mouse_scroll_left()
(scroll | school) left here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_left()
(scroll | school) tiny left: user.mouse_scroll_left(0.5)
(scroll | school) tiny left here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_left(0.5)
(scroll | school) right: user.mouse_scroll_right()
(scroll | school) right here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_right()
(scroll | school) tiny right: user.mouse_scroll_right(0.5)
(scroll | school) tiny right here:
    user.mouse_move_center_active_window()
    user.mouse_scroll_right(0.5)
copy mouse position: user.copy_mouse_position()
curse no:
    # Command added 2021-12-13, can remove after 2022-06-01
    app.notify("Please activate the user.mouse_cursor_commands_enable tag to enable this command")
