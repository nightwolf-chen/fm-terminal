window.Pipe = new window.PipeServerClass(pipe_name)

# make sure this file is included after terminal.js
# then the window.T should be overrided 
class TerminalProxy 
        constructor: (@server_pipe) ->


        onCommand: (command) ->
                @t.exec(command)
                
        bind: (@t) ->
                @server_pipe.registerRPC("command", @onCommand.bind(@))
                window.T = @


        echo: (msg...) ->
                @server_pipe.fireRPC "echo", msg...
        set_prompt: (prompt...) ->
                @server_pipe.fireRPC "set_prompt", prompt...
        pause: () ->
                @server_pipe.fireRPC "pause"
        resume: () ->
                @server_pipe.fireRPC "resume"
        clear: () -> 
                @server_pipe.fireRPC "clear"

        init_ui: (song...) ->
                @server_pipe.fireRPC "init_ui", song...

        update_ui: (sound...) ->
                @server_pipe.fireRPC "update_ui", sound...
                
window.TerminalProxy ?= new TerminalProxy(window.Pipe)


notification = webkitNotifications.createNotification(
  'http://dev.chromium.org/_/rsrc/1302286216006/config/customLogo.gif?revision=2',
  'Hello!',  
  'Lorem ipsum...'  
)

notification.show()
