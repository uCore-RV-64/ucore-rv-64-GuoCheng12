#ifndef LOADER_H
#define LOADER_H

#include "const.h"
<<<<<<< HEAD
#include "proc.h"
=======
>>>>>>> ch4
#include "types.h"

int finished();
void loader_init();
<<<<<<< HEAD
int load_init_app();
int loader(int, struct proc *);
int get_id_by_name(char *);
=======
int run_all_app();
>>>>>>> ch4

#define BASE_ADDRESS (0x1000)
#define USTACK_SIZE (PAGE_SIZE)
#define KSTACK_SIZE (PAGE_SIZE)
#define TRAP_PAGE_SIZE (PAGE_SIZE)

#endif // LOADER_H