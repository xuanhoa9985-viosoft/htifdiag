/*
 * diag.c
 *
 * Copyright (C) 2017, Viosoft Corp.
 */

#include "util.h"

#define HTIF_DEV_SHIFT      (56)
#define HTIF_CMD_SHIFT      (48)

extern void printstr(const char *);

#define HTIF_CMD_READ       (0x00UL)
#define HTIF_CMD_WRITE      (0x01UL)
#define HTIF_CMD_IDENTITY   (0xFFUL)

#define HTIF_NR_DEV         (256UL)

static inline void htif_tohost(unsigned long dev,
			       unsigned long cmd, unsigned long data)
{
	unsigned long packet;
	packet = (dev << HTIF_DEV_SHIFT) | (cmd << HTIF_CMD_SHIFT) | data;
	while (swap_csr(tohost, packet) != 0);
}

static inline unsigned long htif_fromhost(void)
{
	unsigned long data;
	while ((data = swap_csr(fromhost, 0)) == 0);
	return data;
}

int main(int argc, char **argv)
{
	printstr("htifdiag\n");

	htif_tohost(0, 0, 0);

	return 0;
}
