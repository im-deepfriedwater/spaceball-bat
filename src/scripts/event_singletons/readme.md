# Event singletons

Signals are awesome but require some awkward code to get children to reference the parent to emit the vice-versa. A convenient design pattern is to create global singleton event busses, which are scripts that only contain signal definitions and you autoload them as a global singleton in via the autoload feature in the project settings. Godot will automatically create a global singleton for you and scripts can easily access these.

### Connecting a callback to a global signal in a script

(assuming we name the singleton `Event`)

```gdscript
Event.connect("signal_name", self, "_on_Event_callback_name")
```



### Firing the signal from a script

```gdscript
Event.emit_signal("signal_name")
```



Follows a lot of the pattern written by: https://www.gdquest.com/tutorial/godot/design-patterns/event-bus-singleton/