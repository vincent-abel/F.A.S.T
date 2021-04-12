// D Language first test

import std.stdio;
import std.file;
import std.string;
import utils;
import core.sys.posix.unistd;

void main(string[] argv)
{
	/*if (isatty(0))
	{*/
		auto argc = cast(int) argv.length - 1;
		if (argc >= 1)
		{
			argc = 0;
			while (++argc < argv.length)
			{
				if (exists(argv[argc]))
				{
					File file = File(argv[argc], "r");

					while (!file.eof())
					{
						parse(strip(file.readln()));
					}
				}
				else
					write("Warning : The file \"", argv[argc],
							"\" is either non-existent or you don't have credentials\n");
			}
		}
		else
		runInline();
/*			writeln("Usage : ./fast file1 file2 ... || cat something |./fast");
	}
	else
	{
		string line;
		while ((line = readln()) !is null)
			runInline(strip(line));
	}
	*/
}
