# Event singletons

Signals are awesome but require some awkward code to get children to reference the parent to emit the vice-versa. A convenient design pattern is to create global singleton event busses, which are scripts that only contain signal definitions and you autoload them as a global singleton in via the autoload feature in the project settings. Godot will automatically create a global singleton for you and scripts can easily access these.



### Connecting a callback to a global signal in a script

If you want a node to do something when the signal is emitted, you have to connect a callback/function to the event at runtime. Typically, you do this in the `_ready` function to assure that the callback is connected once initialization is finished. (Assuming we name the singleton `Event`)  

```gdscript
func _ready():
    Event.connect("signal_name", self, "_on_Event_callback_name")
```



### Firing the signal from a script

If you want your node to be able to emit the signal (aka trigger the event), you add code in your particular node's script to emit the signal from the singleton. 

```gdscript
Event.emit_signal("signal_name")
```





Follows a lot of the pattern written by: https://www.gdquest.com/tutorial/godot/design-patterns/event-bus-singleton/