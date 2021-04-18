// D Language first test

import std.stdio;
import std.file;
import std.string;
import utils;
import core.sys.posix.unistd;

void main(string[] argv)
{
		auto argc = cast(int) argv.length - 1;
		if (argc >= 1)
		{
			argc = 0;
			while (++argc < argv.length)
			{
				if (exists(argv[argc]))
				{
					//File file = File(argv[argc], "r");
					runFile(argv[argc]);
				}
				else
					write("Warning : The file \"", argv[argc],
							"\" is either non-existent or you don't have credentials\n");
			}
		}
		else
		runInline();
}
