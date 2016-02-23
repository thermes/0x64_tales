#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <assert.h>
#include <stdint.h>

#define PHILOS 5
#define DELAY 5000
#define FOOD 50

void *philosopher (void *id);
void grab_chopstick (int,
		     int,
		     char *);
void down_chopsticks (int,
		      int);
int food_on_table ();
int get_token ();
void return_token ();

pthread_mutex_t chopstick[PHILOS];
pthread_t philo[PHILOS];
pthread_mutex_t food_lock;
pthread_mutex_t num_can_eat_lock;
int sleep_seconds = 0;
uint32_t num_can_eat = PHILOS - 1;


int
main (int argn,
      char **argv)
{
    int i;

    pthread_mutex_init (&food_lock, NULL);
    pthread_mutex_init (&num_can_eat_lock, NULL);
    for (i = 0; i < PHILOS; i++)
	pthread_mutex_init (&chopstick[i], NULL);
    for (i = 0; i < PHILOS; i++)
	pthread_create (&philo[i], NULL, philosopher, (void *)(int64_t)i);
    for (i = 0; i < PHILOS; i++)
	pthread_join (philo[i], NULL);
    return 0;
}

void *
philosopher (void *num)
{
    int id;
    int i, left_chopstick, right_chopstick, f;

		id = (intptr_t)num;
    printf ("Philosopher %d is done thinking and now ready to eat.\n", id);
    right_chopstick = id;
    left_chopstick = id + 1;

    /* 箸が一巡した */
    if (left_chopstick == PHILOS)
	left_chopstick = 0;

    while (f = food_on_table ()) {
	get_token ();

	grab_chopstick (id, right_chopstick, "right ");
	grab_chopstick (id, left_chopstick, "left");

	printf ("Philosopher %d: eating.\n", id);
	usleep (DELAY * (FOOD - f + 1));
	down_chopsticks (left_chopstick, right_chopstick);

	return_token ();
    }

    printf ("Philosopher %d is done eating.\n", id);
    return (NULL);
}

int
food_on_table ()
{
    static int food = FOOD;
    int myfood;

    pthread_mutex_lock (&food_lock);
    if (food > 0) {
	food--;
    }
    myfood = food;
    pthread_mutex_unlock (&food_lock);
    return myfood;
}

void
grab_chopstick (int phil,
		int c,
		char *hand)
{
    pthread_mutex_lock (&chopstick[c]);
    printf ("Philosopher %d: got %s chopstick %d\n", phil, hand, c);
}

void
down_chopsticks (int c1,
		 int c2)
{
    pthread_mutex_unlock (&chopstick[c1]);
    pthread_mutex_unlock (&chopstick[c2]);
}


int
get_token ()
{
    int successful = 0;

    while (!successful) {
	pthread_mutex_lock (&num_can_eat_lock);
	if (num_can_eat > 0) {
	    num_can_eat--;
	    successful = 1;
	}
	else {
	    successful = 0;
	}
	pthread_mutex_unlock (&num_can_eat_lock);
    }
}

void
return_token ()
{
    pthread_mutex_lock (&num_can_eat_lock);
    num_can_eat++;
    pthread_mutex_unlock (&num_can_eat_lock);
}
