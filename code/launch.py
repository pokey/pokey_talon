from talon import app, actions

app.register("launch", lambda: actions.speech.disable())