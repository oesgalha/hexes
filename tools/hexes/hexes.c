#include <stdio.h>
#include <mruby.h>
#include <mruby/compile.h>

int
main(int argc, char **argv)
{

  if (argc != 2) {
    printf("No file ):");
  }

  FILE *hexConf;
  hexConf = fopen(argv[1], "r");
  if (hexConf != NULL) {
    mrb_state *mrb = mrb_open();
    if (!mrb) { /* handle error */ }

    mrb_value v;

    v = mrb_load_file(mrb, hexConf);
    
    if (mrb->exc) {
      if (!mrb_undef_p(v)) {
        mrb_print_error(mrb);
      }
    }

    mrb_close(mrb);
    fclose (hexConf);
  }
  return 0;
}
