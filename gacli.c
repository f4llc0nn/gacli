#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "cfgfile.h"
#include "verf.h"
#include "codegen.h"
#define USAGE "See README at https://github.com/0xleone/gacli\n"

/*-----------------------------------------------------------------*/
int main(int argc, char *argv[]) {
  if (argc > 2) {
    printf(USAGE);
    return 1;
  }

  char key_from_file[17];
  char *key;
  int verf_code;

  if(argc == 1) {
    key = (load_key(get_config_filename(".gacli"), key_from_file, sizeof(key_from_file)) == 0) ? key_from_file : NULL;
  }
  else {
    key = (load_key(argv[1], key_from_file, sizeof(key_from_file)) == 0) ? key_from_file : NULL;
  }

  if ((key == NULL) || (verf_key_len(key) == 1)) {
    printf(USAGE);
    return 1;
  }

  verf_code = gen_verf_code(key, time(0) / 30);
  printf("%6.6d\n", verf_code);

  return EXIT_SUCCESS;
}
