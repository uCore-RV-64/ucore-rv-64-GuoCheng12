#ifndef PROC_H
#define PROC_H

#include "types.h"
#define MAX_SYSCALL_NUM 500
#define NPROC (16)
#include "syscall_ids.h"

// Saved registers for kernel context switches.
struct context {
	uint64 ra;
	uint64 sp;

	// callee-saved
	uint64 s0;
	uint64 s1;
	uint64 s2;
	uint64 s3;
	uint64 s4;
	uint64 s5;
	uint64 s6;
	uint64 s7;
	uint64 s8;
	uint64 s9;
	uint64 s10;
	uint64 s11;
};

enum procstate { UNUSED, USED, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };
enum TaskStatus {
    TASK_UNINIT,
    TASK_RUNABLE,
    TASK_RUNNING,
    TASK_EXITED
};

// Per-process state
struct proc {
	enum procstate state; // Process state
	int pid; // Process ID
	uint64 ustack; // Virtual address of user stack
	uint64 kstack; // Virtual address of kernel stack
	struct trapframe *trapframe; // data page for trampoline.S
	struct context context; // swtch() here to run process
	/*
	* LAB1: you may need to add some new fields here
	*/ // task status 
	
	unsigned int syscall_times[MAX_SYSCALL_NUM]; 
    uint64 total_runtime; 
};

/*
* LAB1: you may need to define struct for TaskInfo here
*/

typedef struct TaskInfo {
    enum TaskStatus status;
    unsigned int syscall_times[MAX_SYSCALL_NUM];
    int time; 
} TaskInfo;

struct proc *curr_proc();
void exit(int);
void proc_init();
void scheduler() __attribute__((noreturn));
void sched();
void yield();
struct proc *allocproc();
// swtch.S
void swtch(struct context *, struct context *);

#endif // PROC_H