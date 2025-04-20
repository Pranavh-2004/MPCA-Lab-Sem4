/*
Assignment question 3:
CPU task scheduling affects cache locality (keeping frequently used data in cache). Implement a task
scheduler that optimizes CPU cache utilization. Use a priority queue to schedule tasks while
maximizing cache hits.
Expected Outcome: A program that simulates task scheduling with cache-aware strategies. Improved
CPU efficiency by reducing cache misses. Comparison of FIFO and LRU scheduling policies
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>
#include <string.h>

#define NUM_TASKS 20
#define BLOCKS_PER_TASK 4
#define MEMORY_BLOCKS 50
#define CACHE_SIZE 10

typedef struct
{
    int task_id;
    int data_blocks[BLOCKS_PER_TASK];
} Task;

// ---------- FIFO Cache ----------
typedef struct
{
    int queue[CACHE_SIZE];
    bool present[MEMORY_BLOCKS];
    int front, rear, size;
} FIFOCache;

void initFIFOCache(FIFOCache *cache)
{
    cache->front = cache->rear = cache->size = 0;
    for (int i = 0; i < MEMORY_BLOCKS; i++)
        cache->present[i] = false;
}

bool accessFIFOCache(FIFOCache *cache, int block)
{
    if (cache->present[block])
        return true;
    if (cache->size == CACHE_SIZE)
    {
        int evicted = cache->queue[cache->front];
        cache->present[evicted] = false;
        cache->front = (cache->front + 1) % CACHE_SIZE;
        cache->size--;
    }
    cache->queue[cache->rear] = block;
    cache->present[block] = true;
    cache->rear = (cache->rear + 1) % CACHE_SIZE;
    cache->size++;
    return false;
}

// ---------- LRU Cache ----------
typedef struct Node
{
    int block;
    struct Node *next, *prev;
} Node;

typedef struct
{
    Node *head, *tail;
    bool present[MEMORY_BLOCKS];
    int size;
} LRUCache;

void initLRUCache(LRUCache *cache)
{
    cache->head = cache->tail = NULL;
    cache->size = 0;
    for (int i = 0; i < MEMORY_BLOCKS; i++)
        cache->present[i] = false;
}

void moveToEnd(LRUCache *cache, Node *node)
{
    if (node == cache->tail)
        return;
    if (node == cache->head)
        cache->head = node->next;
    if (node->prev)
        node->prev->next = node->next;
    if (node->next)
        node->next->prev = node->prev;

    node->next = NULL;
    node->prev = cache->tail;
    if (cache->tail)
        cache->tail->next = node;
    cache->tail = node;
}

bool accessLRUCache(LRUCache *cache, int block)
{
    if (cache->present[block])
    {
        Node *curr = cache->head;
        while (curr && curr->block != block)
            curr = curr->next;
        moveToEnd(cache, curr);
        return true;
    }
    if (cache->size == CACHE_SIZE)
    {
        Node *toRemove = cache->head;
        cache->present[toRemove->block] = false;
        cache->head = toRemove->next;
        if (cache->head)
            cache->head->prev = NULL;
        free(toRemove);
        cache->size--;
    }
    Node *newNode = malloc(sizeof(Node));
    newNode->block = block;
    newNode->next = NULL;
    newNode->prev = cache->tail;
    if (cache->tail)
        cache->tail->next = newNode;
    cache->tail = newNode;
    if (!cache->head)
        cache->head = newNode;
    cache->present[block] = true;
    cache->size++;
    return false;
}

// ---------- Task Generation ----------
void generateTasks(Task tasks[])
{
    for (int i = 0; i < NUM_TASKS; i++)
    {
        tasks[i].task_id = i;
        for (int j = 0; j < BLOCKS_PER_TASK; j++)
        {
            tasks[i].data_blocks[j] = rand() % MEMORY_BLOCKS;
        }
    }
}

// ---------- Simulation ----------
void runSimulation(Task tasks[], const char *policy)
{
    int hits = 0, misses = 0;

    printf("\n-- %s Policy --\n", policy);

    if (strcmp(policy, "FIFO") == 0)
    {
        FIFOCache cache;
        initFIFOCache(&cache);
        for (int i = 0; i < NUM_TASKS; i++)
        {
            printf("Task %2d: ", tasks[i].task_id);
            for (int j = 0; j < BLOCKS_PER_TASK; j++)
            {
                int block = tasks[i].data_blocks[j];
                bool hit = accessFIFOCache(&cache, block);
                printf("[Block %2d: %s] ", block, hit ? "HIT" : "MISS");
                if (hit)
                    hits++;
                else
                    misses++;
            }
            printf("\n");
        }
    }
    else
    {
        LRUCache cache;
        initLRUCache(&cache);
        for (int i = 0; i < NUM_TASKS; i++)
        {
            printf("Task %2d: ", tasks[i].task_id);
            for (int j = 0; j < BLOCKS_PER_TASK; j++)
            {
                int block = tasks[i].data_blocks[j];
                bool hit = accessLRUCache(&cache, block);
                printf("[Block %2d: %s] ", block, hit ? "HIT" : "MISS");
                if (hit)
                    hits++;
                else
                    misses++;
            }
            printf("\n");
        }
    }

    printf("Cache Hits: %d\n", hits);
    printf("Cache Misses: %d\n", misses);
}

// ---------- Main ----------
int main()
{
    srand(42);
    Task tasks[NUM_TASKS];
    generateTasks(tasks);

    printf("=== Task Scheduler Cache Locality Simulation ===\n");
    printf("Total Tasks: %d, Cache Size: %d\n", NUM_TASKS, CACHE_SIZE);

    runSimulation(tasks, "FIFO");
    runSimulation(tasks, "LRU");

    return 0;
}