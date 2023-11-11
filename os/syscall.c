#include "syscall.h"
<<<<<<< HEAD
#include "console.h"
=======
>>>>>>> ch4
#include "defs.h"
#include "loader.h"
#include "syscall_ids.h"
#include "timer.h"
#include "trap.h"

uint64 sys_write(int fd, uint64 va, uint len)
{
<<<<<<< HEAD
	debugf("sys_write fd = %d str = %x, len = %d", fd, va, len);
=======
	debugf("sys_write fd = %d va = %x, len = %d", fd, va, len);
>>>>>>> ch4
	if (fd != STDOUT)
		return -1;
	struct proc *p = curr_proc();
	char str[MAX_STR_LEN];
	int size = copyinstr(p->pagetable, str, va, MIN(len, MAX_STR_LEN));
	debugf("size = %d", size);
	for (int i = 0; i < size; ++i) {
		console_putchar(str[i]);
	}
	return size;
}

<<<<<<< HEAD
uint64 sys_read(int fd, uint64 va, uint64 len)
{
	debugf("sys_read fd = %d str = %x, len = %d", fd, va, len);
	if (fd != STDIN)
		return -1;
	struct proc *p = curr_proc();
	char str[MAX_STR_LEN];
	for (int i = 0; i < len; ++i) {
		int c = consgetc();
		str[i] = c;
	}
	copyout(p->pagetable, va, str, len);
	return len;
}

=======
>>>>>>> ch4
__attribute__((noreturn)) void sys_exit(int code)
{
	exit(code);
	__builtin_unreachable();
}

uint64 sys_sched_yield()
{
	yield();
	return 0;
}

<<<<<<< HEAD
uint64 sys_gettimeofday(uint64 val, int _tz)
{
	struct proc *p = curr_proc();
	uint64 cycle = get_cycle();
	TimeVal t;
	t.sec = cycle / CPU_FREQ;
	t.usec = (cycle % CPU_FREQ) * 1000000 / CPU_FREQ;
	copyout(p->pagetable, val, (char *)&t, sizeof(TimeVal));
	return 0;
}

uint64 sys_getpid()
{
	return curr_proc()->pid;
}

uint64 sys_getppid()
{
	struct proc *p = curr_proc();
	return p->parent == NULL ? IDLE_PID : p->parent->pid;
}

uint64 sys_clone()
{
	debugf("fork!\n");
	return fork();
}

uint64 sys_exec(uint64 va)
{
	struct proc *p = curr_proc();
	char name[200];
	copyinstr(p->pagetable, name, va, 200);
	debugf("sys_exec %s\n", name);
	return exec(name);
}

uint64 sys_wait(int pid, uint64 va)
{
	struct proc *p = curr_proc();
	int *code = (int *)useraddr(p->pagetable, va);
	return wait(pid, code);
}

uint64 sys_spawn(uint64 va)
{
	// TODO: your job is to complete the sys call
	return -1;
}

uint64 sys_set_priority(long long prio){
    // TODO: your job is to complete the sys call
    return -1;
}


=======
uint64 sys_gettimeofday(TimeVal *val, int _tz) // TODO: implement sys_gettimeofday in pagetable. (VA to PA)
// ch4

{

	/* The code in `ch3` will leads to memory bugs*/
	TimeVal val_im;
	struct proc *p = curr_proc();
	uint64 cycle = get_cycle();
	val_im.sec = cycle / CPU_FREQ;
	val_im.usec = (cycle % CPU_FREQ) * 1000000 / CPU_FREQ;


	return copyout(p->pagetable, (uint64)val, (char *)&val_im, sizeof(*val));
}

// TODO: add support for mmap and munmap syscall.
int mmap(void* start, unsigned long long len, int port, int flag, int fd){

	if (len == 0){
		return 0;
	}
	//port & ~0x7 == 0，port 其他位必须为 0 / port & 0x7 != 0，不可读不可写不可执行的内存无意义
	if ((port & ~0x7) != 0){
		return -1;
	}
	if ((port & 0x7) == 0){
		return -1;
	}
	// no memory
	if (len > ((uint64)1 << 30)) {
		return -1;
	}
	if (((uint64)start & (PAGE_SIZE - 1)) != 0){
		return -1;
	}
	len = PGROUNDUP(len);
	uint64 tail = (uint64)start + len;
	pagetable_t pg = curr_proc()->pagetable;
	
	for(uint64 st = (uint64)start; st != tail; st += PAGE_SIZE){
		void *pa = kalloc();
		if(pa == 0){
			return -1;
		}
		// careful PET_U
		if(mappages(pg, st, PAGE_SIZE, (uint64)pa, (port << 1) | PTE_U) != 0){
			return -1;
		}
	}
	return 0;
}
// hint: read through docstrings in vm.c. Watching CH4 video may also help.
// Note the return value and PTE flags (especially U,X,W,R)
/*
* LAB1: you may need to define sys_task_info here
*/
int sys_task_info(TaskInfo *ti)
{
	struct proc *proc_ptr = curr_proc();
	TaskInfo ti_impl;
	ti_impl.status = Running;
	memmove(ti_impl.syscall_times, proc_ptr->syscall_times,
			sizeof(ti_impl.syscall_times));
	uint64 diff = get_cycle() - proc_ptr->total_runtime;
	ti_impl.time = (int)(diff / (CPU_FREQ / 1000));
	return copyout(proc_ptr->pagetable, (uint64)ti, (char *)&ti_impl,
		       sizeof(*ti));
}

int munmap(void* start, unsigned long long len){
	if(len == 0){
		return 0;
	}
	// no memory
	if (len > ((uint64)1 << 30)) {
		return -1;
	}
	if (((uint64)start & (PAGE_SIZE - 1)) != 0){
		return -1;
	}
	// 按页对其
	len = PGROUNDUP(len);
	uint64 end = (uint64)start + len;
	pagetable_t pg = curr_proc()->pagetable;
	uint64 st = 0;
	for(st = (uint64)start; st != end; st+=PAGE_SIZE){
		uint64 pa = walkaddr(pg, st);
		if(pa == 0){
			return -1;
		}
		uvmunmap(pg, st, 1, 1);
	}
	return 0;
}
>>>>>>> ch4
extern char trap_page[];

void syscall()
{
<<<<<<< HEAD
	struct trapframe *trapframe = curr_proc()->trapframe;
	int id = trapframe->a7, ret;
=======
	struct proc *proc_ptr = curr_proc();
	struct trapframe *trapframe = curr_proc()->trapframe;
	int id = trapframe->a7, ret;

>>>>>>> ch4
	uint64 args[6] = { trapframe->a0, trapframe->a1, trapframe->a2,
			   trapframe->a3, trapframe->a4, trapframe->a5 };
	tracef("syscall %d args = [%x, %x, %x, %x, %x, %x]", id, args[0],
	       args[1], args[2], args[3], args[4], args[5]);
<<<<<<< HEAD
=======
	if (id < MAX_SYSCALL_NUM) {
        ++proc_ptr->syscall_times[id]; 
    }
	/*
	* LAB1: you may need to update syscall counter for task info here
	*/

	
>>>>>>> ch4
	switch (id) {
	case SYS_write:
		ret = sys_write(args[0], args[1], args[2]);
		break;
<<<<<<< HEAD
	case SYS_read:
		ret = sys_read(args[0], args[1], args[2]);
		break;
=======
>>>>>>> ch4
	case SYS_exit:
		sys_exit(args[0]);
		// __builtin_unreachable();
	case SYS_sched_yield:
		ret = sys_sched_yield();
		break;
	case SYS_gettimeofday:
<<<<<<< HEAD
		ret = sys_gettimeofday(args[0], args[1]);
		break;
	case SYS_getpid:
		ret = sys_getpid();
		break;
	case SYS_getppid:
		ret = sys_getppid();
		break;
	case SYS_clone: // SYS_fork
		ret = sys_clone();
		break;
	case SYS_execve:
		ret = sys_exec(args[0]);
		break;
	case SYS_wait4:
		ret = sys_wait(args[0], args[1]);
		break;
	case SYS_spawn:
		ret = sys_spawn(args[0]);
		break;
=======
		ret = sys_gettimeofday((TimeVal *)args[0], args[1]);
		break;
	// LAB2:
	case SYS_mmap:
		ret = mmap((void *)args[0], (uint64)args[1], (int)args[2], (int)args[3], (int)args[4]);
		break;
	case SYS_munmap:
		ret = munmap((void *)args[0], (uint64)args[1]);
		break;
	/*
	* LAB1: you may need to add SYS_taskinfo case here
	*/
	case SYS_task_info:
		ret = sys_task_info((TaskInfo *)args[0]);
        break;
>>>>>>> ch4
	default:
		ret = -1;
		errorf("unknown syscall %d", id);
	}
	trapframe->a0 = ret;
	tracef("syscall ret %d", ret);
}
