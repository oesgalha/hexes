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
mrb_curses_shutdown(mrb_state *mrb, mrb_value self)
{
  endwin();
  return self;
}

static mrb_value
mrb_curses_refresh(mrb_state *mrb, mrb_value self)
{
  refresh();
  return self;
}

static mrb_value
mrb_draw_panel(mrb_state *mrb, mrb_value self)
{
  char* panel_title;
  mrb_int x, y, w, h;
  mrb_get_args(mrb, "ziiii", &panel_title, &x, &y, &w, &h);
  
  move(y, x);
  addch(ACS_ULCORNER);
  int i, j = 1;
  addch (ACS_HLINE);
  for (i = 0; i < strlen(panel_title); i++) {
    addch(panel_title[i]);
    j++;
  }

  for ( ;  j < w;  j++) {
    addch (ACS_HLINE);
  }
  addch (ACS_URCORNER);   // upper right

  for(j = 0; j < h; j++) {
    move(y+1+j, x );
    addch(ACS_VLINE);
    move(y+1+j, x+w+1 );
    addch(ACS_VLINE);
  }

  move(y+h+1,x);
  addch(ACS_LLCORNER);   // lower left corner

  for(j = 0;  j < w;  ++j)
      addch(ACS_HLINE);
  addch(ACS_LRCORNER);   // lower right
  return self;
}

void
mrb_hexes_gem_init(mrb_state* mrb) {
  struct RClass *curses_module = mrb_define_module(mrb, "Curses");
  mrb_define_class_method(mrb, curses_module, "initialize", mrb_curses_initialize, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, curses_module, "shutdown", mrb_curses_shutdown, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, curses_module, "refresh", mrb_curses_refresh, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, curses_module, "draw_panel", mrb_draw_panel, MRB_ARGS_REQ(5));
}

void
mrb_hexes_gem_final(mrb_state* mrb) {
  
}
