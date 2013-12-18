SECTIONS {
	output 0x08000000 :
	{
		*(.vectors);
		*(.text);
		*(.data);
	}
}
start = 0x08000000;
MEMORY {
	flash : ORIGIN = 0x08000000, LENGTH = 128K
}
