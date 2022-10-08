#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define V 4
#define MAXWT 100
#define inf 999

__global__ void closestNode(int *node_dist,int *visited_node,int* global_closest)
{
	int dist = inf+1;
	int node = -1;
    int i;

    for (i = 0; i < V; i++) {
        if ((node_dist[i] < dist) && (visited_node[i] != 1)) {
            dist = node_dist[i];
            node = i;
        }
    }

    global_closest[0] = node;
    visited_node[node] = 1;
}
__global__ void relax(int *graph,int *node_dist,int* parent_node,int* visited_node,int* global_closest)
{
    int next = threadIdx.x;
    int source = global_closest[0];

    int edge = graph[source*V + next];
    int new_dist = node_dist[source] + edge;

    if ((edge != 0) &&
        (visited_node[next] != 1) &&
        (new_dist < node_dist[next])) {
        node_dist[next] = new_dist;
        parent_node[next] = source;
    }

}

void bellman_ford(int *graph,int k,int edge[][2],int *node_dist,int *parent_node)
{
    int i,u,v,j,origin=0,flag=1;
    //printf("origin = %d\n",origin);
    node_dist[origin]=0;
    for(i=0;i<V-1;i++)
    {
        for(j=0;j<k;j++)
        {
            u = edge[j][0];
            v = edge[j][1];
            if(node_dist[u]+graph[u*V+v] < node_dist[v])
            {   node_dist[v] = node_dist[u] + graph[u*V+v];
                parent_node[v]=u ;
            }
        }
    }
    for(j=0;j<k;j++)
    {
            u = edge[j][0];
            v = edge[j][1] ;
            if(node_dist[u]+graph[u*V+v] < node_dist[v])
                flag = 0 ;
    }
   /* if(flag)
        for(i=0;i<V;i++)
            printf("Vertex %d cost = %d parent = %d\n",i,node_dist[i],parent_node[i]);*/

}

int main()
{
	int graph_size = V*V*sizeof(int);
	int int_array = V*sizeof(int);
	//int data_array = VERTICES*sizeof(int);
	//int *graph = (int *)malloc(graph_size);
	int *node_dist = (int *)malloc(int_array);
	int *parent_node = (int *)malloc(int_array);
	int *visited_node = (int *)malloc(int_array);

	//int *pnmatrix = (int *)malloc(int_array);
	//int *distmatrix = (int *)malloc(int_array);

	int graph[V*V]={0,-5,2,3,0,0,4,0,0,0,0,1,0,0,0,0};
	/*0 -5 2 3
	  0 0 4 0
	  0 0 0 1
	  0 0 0 0
	 */
	int edge[20][2]={0};
	int i,j,k=0;

	double ts;
	clock_t t1,t2;
	for(i=0;i<V;i++)
    {
        for(j=0;j<V;j++)
        {
            if(graph[i*V+j]!=0)
            {
                edge[k][0]=i;
                edge[k++][1]=j;
            }
        }
    }
	printf("graph adjacency matrix:\n");
    for(i=0;i<V;i++)
    {
        for(j=0;j<V;j++)
        {
            printf("%d ",graph[i*V+j]);
        }
        printf("\n");
    }
    printf("\n");
    for(i=0;i<k;i++)
    {
        printf("%d %d\n",edge[i][0],edge[i][1]);
    }

	printf("Variables created, allocated.\n");

	int *gpu_graph,*gpu_node_dist,*gpu_parent,*gpu_visited;
	cudaMalloc((void **)&gpu_graph,graph_size);
	cudaMalloc((void **)&gpu_node_dist,int_array);
	cudaMalloc((void **)&gpu_parent,int_array);
	cudaMalloc((void **)&gpu_visited,int_array);
	int *closest_vertex = (int*)malloc(sizeof(int));
	int* gpu_closest_vertex;
    closest_vertex[0] = -1;
    cudaMalloc((void **)&gpu_closest_vertex,sizeof(int));
    cudaMemcpy(gpu_closest_vertex,closest_vertex,sizeof(int),cudaMemcpyHostToDevice);

    for(i=0;i<V;i++)
    {
    	node_dist[i]=inf;
    	parent_node[i]=-1;
    	visited_node[i]=0;
    }

	printf("Variables initialized.\n");

	int origin = 0;
	printf("origin = %d\n",origin);

	t1=clock();
	bellman_ford(graph,k,edge,node_dist,parent_node);

	printf("modified graph:\n");
	for(i=0;i<V;i++)
    {
    	for(j=0;j<V;j++)
    	{
    		if(graph[i*V+j]!=0)
    		{graph[i*V+j] = graph[i*V+j] + node_dist[i] - node_dist[j];}
    		printf("%d ",graph[i*V+j]);
    	}
    	printf("\n");
    }
	t2=clock();
	ts=((double)t2-t1)/CLOCKS_PER_SEC;
    /*for(i=0;i<V;i++)
	{
		printf("%d %d %d\n",i,node_dist[i],parent_node[i]);
	}*/
    for(i=0;i<V;i++)
    {
    	node_dist[i]=inf;
    	parent_node[i]=-1;
    	visited_node[i]=0;
    }

	cudaEvent_t start,stop;
	float t;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);
	node_dist[origin]=0;

	cudaMemcpy(gpu_graph,graph,graph_size,cudaMemcpyHostToDevice);
	cudaMemcpy(gpu_node_dist,node_dist,int_array,cudaMemcpyHostToDevice);
	cudaMemcpy(gpu_parent,parent_node,int_array,cudaMemcpyHostToDevice);
	cudaMemcpy(gpu_visited,visited_node,int_array,cudaMemcpyHostToDevice);

	dim3 ngrid(1,1,1);
	dim3 nblock(V,1,1);

	cudaEventRecord(start);
	for(i=0;i<V;i++)
	{
		closestNode<<<1,1>>>(gpu_node_dist,gpu_visited,gpu_closest_vertex);
		relax<<<ngrid,nblock>>>(gpu_graph,gpu_node_dist,gpu_parent,gpu_visited,gpu_closest_vertex);
	}
	cudaEventRecord(stop);

	cudaMemcpy(node_dist, gpu_node_dist, int_array, cudaMemcpyDeviceToHost);
	cudaMemcpy(parent_node,gpu_parent,int_array,cudaMemcpyDeviceToHost);
	cudaMemcpy(visited_node,gpu_visited,int_array, cudaMemcpyDeviceToHost);
	/*for (i = 0; i < V; i++)
	{
        pnmatrix[i] = parent_node[i];
        distmatrix[i] = node_dist[i];
    }*/
	printf("\n");
	for(i=0;i<V;i++)
	{
		printf("%d %d\n",i,node_dist[i]);
	}

    cudaFree(gpu_graph);
    cudaFree(gpu_node_dist);
    cudaFree(gpu_parent);
    cudaFree(gpu_visited);


    printf("vertices = %d\n",V);
    cudaEventElapsedTime(&t,start,stop);
    printf("CUDA Time (ms): %f\n",t);
    ts=ts*1000;
    printf("full code time (s): %f\n",ts+t);
	return 0;
}

