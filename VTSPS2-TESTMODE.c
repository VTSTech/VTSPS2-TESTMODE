//Working Title: 'TESTMODE' Launcher
//Written by VTSTech (veritas@vts-tech.org)
//Version: 0.3

#include <debug.h>
#include <iopcontrol.h>
#include <iopheap.h>
#include <kernel.h>
#include <sifrpc.h>
#include <loadfile.h>
#include <unistd.h>

//thx sp193
void ResetIOP()
{
	SifInitRpc(0);
	while(!SifIopReset("", 0)){};
	while(!SifIopSync()){};
	SifInitRpc(0);
}

void InitPS2()
{
	init_scr();
	ResetIOP();
	SifInitIopHeap();
	SifLoadFileInit();
	fioInit();
}

void banner()
{
	scr_clear();
  sleep(1);
  scr_printf("===================================== \n");
  scr_printf("=VTSPS2-TESTMODE v0.3     12-22-2019= \n");
  scr_printf("=Written by VTSTech of PSX-Place.com= \n");
  scr_printf("=www.vts-tech.org==================== \n\n");	
}

int main(int argc, char *argv[], char **envp)
{
	InitPS2();
	banner();
	scr_printf("Launching rom0:TESTMODE in 3 seconds... \n");
	sleep(3);
	LoadExecPS2("rom0:TESTMODE", 0, NULL);
	return 0;
}
