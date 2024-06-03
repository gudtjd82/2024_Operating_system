#include <stdio.h>
#include <pthread.h>

int shared_resource = 0;

#define NUM_ITERS 1000
#define NUM_THREADS 100

volatile int flag[NUM_THREADS];
volatile int turn[NUM_THREADS-1];

void lock(int);
void unlock(int);


void lock(int tid)
{
    for (int i = 0; i < NUM_THREADS - 1; ++i) 
    {
        flag[tid] = i + 1;
        turn[i] = tid;
        for (int other = 0; other < NUM_THREADS; ++other) {
            if (other == tid) continue;
            while (!(flag[other] < flag[tid] || turn[i] != tid));
        }
    }
}

void unlock(int tid)
{
    flag[tid] = 0;
}

void* thread_func(void* arg) {
    int tid = *(int*)arg;
    
    lock(tid);
    
        for(int i = 0; i < NUM_ITERS; i++)    shared_resource++;
    
    unlock(tid);
    
    pthread_exit(NULL);
}

int main() {
    int n = NUM_THREADS;
    pthread_t threads[n];
    int tids[n];

    for (int i = 0; i < n; i++) {
        tids[i] = i;
        pthread_create(&threads[i], NULL, thread_func, &tids[i]);
    }
    
    for (int i = 0; i < n; i++) {
        pthread_join(threads[i], NULL);
    }

    printf("shared: %d\n", shared_resource);
    
    return 0;
}
