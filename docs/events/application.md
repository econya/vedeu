# @title Vedeu Application Events

## Application Events

### `:\_goto\_`
Call a client application controller's action with parameters.

    Vedeu.trigger(:_goto_,
                  :your_controller,
                  :some_action,
                  { id: 7 })
    Vedeu.goto(:your_controller, :some_action, { id: 7 })
