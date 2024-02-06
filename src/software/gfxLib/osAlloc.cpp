
#include "osAlloc.h"

tosAllocMemoryNodes	osAllocMemoryNodes;


ulong osAllocInit()
{
	ulong i;

	for( i = 0; i < _OS_ALLOC_NUM_NODES; i++ )
	{
		osAllocMemoryNodes.nodes[i].flags 			= _OS_ALLOC_NODE_DISABLED;
		osAllocMemoryNodes.nodes[i].blockBitmap		= NULL;
		osAllocMemoryNodes.nodes[i].blockBitmapSize	= 0;
		osAllocMemoryNodes.nodes[i].allocStart		= NULL;
		osAllocMemoryNodes.nodes[i].allocEnd		= NULL;
		osAllocMemoryNodes.nodes[i].totalBlocksNum	= 0;
	}

	return 0;
}

ulong osAllocAddNode( ulong nodeNumber, void *allocStart, ulong memorySize, ulong nodeFlags )
{
	ulong i;
	long long li;

	tosAllocMemoryNode *node;


	if( nodeNumber >= _OS_ALLOC_NUM_NODES )
	{
		return 1;
	}

	node = &osAllocMemoryNodes.nodes[nodeNumber];

	//calculate number of memory blocks
	node->totalBlocksNum	= ( memorySize / _OS_ALLOC_BLOCK_SIZE );

	//block bitmap goes first
	node->blockBitmap		= (uchar*)allocStart;


	//calculate block bitmap size
	node->blockBitmapSize  =  node->totalBlocksNum;

	//set alloc start
	node->allocStart       = (void*)( (uchar*)node->blockBitmap + node->blockBitmapSize );

	//align alloc start to block boundary
	li = (long long)node->allocStart;

	if( li % _OS_ALLOC_BLOCK_SIZE )
	{
		li += _OS_ALLOC_BLOCK_SIZE;
	}

	li = li / _OS_ALLOC_BLOCK_SIZE;
	li = li * _OS_ALLOC_BLOCK_SIZE;

	node->allocStart = (void*)li;

	//calculate alloc end
	node->allocEnd = (void*)( (uchar*) allocStart + memorySize );


	//update total blocks num - now with bitmap allocated and memory aligned to block size
	node->totalBlocksNum = ( (uchar*)node->allocEnd - (uchar*)node->allocStart ) / _OS_ALLOC_BLOCK_SIZE;


	//update alloc end according to blocks num
	node->allocEnd = (void*)( (uchar*)node->allocStart + ( node->totalBlocksNum * _OS_ALLOC_BLOCK_SIZE ) );

	//mark all blocks as free in bitmap
	for( i = 0; i < node->totalBlocksNum; i++ )
	{
		node->blockBitmap[i] = _OS_ALLOC_BLOCK_FREE;
	}


	return 0;
}

void *osAlloc( ulong size, ulong memFlags )
{

	ulong	 numBlocksToAlloc;
	long	 freeBlockNum;
	ulong    freeBlocksInChunk;
	void    *rv;

	ulong 	 i;
	ulong    j;

	tosAllocMemoryNode *node;

	//todo: do proper node search instead of this stub
	if( memFlags & OS_ALLOC_MEMF_FAST )
	{
		node = &osAllocMemoryNodes.nodes[1];
	}
	else
	{
		node = &osAllocMemoryNodes.nodes[0];		
	}


	//cals amount blocks to allocate

	if( size % _OS_ALLOC_BLOCK_SIZE )
	{
		size += _OS_ALLOC_BLOCK_SIZE;
	}

	size = size / _OS_ALLOC_BLOCK_SIZE;

	numBlocksToAlloc = size;

	freeBlockNum = -1;

	for( i = 0; i < node->totalBlocksNum ; i++ )
	{


		if( freeBlockNum == -1 )
		{
			//we haven't found anything free yet

			if( node->blockBitmap[i] == _OS_ALLOC_BLOCK_FREE )
			{
				//we have a free block, store its number

				freeBlockNum = i;
			}
		}

		if( freeBlockNum != -1 )
		{

			//ok we've got a free block, now check if there is enough space in chunk

			if( node->blockBitmap[i] == _OS_ALLOC_BLOCK_FREE )
			{
				freeBlocksInChunk = ( i - freeBlockNum ) + 1;

				if( freeBlocksInChunk >= numBlocksToAlloc )
				{
					//we have it, now alloc memory


					for( j = freeBlockNum; j < i; j++ )
					{
					  node->blockBitmap[j] = _OS_ALLOC_BLOCK_TAKEN;
					}
					node->blockBitmap[i] = _OS_ALLOC_LAST_BLOCK_TAKEN;

					//calc allocated memory address
					rv = (void*)( (uchar*)node->allocStart + ( freeBlockNum * _OS_ALLOC_BLOCK_SIZE ) );

					return rv;

				}

			}
			else
			{
				//chunk too small, forget start index

				freeBlockNum = -1;

			}

		}


	}


	//nothing found, return null
	return NULL;
}

ulong osFree( void *allocMemPtr )
{
	ulong 				 blockNumToFree;
	ulong 				 i;
	tosAllocMemoryNode	*node;
	ushort				 nodeFound;

	//find node

	nodeFound = 0;

	for( i = 0; i < _OS_ALLOC_NUM_NODES; i++ )
	{
		node = &osAllocMemoryNodes.nodes[i];
		
		if( ( allocMemPtr >= node->allocStart ) && ( allocMemPtr <= node->allocEnd ) )
		{
			//we've got the right node
			nodeFound = 1;
			break;
		}
	}

	if( !nodeFound )
	{
		//can't find node for given address
		return 1;
	}



	blockNumToFree = ( (uchar*)allocMemPtr - (uchar*)node->allocStart ) / _OS_ALLOC_BLOCK_SIZE;

	if( blockNumToFree >= node->totalBlocksNum )
	{
		//address outside alloc pool
		return 1;
	}

	for( i = blockNumToFree; i < node->totalBlocksNum; i++ )
	{
		if( node->blockBitmap[i] == _OS_ALLOC_BLOCK_FREE )
		{

			//trying to free free memory
			return 2;

		}else if( node->blockBitmap[i] == _OS_ALLOC_LAST_BLOCK_TAKEN )
		{
			//end of alloc chunk

			//mark as free
			node->blockBitmap[i] = _OS_ALLOC_BLOCK_FREE;

			//return
			return 0;
		}
		else
		{
			//mark as free and check next block
			node->blockBitmap[i] = _OS_ALLOC_BLOCK_FREE;
		}

	}


	return 0;
}

