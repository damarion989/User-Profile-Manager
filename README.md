# User-Profile-Manager

## Phase 1

A StatelessWidget does not manage changing state of its own. The favorite button needs a StatefulWidget because it remembers whether the star is selected. Calling setState tells Flutter to rebuild the button with the updated icon and color.

## Phase 2

GlobalKey<FormState> lets me access the form's state. Calling validate runs the validator for each field. If a validator returns an error message, Flutter updates the field to display it. If all fields pass, validate returns true and the confirmation appears. I also dispose of the text controller when the widget is removed.


## Phase 3

The saved username belongs in ProfileScreen because the form updates it and the banner displays it. Their shared parent passes the username to the banner and a callback to the form. The favorite state stays inside FavoriteButton because only that button needs it.