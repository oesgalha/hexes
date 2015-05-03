#include "mruby.h"
#include <ncurses.h>
#include <unistd.h>
#include <string.h>

static mrb_value
mrb_curses_initialize(mrb_state *mrb, mrb_value self)
{
  initscr();
  noecho();
  curs_set(FALSE);
  return self;
}

static mrb_value
mrb_curses_move(mrb_state *mrb, mrb_value self)
{
  mrb_int x, y;
  mrb_get_args(mrb, "ii", &x, &y);
  move(y, x);
  return self;
}

static mrb_value
mrb_curses_addchars(mrb_state *mrb, mrb_value self)
{
  size_t i;
  char* string;
  mrb_get_args(mrb, "z", &string);
  for (i = 0; i < strlen(string); i++) {
    addch(string[i]);
  }
  return self;
}

static mrb_value
mrb_curses_acs(mrb_state *mrb, mrb_value self)
{
  mrb_int idx;
  mrb_get_args(mrb, "i", &idx);
  switch(idx) {
    case 0:
      addch(ACS_ULCORNER);
      break;
    case 1:
      addch(ACS_URCORNER);
      break;
    case 2:
      addch(ACS_LLCORNER);
      break;
    case 3:
      addch(ACS_LRCORNER);
      break;
    case 4:
      addch(ACS_HLINE);
      break;
    case 5:
      addch(ACS_VLINE);
      break;
  }
  return self;
}

static mrb_value
mrb_curses_width(mrb_state *mrb, mrb_value self)
{
  mrb_int width, height;
  getmaxyx(stdscr, height, width);
  return mrb_fixnum_value(width);
}

static mrb_value
mrb_curses_height(mrb_state *mrb, mrb_value self)
{
  mrb_int width, height;
  getmaxyx(stdscr, height, width);
  return mrb_fixnum_value(height);
}

static mrb_value
mrb_curses_refresh(mrb_state *mrb, mrb_value self)
{
  refresh();
  return self;
}

static mrb_value
mrb_curses_shutdown(mrb_state *mrb, mrb_value self)
{
  endwin();
  return self;
}

void
mrb_hexes_gem_init(mrb_state* mrb) {
  struct RClass *curses_module = mrb_define_module(mrb, "Curses");

  mrb_define_const(mrb, curses_module, "ULCORNER", mrb_fixnum_value(0));
  mrb_define_const(mrb, curses_module, "URCORNER", mrb_fixnum_value(1));
  mrb_define_const(mrb, curses_module, "LLCORNER", mrb_fixnum_value(2));
  mrb_define_const(mrb, curses_module, "LRCORNER", mrb_fixnum_value(3));
  mrb_define_const(mrb, curses_module, "HLINE", mrb_fixnum_value(4));
  mrb_define_const(mrb, curses_module, "VLINE", mrb_fixnum_value(5));

  mrb_define_class_method(mrb, curses_module, "initialize", mrb_curses_initialize, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, curses_module, "refresh", mrb_curses_refresh, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, curses_module, "move", mrb_curses_move, MRB_ARGS_REQ(2));
  mrb_define_class_method(mrb, curses_module, "type", mrb_curses_addchars, MRB_ARGS_REQ(1));
  mrb_define_class_method(mrb, curses_module, "type_special", mrb_curses_acs, MRB_ARGS_REQ(1));
  mrb_define_class_method(mrb, curses_module, "width", mrb_curses_width, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, curses_module, "height", mrb_curses_height, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, curses_module, "shutdown", mrb_curses_shutdown, MRB_ARGS_NONE());  
}

void
mrb_hexes_gem_final(mrb_state* mrb) {
  
}
