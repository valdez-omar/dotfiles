from datetime import datetime

# Color definitions
black = "#1e1e2e"
white = "#cdd6f4"
grey = "#6c7086"
red = "#f38ba8"
frost_green = "#94e2d5"
cyan = "#89dceb"
green = "#a6e3a1"
yellow = "#f9e2af"
blue = "#89b4fa"
magenta = "#d20f39"
orange = "#f9a989"

# App configuration
BACKGROUND = black
BAR_BACKGROUND = black
WORKSPACES_BACKGROUND = black
TODOS_BACKGROUND = black
BORDER_DIM = grey + " 50%"
BORDER_LIT = blue

BORDER_TITLE_DIM = grey
BORDER_TITLE_LIT = (white, blue)

SEARCH_COLOR = red
YANK_COLOR = blue
SAVE_ON_ESCAPE = False
USE_DATE_FIRST = True

DATE_FORMAT = "%d %h"
TIME_FORMAT = "%H:%M"


def get_status(status):
    return f" {status} "


def get_clock():
    return f"{datetime.now().time().strftime(' %X ')}"


bar = {
    "A": [(get_status, 0.1)],
    "C": [(get_clock, 1)],
}
