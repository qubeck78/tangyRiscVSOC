#ifndef _OSALLOC_H
#define _OSALLOC_H

#include "gfTypes.h"

#define _OS_ALLOC_NUM_NODES			2

#define _OS_ALLOC_BLOCK_SIZE    	256

#define _OS_ALLOC_BLOCK_FREE 		0x00

#define _OS_ALLOC_LAST_BLOCK_TAKEN	0x80
#define _OS_ALLOC_BLOCK_TAKEN 		0x81


#define _OS_ALLOC_NODE_DISABLED		0x00

#define OS_ALLOC_MEMF_ANY			0x03
#define OS_ALLOC_MEMF_CHIP			0x01
#define OS_ALLOC_MEMF_FAST			0x02



typedef struct _tosAllocMemoryNode
{
	ulong	flags;

	uchar   *blockBitmap;
	ulong    blockBitmapSize;

	void    *allocStart;
	void    *allocEnd;

	ulong 	 totalBlocksNum;


}tosAllocMemoryNode;

typedef struct _tosAllocMemoryNodes
{
	tosAllocMemoryNode	nodes[_OS_ALLOC_NUM_NODES];
}tosAllocMemoryNodes;


ulong	 osAllocInit();
ulong	 osAllocAddNode( ulong nodeNumber, void *allocStart, ulong memorySize, ulong nodeFlags );

void 	*osAlloc( ulong size, ulong memFlags );
ulong 	 osFree( void *allocMemPtr );



#endif


