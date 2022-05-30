from talon import actions, app

app.register("launch", lambda: actions.speech.disable())
