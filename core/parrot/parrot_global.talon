parrot(postalveolar_click): core.repeat_phrase(1)

parrot(dental_click): app.notify("dental")
parrot(labiodental_click): app.notify("labiodental")
parrot(sibilant): user.handle_sibilant(f0, f1, f2, power)
parrot(lateral_click): user.cancel_in_flight_phrase_loud()

# parrot(dental_click): "d"
# parrot(labiodental_click): "l"
# parrot(sibilant): "s"
# parrot(lateral_click): "x"
