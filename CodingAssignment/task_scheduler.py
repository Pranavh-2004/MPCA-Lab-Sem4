"""
Assignment question 3:
CPU task scheduling affects cache locality (keeping frequently used data in cache). Implement a task
scheduler that optimizes CPU cache utilization. Use a priority queue to schedule tasks while
maximizing cache hits.
Expected Outcome: A program that simulates task scheduling with cache-aware strategies. Improved
CPU efficiency by reducing cache misses. Comparison of FIFO and LRU scheduling policies
"""

import random
from collections import deque, OrderedDict
import heapq

# ----- Task Definition -----
class Task:
    def __init__(self, task_id, data_blocks):
        self.task_id = task_id
        self.data_blocks = data_blocks  # list of memory blocks (e.g., integers)

    def __repr__(self):
        return f"Task({self.task_id}, {self.data_blocks})"

# ----- Cache Simulators -----
class FIFOCache:
    def __init__(self, size):
        self.size = size
        self.cache = deque()
        self.cache_set = set()

    def access(self, block):
        if block in self.cache_set:
            return True  # hit
        if len(self.cache) == self.size:
            evicted = self.cache.popleft()
            self.cache_set.remove(evicted)
        self.cache.append(block)
        self.cache_set.add(block)
        return False  # miss

class LRUCache:
    def __init__(self, size):
        self.size = size
        self.cache = OrderedDict()

    def access(self, block):
        if block in self.cache:
            self.cache.move_to_end(block)
            return True  # hit
        if len(self.cache) == self.size:
            self.cache.popitem(last=False)  # remove least recently used
        self.cache[block] = True
        return False  # miss

# ----- Task Generator -----
def generate_tasks(num_tasks=20, num_blocks=50, blocks_per_task=4):
    tasks = []
    for i in range(num_tasks):
        accessed_blocks = random.sample(range(num_blocks), blocks_per_task)
        tasks.append(Task(i, accessed_blocks))
    return tasks

# ----- Cache-Aware Scheduling -----
def score_task(task, cache_blocks):
    return sum(1 for b in task.data_blocks if b in cache_blocks)

def schedule_tasks(tasks, cache_type="FIFO", cache_size=10):
    if cache_type == "FIFO":
        cache = FIFOCache(cache_size)
    else:
        cache = LRUCache(cache_size)

    total_hits = 0
    total_misses = 0

    # Priority Queue based on cache locality score
    task_queue = []
    for task in tasks:
        current_cache_blocks = cache.cache if cache_type == "FIFO" else cache.cache.keys()
        overlap = score_task(task, current_cache_blocks)
        heapq.heappush(task_queue, (-overlap, task.task_id, task))

    while task_queue:
        _, _, task = heapq.heappop(task_queue)
        for block in task.data_blocks:
            if cache.access(block):
                total_hits += 1
            else:
                total_misses += 1

    return total_hits, total_misses

# ----- Main Execution -----
def main():
    random.seed(42)  # for reproducibility

    # Configuration
    NUM_TASKS = 20
    BLOCKS_PER_TASK = 4
    MEMORY_BLOCKS = 50
    CACHE_SIZE = 10

    tasks = generate_tasks(NUM_TASKS, MEMORY_BLOCKS, BLOCKS_PER_TASK)

    # FIFO Strategy
    hits_fifo, misses_fifo = schedule_tasks(tasks, "FIFO", CACHE_SIZE)

    # LRU Strategy
    hits_lru, misses_lru = schedule_tasks(tasks, "LRU", CACHE_SIZE)

    # Results
    print("=== Task Scheduler Cache Locality Simulation ===")
    print(f"Total Tasks: {NUM_TASKS}, Cache Size: {CACHE_SIZE}")
    print("\n-- FIFO Policy --")
    print(f"Cache Hits: {hits_fifo}")
    print(f"Cache Misses: {misses_fifo}")

    print("\n-- LRU Policy --")
    print(f"Cache Hits: {hits_lru}")
    print(f"Cache Misses: {misses_lru}")

    print("\n-- Comparison --")
    diff = hits_lru - hits_fifo
    print(f"LRU had {abs(diff)} {'more' if diff > 0 else 'fewer'} cache hits than FIFO.")

if __name__ == "__main__":
    main()