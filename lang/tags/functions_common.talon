tag: user.code_functions_common
-
toggle funk: user.code_toggle_functions()
funk <user.code_common_function>: user.code_insert_function(code_common_function, "")
funk cell <number>: user.code_select_function(number - 1, "")
funk wrap <user.code_common_function>:
    user.code_insert_function(code_common_function, edit.selected_text())
funk wrap <number_small>: user.code_select_function(number_small - 1, edit.selected_text())
