# @title Vedeu Focus Events

## Focus Events

Note: 'name' is a Symbol unless mentioned otherwise.

### `:\_focus_by_name\_`
When triggered with an interface name will focus that interface and
restore the cursor position and visibility.

    Vedeu.trigger(:_focus_by_name_, name) # or
    Vedeu.focus_by_name(name)

### `:\_focus_next\_`
When triggered will focus the next visible interface and restore the
cursor position and visibility.

    Vedeu.trigger(:_focus_next_) # or
    Vedeu.focus_next

### `:\_focus_prev\_`
When triggered will focus the previous visible interface and restore
the cursor position and visibility.

    Vedeu.trigger(:_focus_prev_) # or
    Vedeu.focus_previous
